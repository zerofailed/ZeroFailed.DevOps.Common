# <copyright file="common.properties.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

# Synopsis: When true, ZeroFailed will skip the check for a newer version of the ZeroFailed module. Default is false.
$SkipZeroFailedModuleVersionCheck = property ZF_SkipZeroFailedModuleVersionCheck $false

# Synopsis: When true, ZeroFailed will skip the check for whether the GitHub CLI is installed. Default is false.
$SkipEnsureGitHubCli = property ZF_SkipEnsureGitHubCli $false