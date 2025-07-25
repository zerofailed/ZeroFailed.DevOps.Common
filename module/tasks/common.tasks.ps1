# <copyright file="common.tasks.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

. $PSScriptRoot/common.properties.ps1

# Synopsis: Checks that the GitHub CLI is installed and installs it if not.
task EnsureGitHubCli -If { !$SkipEnsureGitHubCli } -After InitCore {
    if (!(Get-Command gh -CommandType Application -ErrorAction SilentlyContinue)) {
        throw "The GitHub CLI is required - please install as per: https://github.com/cli/cli#installation"
    }

    # Test whether GitHub CLI is logged-in
    & gh auth status | Out-Null
    if ($LASTEXITCODE -eq 1) {
        throw "You must be logged-in to GitHub CLI to run this process. Please run 'gh auth login' to login and then re-run the build."
    }
}

# Synopsis: Installs and imports the specified PowerShell modules. ***NOTE**: PowerShell repositories will be trusted by default.*
task setupModules -If { $null -ne $RequiredPowerShellModules -and $RequiredPowerShellModules -ne @{} } -After InitCore {
    Install-PSResource -RequiredResource $RequiredPowerShellModules -Scope CurrentUser -TrustRepository | Out-Null
    $RequiredPowerShellModules.Keys | ForEach-Object { Import-Module $_ }
}
