---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 11/13/2025
PlatyPS schema version: 2024-05-01
title: Get-HttpHeaderValue
---

# Get-HttpHeaderValue

## SYNOPSIS

Extracts and validates HTTP header values from a headers collection with type conversion.

## SYNTAX

### __AllParameterSets

```
Get-HttpHeaderValue [-Headers] <Object[]> [-HeaderName] <string> [-ExpectedType] <type>
 [[-DefaultValue] <Object>] [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

This function searches for a specific HTTP header in a headers collection and attempts to convert it to the specified type.
It provides robust error handling, case-insensitive header matching, and verbose logging for debugging.

## EXAMPLES

### EXAMPLE 1 - Extract Retry-After header as integer

```powershell
$retryAfter = Get-HttpHeaderValue -Headers $response.Headers -HeaderName "Retry-After" -ExpectedType ([int]) -DefaultValue 0
```

### EXAMPLE 2 - Extract X-RateLimit-Reset header as datetime from FileTime

```powershell
$headers = $response.Headers
$resetTime = Get-HttpHeaderValue -Headers $headers -HeaderName "X-RateLimit-Reset" -ExpectedType ([long]) -DefaultValue 0
if ($resetTime -gt 0) {
    $resetDateTime = [datetime]::FromFileTimeUtc($resetTime)
}
```

### EXAMPLE 3 - Extract custom header as string

```powershell
$customValue = Get-HttpHeaderValue -Headers $response.Headers -HeaderName "X-Custom-Header" -ExpectedType ([string]) -DefaultValue "default"
```

## PARAMETERS

### -DefaultValue

The default value to return if the header is not found or cannot be parsed.
Must be compatible with ExpectedType.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ExpectedType

The .NET type to convert the header value to (e.g., [int], [datetime], [string], [double]).

```yaml
Type: System.Type
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -HeaderName

The name of the header to search for (case-insensitive).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Headers

The collection of HTTP headers to search through. Each header should have a Key and Value property.

```yaml
Type: System.Object[]
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object

The function returns an appropriately-type value of the HTTP header.

## NOTES

## RELATED LINKS

- []()
