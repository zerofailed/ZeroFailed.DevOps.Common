---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 09/10/2025
PlatyPS schema version: 2024-05-01
title: Invoke-CommandWithRetry
---

# Invoke-CommandWithRetry

## SYNOPSIS

Provides retry logic for PowerShell ScriptBlock execution.

## SYNTAX

### __AllParameterSets

```
Invoke-CommandWithRetry [-Command] <scriptblock> [[-RetryCount] <int>] [[-RetryDelay] <int>]
 [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

Provides retry logic for PowerShell ScriptBlock execution.

## EXAMPLES

### EXAMPLE 1

```powershell
Invoke-CommandWithRetry -Command { Invoke-WebRequest https://somesite.com/unreliable-service } -RetryCount 3 -RetryDelay 10
```

## PARAMETERS

### -Command

Sets the scriptblock to be executed.

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

### -RetryCount

Sets the maximum retry attempts. Defaults to 5.

```yaml
Type: System.Int32
DefaultValue: 5
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -RetryDelay

Sets the delay (in seconds) between retry attempts. Defaults to 5 seconds.

```yaml
Type: System.Int32
DefaultValue: 5
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
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

### System.Object

The function returns the output from the invoked command.

## NOTES

## RELATED LINKS

- []()
