---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Invoke-CommandWithRetry

## SYNOPSIS
Provides retry logic for PowerShell ScriptBlock execution.

## SYNTAX

```
Invoke-CommandWithRetry [-Command] <ScriptBlock> [[-RetryCount] <Int32>] [[-RetryDelay] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Provides retry logic for PowerShell ScriptBlock execution.

## EXAMPLES

### EXAMPLE 1
```
Invoke-CommandWithRetry -Command { Invoke-WebRequest https://somesite.com/unreliable-service } -RetryCount 3 -RetryDelay 10
```

## PARAMETERS

### -Command
Sets the scriptblock to be executed.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryCount
Sets the maximum retry attempts.
Defaults to 5.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryDelay
Sets the delay (in seconds) between retry attempts.
Defaults to 5 seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 5
Accept pipeline input: False
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

## OUTPUTS

## NOTES

## RELATED LINKS
