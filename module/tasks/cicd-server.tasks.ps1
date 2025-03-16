# <copyright file="cicd-server.tasks.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

. $PSScriptRoot/cicd-server.properties.ps1

# Synopsis: Identifies which, if any, CI/CD platform is running the current process
task DetectCICDServer -If { !$SkipDetectCICDServer } -After InitCore {
    if ($env:TF_BUILD) {
        $script:IsRunningOnCICDServer = $true
        $script:IsAzureDevOps = $true
        Write-Build White "Azure Pipelines detected"
    }
    elseif ($env:GITHUB_ACTIONS) {
        $script:IsRunningOnCICDServer = $true
        $script:IsGitHubActions = $true
        Write-Build White "GitHub Actions detected"
    }
}

# Synopsis: Inform the DevOps agent of the current version number
task SetCICDServerBuildNumber -If {$IsRunningOnCICDServer -and !$SkipSetCICDServerBuildNumber} -After Version {
    if ($IsAzureDevOps) {
        Write-Host "Setting Azure Pipelines build number: $($GitVersion[$GitVersionComponentForBuildNumber])"
        Write-Host "##vso[build.updatebuildnumber]$($GitVersion[$GitVersionComponentForBuildNumber])"
    }
    elseif ($IsGitHubActions) {
        Write-Warning "Setting GitHub Actions workflow run number is not supported."
    }
}
