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

## Build Lifecycle Hooks

This extension exposes two extensibility points — `OnEnterActions` and `OnExitActions` — that allow any ZeroFailed process or extension module to register scriptblocks that are automatically invoked at the very start and very end of a build, respectively. This is the recommended way to implement startup initialisation and teardown/compensation logic that should run regardless of whether the build succeeds or fails.

### InvokeBuild background

InvokeBuild provides two special hooks — [`Enter-Build`](https://github.com/nightroman/Invoke-Build/blob/main/README.md#enter-build-and-exit-build) and [`Exit-Build`](https://github.com/nightroman/Invoke-Build/blob/main/README.md#enter-build-and-exit-build) — that are called once per build run, outside of any task:

- **`Enter-Build`** runs once before the first task. Errors raised here will abort the build.
- **`Exit-Build`** runs once after the last task (or after an error), making it equivalent to a `finally` block for the entire build.

This extension's `common.tasks.ps1` defines these hooks and uses them to iterate the `$OnEnterActions` and `$OnExitActions` collections, meaning any registered actions are automatically invoked at the correct point without requiring consumers to define their own hooks.

### Properties

| Name             | Default Value | ENV Override | Description                                                                                                                  |
| ---------------- | ------------- | ------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| `OnEnterActions` | `@()`         |              | [Extensibility Point] A collection of scriptblocks run as part of InvokeBuild's `Enter-Build` hook at the start of a build. |
| `OnExitActions`  | `@()`         |              | [Extensibility Point] A collection of scriptblocks run as part of InvokeBuild's `Exit-Build` hook at the end of a build. All registered actions are run even if a previous one fails. |

### Functions

| Name                    | Description                                                                                                                          |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `Register-OnEnterAction` | Registers a scriptblock to be run as part of the `Enter-Build` hook. Safe to call from extension modules and build scripts.         |
| `Register-OnExitAction`  | Registers a scriptblock to be run as part of the `Exit-Build` hook. Safe to call from extension modules and build scripts.          |

### How to use in your own ZeroFailed process

#### Registering a simple scriptblock

Call `Register-OnEnterAction` or `Register-OnExitAction` with a scriptblock argument. The scriptblock will be queued and run at the appropriate point in the build lifecycle.

```powershell
# Run something at the start of every build
Register-OnEnterAction -Action {
    Write-Build White 'Initialising environment...'
    Set-SomeGlobalState
}

# Run cleanup unconditionally at the end of every build
Register-OnExitAction -Action {
    Write-Build White 'Cleaning up temporary resources...'
    Remove-TempResources
}
```

#### Running a nested build as an action

Actions are not limited to inline scriptblocks — you can invoke a full nested `Invoke-Build` run, allowing one or more InvokeBuild tasks to be used as lifecycle hooks. This is especially useful for extensions that ship their own task files.

```powershell
# Run a specific task from another build file as a startup action
Register-OnEnterAction -Action {
    Invoke-Build -File "$PSScriptRoot/my-extension.tasks.ps1" -Task MyStartupTask
}

# Run a cleanup task unconditionally at build exit
Register-OnExitAction -Action {
    Invoke-Build -File "$PSScriptRoot/my-extension.tasks.ps1" -Task MyCleanupTask
}
```

#### Registering from an extension module

When registering actions from within an extension module's task file, avoid referencing the  `OnEnterActions` / `OnExitActions` variables directly, instead using the helper functions to handle this as they apply additional safeguards.

```powershell
# In your extension's .tasks.ps1 file — preferred approach using the helper functions
Register-OnEnterAction -Action { & "$PSScriptRoot/_internal/startup.ps1" }
Register-OnExitAction  -Action { & "$PSScriptRoot/_internal/teardown.ps1" }
```

#### Error handling behaviour

| Hook            | Behaviour on error                                                                                       |
| --------------- | -------------------------------------------------------------------------------------------------------- |
| `Enter-Build`   | An unhandled error in any Enter action will **abort the build** (default PowerShell error handling).     |
| `Exit-Build`    | Each Exit action is called with `-ErrorAction Continue`, so **all registered actions always run**, even if a preceding action throws. Errors are reported but do not prevent subsequent actions from executing. |

#### Re-entrancy protection

When ZeroFailed executes a registered action it sets a guard variable (`$__RunningInEnterAction` or `$__RunningInExitAction`) in the action's child scope. The `Register-OnEnterAction` and `Register-OnExitAction` functions check for this variable and silently skip registration if it is set. This prevents infinite loops in the scenario where a nested `Invoke-Build` call inside an action would otherwise trigger a second round of action registration and execution.

