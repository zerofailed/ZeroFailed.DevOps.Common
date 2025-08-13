---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Get-DotNetTool

## SYNOPSIS
Simple wrapper to check whether a given .NET tool is already installed.

## SYNTAX

### global (Default)
```
Get-DotNetTool -Name <String> [-Version <String>] [-Global] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### local
```
Get-DotNetTool -Name <String> [-Version <String>] [-Local] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### toolpath
```
Get-DotNetTool -Name <String> [-Version <String>] [-ToolPath <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Simple wrapper to check whether a given .NET tool is already installed.

## EXAMPLES

### EXAMPLE 1
```
Get-DotNetTool -Global -Name gitversion.tool
name            version commands
----            ------- --------
gitversion.tool 5.8.0   dotnet-gitversion
```

Checks whether any version of the 'gitversion.tool' .NET tool is installed globally, returning an object with the installed tool's details.

### EXAMPLE 2
```
Get-DotNetTool -ToolPath ./tools -Name gitversion.tool -Version 5.6.6
```

Checks whether version 5.6.6 of the 'gitversion.tool' .NET tool is installed to a store at the specified directory, returning null if it isn't.

## PARAMETERS

### -Name
The name of the .NET tool to check

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
The version of the .NET tool to check for.
When unspecified any version found will cause this function to return true.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Global
When specified, the tool's installation status is checked in the global scope (i.e.
for the current user).

```yaml
Type: SwitchParameter
Parameter Sets: global
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Local
When specified, the tool's installation status is checked in the local scope (i.e.
for the current project's .NET tool manifest).

```yaml
Type: SwitchParameter
Parameter Sets: local
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ToolPath
When specified, the tool's installation status is checked in the specified directory.

```yaml
Type: String
Parameter Sets: toolpath
Aliases:

Required: False
Position: Named
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

### An object containing the details of the installed tool, or null if the tool isn't installed.
### @{
###     name = "gitversion.tool"
###     version = "5.6.6"
###     commands = "dotnet-gitversion"
### }
## NOTES

## RELATED LINKS
