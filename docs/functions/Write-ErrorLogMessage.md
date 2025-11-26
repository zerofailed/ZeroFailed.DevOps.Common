---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 11/13/2025
PlatyPS schema version: 2024-05-01
title: Write-ErrorLogMessage
---

# Write-ErrorLogMessage

## SYNOPSIS

Writes an error message formatted for the appropriate CI/CD platform, when applicable.

## SYNTAX

### __AllParameterSets

```
Write-ErrorLogMessage [-Message] <string> [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

Writes an error message formatted for the appropriate CI/CD platform, when applicable.

## EXAMPLES

### EXAMPLE 1 - When running in Azure Pipelines

```
PS:> Write-ErrorLogMessage "Something bad happened!"
##[error]Something bad happened!
```

### EXAMPLE 2 - When running in GitHub Actions

```
PS:> Write-ErrorLogMessage "Something bad happened!"
::error::Something bad happened!
```

### EXAMPLE 3 - When running interactively

```
PS:> Write-ErrorLogMessage "Something bad happened!"
Write-Error: Something bad happened!
```

## PARAMETERS

### -Message

The error message to be logged.

```yaml
Type: System.String
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
