# ZeroFailed.DevOps.Common - Reference Sheet

## CI/CD Server

This group contains functionality related to CI/CD platform integration, currently supports Azure DevOps and GitHub Actions.

### Properties

| Name                    | Default Value | ENV Override                 | Description                                                                                                                                |
| ----------------------- | ------------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `IsAzureDevOps`         | $false        |                              | Will be set to True when running in Azure DevOps (YAML pipeline or Classic release pipeline). ***NOTE**: Considered a read only property.* |
| `IsAzureDevOpsRelease`  | $false        |                              | Will be set to True when running in an Azure DevOps Classic release pipeline. ***NOTE**: Considered a read only property.*                 |
| `IsGitHubActions`       | $false        |                              | Will be set to True when running in a GitHub Actions workflow. ***NOTE**: Considered a read only property.*                                |
| `IsRunningOnCICDServer` | $false        |                              | Will be set to True when a supported CI/CD server platform is detected. ***NOTE**: Considered a read only property.*                       |
| `SkipDetectCICDServer`  | $false        | `ZF_SKIP_DETECT_CICD_SERVER` | When true, no DevOps agent detection will be attempted. Default is false.                                                                  |

### Tasks

| Name               | Description                                                             |
| ------------------ | ----------------------------------------------------------------------- |
| `DetectCICDServer` | Identifies which, if any, CI/CD platform is running the current process |

## Common

This group contains general purposes helper tasks, potentially useful for a wide range of DevOps processes.

### Properties

| Name                               | Default Value | ENV Override                              | Description                                                                                                                                                                                                                                                                      |
| ---------------------------------- | ------------- | ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `OnEnterActions`                   | @()           |                                           | [Extensibility Point] A collection of scriptblocks that will be run as part of InvokeBuild's 'Enter-Build' functionality. Extensions and processes can register their own actions by calling `$script:OnEnterActions.Add($myScriptBlock)`.                                                             |
| `OnExitActions`                    | @()           |                                           | [Extensibility Point] A collection of scriptblocks that will be run as part of InvokeBuild's 'Exit-Build' functionality, typically used as a 'finally' block for the overall process.  Extensions and processes can register their own actions by calling `$script:OnExitActions.Add($myScriptBlock)`. |
| `RequiredPowerShellModules`        | @{}           | `ZF_REQUIRED_PS_MODULES`                  | A hashtable of PowerShell modules to install and import. The keys are the module names and the values are hashtables with the following properties: version, repository.                                                                                                         |
| `SkipEnsureGitHubCli`              | $true         | `ZF_SKIP_ENSURE_GITHUB_CLI`               | When true, ZeroFailed will skip the check for whether the GitHub CLI is installed. Default is true.                                                                                                                                                                              |
| `SkipZeroFailedModuleVersionCheck` | $false        | `ZF_SKIP_ZEROFAILED_MODULE_VERSION_CHECK` | When true, ZeroFailed will skip the check for a newer version of the ZeroFailed module. Default is false.                                                                                                                                                                        |

### Tasks

| Name              | Description                                                                                                            |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `EnsureGitHubCli` | Checks that the GitHub CLI is installed and installs it if not.                                                        |
| `setupModules`    | Installs and imports the specified PowerShell modules. ***NOTE**: PowerShell repositories will be trusted by default.* |

