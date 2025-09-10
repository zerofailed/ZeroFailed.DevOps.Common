---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 09/10/2025
PlatyPS schema version: 2024-05-01
title: Edit-TokenizedFiles
---

# Edit-TokenizedFiles

## SYNOPSIS

Searches multiple files for occurrences of multiple strings following a regular expression pattern and replaces them with the provided values.

## SYNTAX

### __AllParameterSets

```
Edit-TokenizedFiles [[-FilesToProcess] <string[]>] [[-TokenRegexFormatString] <string>]
 [[-TokenValuePairs] <hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

Configuration that changes between different environments etc. is often represented by a tokenised value, which is updated before use.

For example, consider a JSON file containing the following:

```json
{
    "apiBaseUrl": "https://#{ApiServer}#/api"
}
```

This function allows such tokenised files to be easily updated with their actual values based on the configuration passed in the 'TokenValuePairs' hashtable.

Using the following hashtable:

```powershell
@{
    ApiServer = "myserver.nowhere.org"
}
```

Would result in the file being updated as shown below:

```json
{
    "apiBaseUrl": "https://myserver.nowhere.org/api"
}
```

## EXAMPLES

### EXAMPLE 1

```powershell
# Define values for 2 tokens that exist in multiple files
$tokens = @{
  Path=$(Split-Path -Parent $PSCommandPath)
  Version='1.2.0'
}

# Get the list of files that require token replacement
$files = Get-ChildItem -Filter *.json

# Run the token replacement, updating the files in-situ
Edit-TokenizedFiles -FilesToProcess $files -TokenValuePairs tokens
```

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
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

### -FilesToProcess

The array of files to be processed.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TokenRegexFormatString

The regular expression used to locate tokens to be replaced. The expression must contain a single
format string placeholder (i.e. `{0}`) to represent the name of the token.

Defaults to an expression suitable for use with the above example.

```yaml
Type: System.String
DefaultValue: '\#\{{{0}\}}\#'
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

### -TokenValuePairs

A hashtable containing the mapping of tokens to their respective values.

```yaml
Type: System.Collections.Hashtable
DefaultValue: ''
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

### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
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

### System.Void

This function has no outputs.

## NOTES

When customising the `TokenRegexFormatString`, care must be taken to ensure that any characters
that would other conflict with the format string syntax are suitably escaped.

For example, the pattern used above requires the braces to be escaped: `\#\{{{0}\}}\#`

- Regex syntax requires `#`, `{` and `}` characters to be escaped with the backslash
- Format string syntax requires the `{` and `}` characters not related to the format string are escaped by doubling them up

## RELATED LINKS

- []()
