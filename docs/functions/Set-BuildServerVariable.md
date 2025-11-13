---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 11/13/2025
PlatyPS schema version: 2024-05-01
title: Set-BuildServerVariable
---

# Set-BuildServerVariable

## SYNOPSIS

Abstracts sending formatted log messages to build servers to set build variables.

## SYNTAX

### __AllParameterSets

```
Set-BuildServerVariable [-Name] <string> [-Value] <Object> [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

Identifies the current build server using well-known environmnent variables and outputs correctly formatted log messages that will set variables within the build server context. Currently supports Azure Pipelines and GitHub Actions.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-BuildServerVariable -Name "MyVar" -Value "foo"
```

## PARAMETERS

### -Name

The name of the variable to set on the build server.

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

### -Value

The value of the variable to set on the build server.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
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
