---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Set-BuildServerVariable

## SYNOPSIS
Abstracts sending formatted log messages to build servers to set build variables.

## SYNTAX

```
Set-BuildServerVariable [-Name] <String> [-Value] <Object> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Identifies the current build server using well-known environmnent variables and outputs correctly formatted
log messages that will set variables within the build server context.
Currently supports Azure Pipelines and
GitHub Actions.

## EXAMPLES

### EXAMPLE 1
```
Set-BuildServerVariable -Name "MyVar" -Value "foo"
Sets a build variable called 'MyVar' with the value of "foo".
```

## PARAMETERS

### -Name
The name of the variable to set on the build server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The value of the variable to set on the build server.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
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
