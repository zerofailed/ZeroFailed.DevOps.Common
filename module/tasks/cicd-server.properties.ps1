# <copyright file="cicd-server.properties.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

# Internal properties not intended for external modification
$IsRunningOnCICDServer = $false
$IsAzureDevOps = $false
$IsGitHubActions = $false

# Synopsis: When true, no DevOps agent detection will be attempted. Default is false.
$SkipDetectCICDServer = property ZF_SkipDetectCICDServer $false

# Synopsis: When true, the version number will not be sent to the DevOps agent. Default is false.
$SkipSetCICDServerBuildNumber = property ZF_SkipSetCICDServerBuildNumber $false

# Synopsis: Defines which of the GitVersion properties is used as the build server's build number. Default is "SemVer".
$GitVersionComponentForBuildNumber = property ZF_GitVersionComponentForBuildNumber "SemVer"