---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 09/10/2025
PlatyPS schema version: 2024-05-01
title: Test-AzCliConnection
---

# Test-AzCliConnection

## SYNOPSIS

Checks whether the current process is logged-in to the azure-cli with a valid access token.

## SYNTAX

### __AllParameterSets

```
Test-AzCliConnection [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

Returns true when a valid azure-cli access token is found, otherwise returns false.

## EXAMPLES

### EXAMPLE 1

```powershell
if (Test-AzCliConnection) { & az storage list } else { Write-Error "Please run 'az login'" }
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

The function returns true when a valid Azure CLI connection was found, otherwise returns false.

## NOTES

## RELATED LINKS

- []()
