---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 09/03/2025
PlatyPS schema version: 2024-05-01
title: Install-DotNetTool
---

# Install-DotNetTool

## SYNOPSIS

Simple wrapper to install a .NET global tool if it is not already installed.

## SYNTAX

### global (Default)

```
Install-DotNetTool [-Name] <string> [-Version <string>] [-AdditionalArgs <string[]>] [-Global]
 [<CommonParameters>]
```

### local

```
Install-DotNetTool [-Name] <string> [-Version <string>] [-AdditionalArgs <string[]>] [-Local]
 [<CommonParameters>]
```

### toolpath

```
Install-DotNetTool [-Name] <string> [-Version <string>] [-AdditionalArgs <string[]>]
 [-ToolPath <string>] [<CommonParameters>]
```

## DESCRIPTION

Simple wrapper to install a .NET Global Tool if it is not already installed.  Any existing installed version will be uninstalled before installing the required version.

## EXAMPLES

### EXAMPLE 1 - Installs the latest version of the 'dotnet-gitversion' .NET tool into the global tool area (i.e. '~/.dotnet')

```powershell
Install-DotNetTool -Global -Name dotnet-gitversion
```

### EXAMPLE 2 - Installs version 5.6.6 of the 'dotnet-gitversion' .NET tool into a store located in the specified directory.  The ToolPath directory must already exist, but can be empty.

```powershell
Install-DotNetTool -ToolPath ./tools -Name dotnet-gitversion -Version 5.6.6
```

## PARAMETERS

### -AdditionalArgs

An array of arbitrary command-line arguments supported by 'dotnet tool install' command.

```yaml
Type: System.String[]
DefaultValue: '@()'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Global

When specified, the tool is installed in the global scope (i.e. for the current user).

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: global
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Local

When specified, the tool is installed in the local scope (i.e. for the current project's .NET tool manifest).

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: local
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

The name of the .NET global tool to install.

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

### -ToolPath

When specified, the tool is installed in the specified directory.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: toolpath
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Version

The version of the global tool to install. When unspecified the latest version will attempted to used, however, this does not work for all scenarios (e.g. pre-release, when not using a fully-featured NuGet feed as a source).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
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
