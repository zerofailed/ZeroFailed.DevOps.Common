---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Install-DotNetTool

## SYNOPSIS
Simple wrapper to install a .NET global tool if it is not already installed.

## SYNTAX

### global (Default)
```
Install-DotNetTool [-Name] <String> [-Version <String>] [-AdditionalArgs <String[]>] [-Global]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### local
```
Install-DotNetTool [-Name] <String> [-Version <String>] [-AdditionalArgs <String[]>] [-Local]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### toolpath
```
Install-DotNetTool [-Name] <String> [-Version <String>] [-AdditionalArgs <String[]>] [-ToolPath <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Simple wrapper to install a .NET Global Tool if it is not already installed. 
Any existing
installed version will be uninstalled before installing the required version.

## EXAMPLES

### EXAMPLE 1
```
Install-DotNetTool -Global -Name dotnet-gitversion
Installs the latest version of the 'doitnet-gitversion' .NET tool into the global tool area (i.e. '~/.dotnet')
```

### EXAMPLE 2
```
Install-DotNetTool -ToolPath ./tools -Name dotnet-gitversion -Version 5.6.6
Installs version 5.6.6 of the 'dotnet-gitversion' .NET tool into a store located in the specified directory.  The ToolPath directory must already exist, but can be empty.
```

## PARAMETERS

### -Name
The name of the .NET global tool to install

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

### -Version
The version of the global tool to install. 
When unspecified the latest version will attempted to used, however, this does not work for all scenarios (e.g.
pre-release, when not using a fully-featured NuGet feed as a source).

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

### -AdditionalArgs
An array of arbitrary command-line arguments supported by 'dotnet tool install'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -Global
When specified, the tool is installed in the global scope (i.e.
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
When specified, the tool is installed in the local scope (i.e.
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
When specified, the tool is installed in the specified directory.

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

## NOTES

## RELATED LINKS
