---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 11/13/2025
PlatyPS schema version: 2024-05-01
title: Get-DotNetTool
---

# Get-DotNetTool

## SYNOPSIS

Simple wrapper to check whether a given .NET tool is already installed.

## SYNTAX

### global (Default)

```
Get-DotNetTool -Name <string> [-Version <string>] [-Global] [<CommonParameters>]
```

### local

```
Get-DotNetTool -Name <string> [-Version <string>] [-Local] [<CommonParameters>]
```

### toolpath

```
Get-DotNetTool -Name <string> [-Version <string>] [-ToolPath <string>] [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

Simple wrapper to check whether a given .NET tool is already installed.

## EXAMPLES

### EXAMPLE 1 - Checks whether any version of the 'gitversion.tool' .NET tool is installed globally, returning an object with the installed tool's details.

```powershell
PS> Get-DotNetTool -Global -Name gitversion.tool
name            version commands
----            ------- --------
gitversion.tool 5.8.0   dotnet-gitversion
```

### EXAMPLE 2 - Checks whether version 5.6.6 of the 'gitversion.tool' .NET tool is installed to a store at the specified directory, returning null if it isn't.

```powershell
PS:> Get-DotNetTool -ToolPath ./tools -Name gitversion.tool -Version 5.6.6
```

## PARAMETERS

### -Global

When specified, the tool's installation status is checked in the global scope (i.e. for the current user).

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

When specified, the tool's installation status is checked in the local scope (i.e. for the current project's .NET tool manifest).

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

The name of the .NET tool to check

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ToolPath

When specified, the tool's installation status is checked in the specified directory.

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

The version of the .NET tool to check for. When unspecified any version found will cause this function to return true.

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

## INPUTS

## OUTPUTS

### System.Collections.Hashtable

The function returns information about the installed global tool, otherwise returns null.

## NOTES

## RELATED LINKS

- []()
