# <copyright file="common.properties.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

using namespace System.Collections.Generic

# Synopsis: When true, ZeroFailed will skip the check for a newer version of the ZeroFailed module. Default is false.
$SkipZeroFailedModuleVersionCheck = [Convert]::ToBoolean((property ZF_SKIP_ZEROFAILED_MODULE_VERSION_CHECK $false))

# Synopsis: When true, ZeroFailed will skip the check for whether the GitHub CLI is installed. Default is true.
$SkipEnsureGitHubCli = [Convert]::ToBoolean((property ZF_SKIP_ENSURE_GITHUB_CLI $true))

# Synopsis: A hashtable of PowerShell modules to install and import. The keys are the module names and the values are hashtables with the following properties: version, repository.
$RequiredPowerShellModules = property ZF_REQUIRED_PS_MODULES @{}

# Synopsis: A collection of scriptblocks that will be run as part of InvokeBuild's 'Enter-Build' functionality. Extensions and processes can register their own actions by calling `$script:OnEnterActions.Add($myScriptBlock)`.
$OnEnterActions = [List[scriptblock]]::new()

# Synopsis: A collection of scriptblocks that will be run as part of InvokeBuild's 'Exit-Build' functionality, typically used as a 'finally' block for the overall process.  Extensions and processes can register their own actions by calling `$script:OnExitActions.Add($myScriptBlock)`.
$OnExitActions = [List[scriptblock]]::new()