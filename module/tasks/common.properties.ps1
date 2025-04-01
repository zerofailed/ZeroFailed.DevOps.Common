# <copyright file="common.properties.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

# Synopsis: When true, ZeroFailed will skip the check for a newer version of the ZeroFailed module. Default is false.
$SkipZeroFailedModuleVersionCheck = property ZF_SKIP_ZEROFAILED_MODULE_VERSION_CHECK $false

# Synopsis: When true, ZeroFailed will skip the check for whether the GitHub CLI is installed. Default is false.
$SkipEnsureGitHubCli = property ZF_SKIP_ENSURE_GITHUB_CLI $false

# Synopsis: A hashtable of PowerShell modules to install and import. The keys are the module names and the values are hashtables with the following properties: version, repository.
$RequiredPowerShellModules = property ZF_REQUIRED_PS_MODULES @{}