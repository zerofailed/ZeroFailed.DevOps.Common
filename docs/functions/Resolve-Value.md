---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Resolve-Value

## SYNOPSIS
Evaluates a provided value which may be static or dynamic.

## SYNTAX

```
Resolve-Value [-Value] <Object> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet accepts a value of any type and evaluates it:
- If the value is a scriptblock, it invokes the scriptblock and returns its result
- If the value is any other type, it returns the value unchanged

This allows configuration to be defined either as static values or as scriptblocks that
provide dynamic values determined at runtime.

## EXAMPLES

### EXAMPLE 1
```
"StaticValue" | Resolve-Value
StaticValue
```

### EXAMPLE 2
```
{ Get-Date -Format "yyyy-MM-dd" } | Resolve-Value
2023-04-15
```

### EXAMPLE 3
```
$foo = { $bar }
PS> $bar = "DeferredValue"
PS> Resolve-Value $foo
DeferredValue
```

## PARAMETERS

### -Value
The configuration value to be resolved.
This can be any object type, including scriptblocks.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### You can pipe any object to Resolve-Value.
## OUTPUTS

### Returns the resolved value. If the input was a scriptblock, returns the result of invoking it;
### otherwise returns the input value unchanged.
## NOTES

## RELATED LINKS
