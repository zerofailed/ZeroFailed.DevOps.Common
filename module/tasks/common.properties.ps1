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

# Synopsis: When false, the 'gilt' tool will be run if an associated configuration file can be found.
$SkipRunGilt = [Convert]::ToBoolean((property ZF_SKIP_RUN_GILT $false))

# Synopsis: The path to the 'gilt' configuration file.
$GiltConfigPath = property ZF_GILT_CONFIG_PATH (Join-Path $here 'Giltfile.yaml')

# Synopsis: The path to the 'gilt' tool.
$GiltPath = property ZF_GILT_TOOL_PATH 'gilt'

# Synopsis: The version of 'gilt' that will be installed when not already available.
$GiltVersion = property ZF_GILT_VERSION '2.2.4'

# Synopsis: When true, the 'gilt' tool will be installed even if it is already available.
$ForceInstallGilt = [Convert]::ToBoolean((property ZF_FORCE_INSTALL_GILT $false))

# Synopsis: [Extensibility Point] A collection of scriptblocks that will be run as part of InvokeBuild's 'Enter-Build' functionality. Extensions and processes can register their own actions by calling `$script:OnEnterActions.Add($myScriptBlock)`.
$OnEnterActions = [List[scriptblock]]::new()

# Synopsis: [Extensibility Point] A collection of scriptblocks that will be run as part of InvokeBuild's 'Exit-Build' functionality, typically used as a 'finally' block for the overall process.  Extensions and processes can register their own actions by calling `$script:OnExitActions.Add($myScriptBlock)`.
$OnExitActions = [List[scriptblock]]::new()