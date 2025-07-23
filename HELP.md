# ZeroFailed.DevOps.Common - Reference Sheet

## CI/CD Server

This group contains functionality related to CI/CD platform integration, currently supports Azure DevOps and GitHub Actions.

### Properties

| Name                  | Description                                                                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| IsAzureDevOps         | Will be set to True when running in Azure DevOps (YAML pipeline or Classic release pipeline). ***NOTE**: Considered a read only property.* |
| IsAzureDevOpsRelease  | Will be set to True when running in an Azure DevOps Classic release pipeline. ***NOTE**: Considered a read only property.*                 |
| IsGitHubActions       | Will be set to True when running in a GitHub Actions workflow. ***NOTE**: Considered a read only property.*                                |
| IsRunningOnCICDServer | Will be set to True when a supported CI/CD server platform is detected. ***NOTE**: Considered a read only property.*                       |
| SkipDetectCICDServer  | When true, no DevOps agent detection will be attempted. Default is false.                                                                  |

### Tasks

| Name             | Description                                                             |
| ---------------- | ----------------------------------------------------------------------- |
| DetectCICDServer | Identifies which, if any, CI/CD platform is running the current process |

## Common

This group contains general purposes helper tasks, potentially useful for a wide range of DevOps processes.

### Properties

| Name                             | Description                                                                                                                                                              |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| RequiredPowerShellModules        | A hashtable of PowerShell modules to install and import. The keys are the module names and the values are hashtables with the following properties: version, repository. |
| SkipEnsureGitHubCli              | When true, ZeroFailed will skip the check for whether the GitHub CLI is installed. Default is true.                                                                      |
| SkipZeroFailedModuleVersionCheck | When true, ZeroFailed will skip the check for a newer version of the ZeroFailed module. Default is false.                                                                |

### Tasks

| Name            | Description                                                                                                            |
| --------------- | ---------------------------------------------------------------------------------------------------------------------- |
| EnsureGitHubCli | Checks that the GitHub CLI is installed and installs it if not.                                                        |
| setupModules    | Installs and imports the specified PowerShell modules. ***NOTE**: PowerShell repositories will be trusted by default.* |
