# <copyright file="Edit-TokenizedFiles.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

function Edit-TokenizedFiles
{
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string[]] $FilesToProcess,
        [string] $TokenRegexFormatString = "\#\{{{0}\}}\#",     # the escaped curly brackets need to be doubled-up to work properly with the format string
        [hashtable] $TokenValuePairs
    )

    $configCache = @{}
    $FilesToProcess | ForEach-Object {
        Write-Verbose "Caching file: $_"
        $configCache += @{ 
            $_ = @{
                contents = (Get-Content -Raw $_)
                updated = $false
            }
        }
    }

    $TokenValuePairs.Keys | ForEach-Object {
        $token = $_
        $regexPattern = $TokenRegexFormatString -f $token
        Write-Verbose "Checking for $token"
        $configCache.Keys | ForEach-Object {
            if ($configCache[$_].contents -match $regexPattern) {
                Write-Host "Patching '$token' in '$_'"
                $configCache[$_].updated = $true
                $configCache[$_].contents = $configCache[$_].contents -replace $regexPattern,$TokenValuePairs[$token]
            }
            else {
                Write-Verbose "Token not found"
            }
        }
    }

    $configCache.Keys |
        Where-Object { $configCache[$_].updated } |
        ForEach-Object {
            if ($PSCmdlet.ShouldProcess($_)) {
                Write-Host "Saving '$_'"
                Set-Content -Path $_ `
                            -Value $configCache[$_].contents
            }
        }
}