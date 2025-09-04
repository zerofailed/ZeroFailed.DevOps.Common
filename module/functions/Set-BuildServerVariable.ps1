# <copyright file="Set-BuildServerVariable.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

function Set-BuildServerVariable
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string] $Name,

        [Parameter(Mandatory=$true)]
        [AllowNull()]
        $Value
    )

    if ($env:TF_BUILD) {
        Write-Host "##vso[task.setvariable variable=$Name]$Value" -InformationAction Continue
    }
    elseif ($env:GITHUB_ACTIONS) {
        Write-Output "$Name=$Value" | Out-File -FilePath $env:GITHUB_OUTPUT -Encoding utf8 -Append
    }
}