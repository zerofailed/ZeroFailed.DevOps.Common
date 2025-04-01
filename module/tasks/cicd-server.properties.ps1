# <copyright file="cicd-server.properties.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

# Internal properties not intended for external modification
$IsRunningOnCICDServer = $false
$IsAzureDevOps = $false
$IsGitHubActions = $false

# Synopsis: When true, no DevOps agent detection will be attempted. Default is false.
$SkipDetectCICDServer = property ZF_SKIP_DETECT_CICD_SERVER $false
