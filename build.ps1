#Requires -Version 7.1
<#
.SYNOPSIS
    Runs the ZeroFailed build process for this repository.
.PARAMETER ZfModulePath
    The path to import the ZeroFailed module from, instead of installing it. This is useful when testing a local
    copy of ZeroFailed.
.PARAMETER ZfModuleVersion
    The version of the ZeroFailed module to use, as an exact version (e.g. '1.0.7' or '1.1.0-preview0001')
    or a NuGet version range. The default range '[2.0.0, 3.0.0)' takes the newest 2.x release, so
    the build picks up new minor and patch releases but never a new major release.
    Pre-release versions are only used when the value itself contains a pre-release label.
.PARAMETER ZfModuleRepository
    The PowerShell repository to install the ZeroFailed module from: a registered repository name, or a URL. For a
    URL, a repository that is already registered with that URL (and any credentials it has) is used. Otherwise, the
    URL is registered as a new repository. The default is the ZeroFailed GitHub Packages feed. GitHub Packages needs
    a token, even for public packages: when the GITHUB_TOKEN or GH_TOKEN environment variable is set, it is used as
    the credential. If the module cannot be installed from this repository, it is installed from PSGallery.
.PARAMETER ZfExtensionsLockMode
    How the ZeroFailed extensions lock file is used. 'Write' resolves the extensions and updates the lock file.
    'Frozen' installs the versions in the lock file, and fails if the extensions differ from it. 'Off' does not
    use the lock file. Defaults to 'Frozen' in GitHub Actions, and to 'Write' elsewhere. The
    ZF_EXTENSIONS_LOCK_MODE environment variable takes precedence over this parameter.
.PARAMETER InvokeBuildModuleVersion
    The version of the InvokeBuild module to be used, as an exact version or a NuGet version range.
#>
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
    [string] $ZfModulePath,

    [Parameter()]
    [string] $ZfModuleVersion = "[2.0.0, 3.0.0)",

    [Parameter()]
    [string] $ZfModuleRepository = "https://nuget.pkg.github.com/zerofailed/index.json",

    [Parameter()]
    [ValidateSet("Write","Frozen","Off")]
    [string] $ZfExtensionsLockMode = ($env:GITHUB_ACTIONS -eq "true" ? "Frozen" : "Write"),

    [Parameter()]
    [string] $InvokeBuildModuleVersion = "5.14.23"
)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $PSCommandPath

