---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 09/03/2025
PlatyPS schema version: 2024-05-01
title: Resolve-Value
---

# Resolve-Value

## SYNOPSIS

Evaluates a provided value which may be static or dynamic.

## SYNTAX

### __AllParameterSets

```
Resolve-Value [-Value] <Object> [<CommonParameters>]
```

## DESCRIPTION

This cmdlet accepts a value of any type and evaluates it:
- If the value is a scriptblock, it invokes the scriptblock and returns its result
- If the value is any other type, it returns the value unchanged

This allows configuration to be defined either as static values or as scriptblocks that provide dynamic values determined at runtime.

## EXAMPLES

### EXAMPLE 1 - Resolving a static value

```powershell
"StaticValue" | Resolve-Value
StaticValue
```

### EXAMPLE 2 - Resolving a PowerShell expression

```powershell
{ Get-Date -Format "yyyy-MM-dd" } | Resolve-Value
2023-04-15
```

### EXAMPLE 3 - Resolving a PowerShell variable that is not defined at initialisation time

```powershell
$foo = { $bar }
PS> $bar = "DeferredValue"
PS> Resolve-Value $foo
DeferredValue
```

## PARAMETERS

### -Value

The configuration value to be resolved. This can be any object type, including a scriptblock.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: true
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

### System.Object

You can pipe any object to Resolve-Value.

## OUTPUTS

### System.Object

Returns the resolved value. If the input was a scriptblock, returns the result of invoking it; otherwise returns the input value unchanged.
