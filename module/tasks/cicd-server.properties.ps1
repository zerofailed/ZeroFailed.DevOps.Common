# <copyright file="cicd-server.properties.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

# Internal properties not intended for external modification
$IsRunningOnCICDServer = $false
$IsAzureDevOps = $false
$IsGitHubActions = $false

# Synopsis: When true, no DevOps agent detection will be attempted. Default is false.
$SkipDetectCICDServer = property ZF_SKIP_DETECT_CICD_SERVER $false

# Synopsis: When true, the version number will not be sent to the DevOps agent. Default is false.
$SkipSetCICDServerBuildNumber = property ZF_SKIP_SET_CICD_SERVER_BUILDNUMBER $false

# Synopsis: Defines which of the GitVersion properties is used as the build server's build number. Default is "SemVer".
$GitVersionComponentForBuildNumber = property ZF_GITVERSION_COMPONENT_FOR_BUILDNUMBER "SemVer"