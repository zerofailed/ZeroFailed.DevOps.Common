---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Edit-TokenizedFiles

## SYNOPSIS
Searches multiple files for occurrences of multiple strings following a regular expression pattern and replaces them with the provided values.

## SYNTAX

```
Edit-TokenizedFiles [[-FilesToProcess] <String[]>] [[-TokenRegexFormatString] <String>]
 [[-TokenValuePairs] <Hashtable>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Configuration that changes between different environments etc.
is often represented by a tokenised value, which is updated before use.
For example, consider a file containing the following:

{
    "apiBaseUrl": "https://#{ApiServer}#/api"
}

This function allows such tokenised files to be easily updated with their actual values based on the configuration passed in the 'TokenValuePairs'
hashtable.

Using the following hashtable:

@{
    ApiServer = "myserver.nowhere.org"
}

Would result in the file being updated as shown below:

{
    "apiBaseUrl": "https://myserver.nowhere.org/api"
}

## EXAMPLES

### EXAMPLE 1
```
$tokens = @{ Path=$(Split-Path -Parent $PSCommandPath); Version='1.2.0' }
$files = Get-ChildItem -Filter *.json
Edit-TokenizedFiles -FilesToProcess $files -TokenValuePairs tokens
```

## PARAMETERS

### -FilesToProcess
The array of files to be processed.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TokenRegexFormatString
The regular expression used to locate tokens to be replaced.
The expression must contain a single
format string placeholder (i.e.
'{0}') to represent the name of the token.
Defaults to an
expression suitable for use with the above example.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: \#\{{{0}\}}\#
Accept pipeline input: False
Accept wildcard characters: False
```

### -TokenValuePairs
A hashtable containing the mapping of tokens to their respective values.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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
NOTE: When customising the 'TokenRegexFormatString', care must be taken to ensure that any characters
that would other conflict with the format string syntax are suitably escaped.

For example, the pattern used above requires the braces to be escaped: "\#\{{{0}\}}\#"

- Regex syntax requires '#', '{' and '}' need to be escaped with the backslash
- Format string syntax requires the '{' and '}' not related to the format string to be escaped by doubling them up

## RELATED LINKS
