# <copyright file="Edit-TokenizedFiles.Tests.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

BeforeAll {
    $here = Split-Path -Parent $PSCommandPath
    $sut = (Split-Path -Leaf $PSCommandPath) -replace ".Tests"
    
    . "$here\$sut"
    
    Mock Write-Host {}
    Mock Write-Verbose {}
}

Describe "Edit-TokenizedFiles Tests" {

    Context "Single File: Using the default TokenRegexPattern" {

        BeforeAll {
            $defaultTokenRegexPattern = "\#\{.*\}\#"

            $testJsonConfig = @"
{
    "settingA": "#{SETTING_A}#",
    "settingB": "B",
    "settingC": "#{SETTING_A}#__#{SETTING_B}#"
}    
"@
            $testJsonFile = "TestDrive:/test-config.json"
            Set-Content -Path $testJsonFile -Value $testJsonConfig
    
            $tokenValues = @{
                SETTING_A = "foo"
                SETTING_B = "bar"
            }
        }
        
        BeforeEach {
            Edit-TokenizedFiles -FilesToProcess @($testJsonFile) `
                                -TokenValuePairs $tokenValues
        }

        It "should parse the tokens in the target file correctly" {
            # Uses logging calls to verify execution behaviour

            # Messages for the 2 token replacements and the file save operation
            Should -Invoke Write-Host -Exactly 3

            # verify processing the correct number of tokens
            Should -Invoke Write-Verbose -ParameterFilter { $Message -eq "Checking for SETTING_A" } -Exactly 1
            Should -Invoke Write-Verbose -ParameterFilter { $Message -eq "Checking for SETTING_B" } -Exactly 1
            
            # verify expected tokens were processed
            Should -Invoke Write-Host -ParameterFilter { $Object.StartsWith("Patching 'SETTING_A'") } -Exactly 1
            Should -Invoke Write-Host -ParameterFilter { $Object.StartsWith("Patching 'SETTING_B'") } -Exactly 1

            # verify all tokens were found
            Should -Invoke Write-Verbose -ParameterFilter { $Message -eq "Token not found" } -Exactly 0
        }

        It "should replace the required token" {
            (Get-Content -Raw -Path $testJsonFile) -match $defaultTokenRegexPattern | Should -Be $false
        }

        It "should replace the required token with the correct value" {
            (Get-Content -Raw -Path $testJsonFile | ConvertFrom-Json).settingA | Should -Be "foo"
        }

        It "should handle multiple tokens referenced on the same line correctly" {
            (Get-Content -Raw -Path $testJsonFile | ConvertFrom-Json).settingC | Should -Be "foo__bar"
        }
    }
}