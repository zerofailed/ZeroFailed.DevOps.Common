---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 04/24/2026
PlatyPS schema version: 2024-05-01
title: Register-OnEnterAction
---

# Register-OnEnterAction

## SYNOPSIS

A helper function for consumers to register a PowerShell script block run as part of the InvokeBuild `Enter-Build` extensibility point.

## SYNTAX

### __AllParameterSets

```
Register-OnEnterAction [-Action] <scriptblock> [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

A helper function for consumers to register a PowerShell script block run as part of the InvokeBuild `Enter-Build` extensibility point.

## EXAMPLES

### Example 1 - Simple script block

Register-OnEnterAction -Action { Write-Build White 'Doing something' }

### Example 2 - Running a nested build

Register-OnEnterAction -Action { Invoke-Build -File my.tasks.ps1 -Task MyStartupTask }

## PARAMETERS

### -Action

A script block containing the functionality that should run as part of the InvokeBuild `Enter-Build` extensibility point.

```yaml
Type: System.Management.Automation.ScriptBlock
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Void

The function has no outputs.

## NOTES

## RELATED LINKS

- []()
