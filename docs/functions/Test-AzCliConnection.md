---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Test-AzCliConnection

## SYNOPSIS
Checks whether the process is logged-in to the azure-cli.

## SYNTAX

```
Test-AzCliConnection [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns true when a valid azure-cli access token is found, otherwise returns false.

## EXAMPLES

### EXAMPLE 1
```
if (Test-AzCliConnection) { & az storage list } else { Write-Error "Please run 'az login'" }
```

## PARAMETERS

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
