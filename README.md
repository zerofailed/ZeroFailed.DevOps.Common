# ZeroFailed.DevOps.Common

[![Build Status](https://github.com/zerofailed/ZeroFailed.DevOps.Common/actions/workflows/build.yml/badge.svg)](https://github.com/zerofailed/ZeroFailed.DevOps.Common/actions/workflows/build.yml)  
[![GitHub Release](https://img.shields.io/github/release/zerofailed/ZeroFailed.DevOps.Common.svg)](https://github.com/zerofailed/ZeroFailed.DevOps.Common/releases)  
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Endjin.ZeroFailed.Build?color=blue)](https://www.powershellgallery.com/packages/ZeroFailed.DevOps.Common)  
[![License](https://img.shields.io/github/license/zerofailed/ZeroFailed.DevOps.Common.svg)](https://github.com/zerofailed/ZeroFailed.DevOps.Common/blob/main/LICENSE)  


A [ZeroFailed](https://github.com/zerofailed/ZeroFailed) extension containing general purpose features useful for a variety of DevOps processes.

## Overview

| Component Type | Included | Notes                                                                                                                                                                                                                                              |
| -------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Tasks          | yes      |                                                                                                                                                                                                                                                    |
| Functions      | yes      | [Function Reference](docs/functions.md)                                                                                                                                                                                                            |
| Processes      | no       | Designed to be compatible with upstream processes provided by the [ZeroFailed.Build.Common](https://github.com/zerofailed/ZeroFailed.Build.Common) & [ZeroFailed.Deploy.Common](https://github.com/zerofailed/ZeroFailed.Deploy.Common) extensions |

For more information about the different component types, please refer to the [ZeroFailed documentation](https://github.com/zerofailed/ZeroFailed/blob/main/README.md#extensions).

This extension consists of the following feature groups, refer to the [HELP page](./HELP.md) for more details.

- General purpose helper tasks
- CI/CD Server integration

The diagram below shows the discrete features and when they run as part of the default build process provided by [ZeroFailed.Build.Common](https://github.com/zerofailed/ZeroFailed.Build.Common).

```mermaid
kanban
    init
        ensureghcli[Ensure 'gh' cli installed]
    version
    build
    test
    analysis
    package
    publish
```

This diagram below shows the same for the default deployment process provided by [ZeroFailed.Deploy.Common](https://github.com/zerofailed/ZeroFailed.Deploy.Common).

```mermaid
kanban
    init
        ensureghcli[Ensure 'gh' cli installed]
    provision
    deploy
    test
```

## Dependencies

None.

***NOTE**: This extension is widely referenced and is typically the root dependency for other ZeroFailed extensions.*