#region InvokeBuild setup
# This handles calling the build engine when this file is run like a normal PowerShell script
# (i.e. avoids the need to have another script to setup the InvokeBuild environment and issue the 'Invoke-Build' command )
if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
    if (!(Get-InstalledPSResource InvokeBuild -Version $InvokeBuildModuleVersion -ErrorAction Ignore)) {
        # InvokeBuild is only published to PSGallery, which sometimes fails, so retry the install
        for ($attempt = 1; ; $attempt++) {
            try {
                Install-PSResource InvokeBuild -Version $InvokeBuildModuleVersion -Scope CurrentUser -TrustRepository -Repository PSGallery
                break
            }
            catch {
                if ($attempt -ge 3) { throw }
                Write-Warning "Could not install InvokeBuild $InvokeBuildModuleVersion (attempt $attempt of 3), so retrying: $($_.Exception.Message)"
                Start-Sleep -Seconds (5 * $attempt)
            }
        }
    }
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
$splat = @{ Force = $true; Verbose = $false}
if (!($ZfModulePath)) {
    # $ZfModuleVersion can be an exact version or a NuGet version range (e.g. '[2.0.0, 3.0.0)').
    # Pre-release versions are only considered when the value includes a pre-release label.
    $isVersionRange = $ZfModuleVersion -match '[\[\(,]'
    $allowPrerelease = $ZfModuleVersion -match '-'
    $getInstalledZfModule = {
        Get-InstalledPSResource ZeroFailed -Version $ZfModuleVersion -ErrorAction Ignore |
            Where-Object { $allowPrerelease -or !$_.Prerelease } |
            Sort-Object -Property Version -Descending |
            Select-Object -First 1
    }
    # An exact version that is already installed is used as it is. A range is always checked against the
    # repository, so that the build takes the newest release in the range.
    if ($isVersionRange -or !(& $getInstalledZfModule)) {
        # Support a repository URL, re-using any existing registration for it (and its credentials)
        if ($ZfModuleRepository -match '://') {
            $uri = $ZfModuleRepository
            $ZfModuleRepository = (Get-PSResourceRepository | ? Uri -eq $uri | Select-Object -First 1).Name ?? ($uri -replace '\W','_')
            $null = Get-PSResourceRepository $ZfModuleRepository -ErrorAction Ignore || Register-PSResourceRepository $ZfModuleRepository -Uri $uri
        }
        $installSplat = @{
            Name = 'ZeroFailed'
            Version = $ZfModuleVersion
            Repository = $ZfModuleRepository
            Prerelease = $allowPrerelease
            Scope = 'CurrentUser'
            TrustRepository = $true
        }
        # GitHub Packages needs a token to install any package, even a public one. In GitHub Actions, the
        # workflow's token is in GITHUB_TOKEN or GH_TOKEN, depending on the action that runs this script.
        $gitHubToken = $env:GITHUB_TOKEN ? $env:GITHUB_TOKEN : $env:GH_TOKEN
        if ($gitHubToken -and (Get-PSResourceRepository $ZfModuleRepository).Uri.Host -eq 'nuget.pkg.github.com') {
            $installSplat.Credential = [pscredential]::new('token', (ConvertTo-SecureString $gitHubToken -AsPlainText -Force))
        }
        # A range that the installed version already satisfies is checked on every run, so do not warn that it is installed
        $installZfModule = {
            Install-PSResource @installSplat -WarningAction SilentlyContinue -WarningVariable installWarnings
            $installWarnings | Where-Object Message -notlike '*is already installed*' | ForEach-Object { Write-Warning $_.Message }
        }
        try {
            try {
                & $installZfModule
            }
            catch {
                if ($ZfModuleRepository -eq 'PSGallery') { throw }
                Write-Warning "Could not install ZeroFailed $ZfModuleVersion from '$ZfModuleRepository', so trying PSGallery: $($_.Exception.Message)"
                $installSplat.Remove('Credential')
                $installSplat.Repository = 'PSGallery'
                & $installZfModule
            }
        }
        catch {
            # When a range cannot be checked (e.g. offline), use the newest installed version that satisfies it
            if (!(& $getInstalledZfModule)) { throw }
            Write-Warning "Could not check for a newer ZeroFailed module in the range $ZfModuleVersion, so using the installed version: $($_.Exception.Message)"
        }
    }
    # Import the newest installed version that satisfies $ZfModuleVersion, by its manifest's path. A package from
    # GitHub Packages is installed in a lower-case 'zerofailed' folder, which 'Import-Module ZeroFailed' does not find
    # on a case-sensitive file system (Linux).
    $installed = & $getInstalledZfModule
    if (!$installed) {
        throw "No installed version of the ZeroFailed module satisfies the version '$ZfModuleVersion'."
    }
    # The installed location is either the modules folder or the module's version folder
    $ZfModulePath = Join-Path $installed.InstalledLocation 'ZeroFailed.psd1'
    if (!(Test-Path $ZfModulePath)) {
        $ZfModulePath = Join-Path $installed.InstalledLocation $installed.Name $installed.Version.ToString() 'ZeroFailed.psd1'
    }
    if (!(Test-Path $ZfModulePath)) {
        throw "The ZeroFailed module manifest is not in the expected location: $ZfModulePath"
    }
}
else {
    Write-Host "ZfModulePath: $ZfModulePath"
}
$splat.Add("Name", $ZfModulePath)
# Ensure only 1 version of the module is loaded
Get-Module ZeroFailed | Remove-Module
Import-Module @splat
$ver = ("{0} {1}" -f (Get-Module ZeroFailed).Version, (Get-Module ZeroFailed).PrivateData.PsData.PreRelease).Trim()
Write-Host "Using ZeroFailed module version: $ver from $ZfModulePath"
#endregion

$PSModuleAutoloadingPreference = 'none'

# ZeroFailed reads the extensions lock mode from this variable, unless ZF_EXTENSIONS_LOCK_MODE is set
$zerofailedExtensionsLockMode = $ZfExtensionsLockMode

# Load the build configuration
. $here/.zf/config.ps1
