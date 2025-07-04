[CmdletBinding()]
param (
    [Parameter(Position=0)]
    [string[]] $Tasks = @("."),

    [Parameter()]
    [string] $Configuration = "Debug",

    [Parameter()]
    [string] $SourcesDir = $PWD,

    [Parameter()]
    [string] $PackagesDir = "_packages",

    [Parameter()]
    [ValidateSet("minimal","normal","detailed")]
    [string] $LogLevel = "minimal",

    [Parameter()]
    [string] $ZfModuleVersion = "1.0.6",

    [Parameter()]
    [version] $InvokeBuildModuleVersion = "5.12.1"
)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $PSCommandPath

#region InvokeBuild setup
# This handles calling the build engine when this file is run like a normal PowerShell script
# (i.e. avoids the need to have another script to setup the InvokeBuild environment and issue the 'Invoke-Build' command )
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
    Install-PSResource InvokeBuild -Version $InvokeBuildModuleVersion -Scope CurrentUser -TrustRepository | Out-Null
    try {
        Invoke-Build $Tasks $MyInvocation.MyCommand.Path @PSBoundParameters
    }
    catch {
        if ($env:GITHUB_ACTIONS) {
            Write-Host ("::error file={0},line={1},col={2}::{3}" -f `
                            $_.InvocationInfo.ScriptName,
                            $_.InvocationInfo.ScriptLineNumber,
                            $_.InvocationInfo.OffsetInLine,
                            $_.Exception.Message
                        )
        }
        Write-Host -f Yellow "`n`n***`n*** Build Failure Summary - check previous logs for more details`n***"
        Write-Host -f Yellow $_.Exception.Message
        Write-Host -f Yellow $_.ScriptStackTrace
        exit 1
    }
    return
}
#endregion

#region Initialise build framework
Import-Module Microsoft.PowerShell.PSResourceGet
Install-PSResource ZeroFailed -Version $ZfModuleVersion -Scope CurrentUser -TrustRepository | Out-Null
# Ensure only 1 version of the module is loaded
Get-Module ZeroFailed | Remove-Module
Import-Module ZeroFailed -RequiredVersion ($ZfModuleVersion -split '-')[0] -Force -Verbose:$false
$ver = "{0} {1}" -f (Get-Module ZeroFailed).Version, (Get-Module ZeroFailed).PrivateData.PsData.PreRelease
Write-Host "Using ZeroFailed module version: $ver"
#endregion

# Load the build configuration
. $here/.zf/config.ps1
