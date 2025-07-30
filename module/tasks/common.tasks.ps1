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


# Support the special InvokeBuild entry & exit actions in a way that allows
# extensions to register their own actions and have them run using this
# built-in InvokeBuild functionality.  This is primarily intended to support
# compensation scenarios in the event of terminating errors.
Enter-Build {
    if ($OnEnterActions.Count -gt 0) {
        Write-Build Green "Found $($OnEnterActions.Count) registered 'Enter-Build' action(s)"
        for ($i=0; $i -lt $OnEnterActions.Count; $i++) {
            Write-Build White "Running action $i"
            # Run action, no need to override the default 'ErrorAction' handling for the OnEnter actions
            Invoke-Command -ScriptBlock $OnEnterActions[$i]
        }
    }
}
Exit-Build {
    if ($OnExitActions.Count -gt 0) {
        Write-Build Green "Found $($OnExitActions.Count) registered 'Exit-Build' action(s)"
        for ($i=0; $i -lt $OnExitActions.Count; $i++) {
            Write-Build White "Running action $i"
            # Run the action, but ensure that any remaining actions are run even if the current one fails
            Invoke-Command -ScriptBlock $OnExitActions[$i] -ErrorAction Continue
        }
    }
}