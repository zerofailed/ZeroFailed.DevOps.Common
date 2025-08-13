---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Get-HttpHeaderValue

## SYNOPSIS
Extracts and validates HTTP header values from a headers collection with type conversion.

## SYNTAX

```
Get-HttpHeaderValue [-Headers] <Object[]> [-HeaderName] <String> [-ExpectedType] <Type>
 [[-DefaultValue] <Object>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function searches for a specific HTTP header in a headers collection and attempts to convert it to the specified type.
It provides robust error handling, case-insensitive header matching, and verbose logging for debugging.

## EXAMPLES

### EXAMPLE 1
```
# Extract Retry-After header as integer
$retryAfter = Get-HttpHeaderValue -Headers $response.Headers -HeaderName "Retry-After" -ExpectedType ([int]) -DefaultValue 0
```

### EXAMPLE 2
```
# Extract X-RateLimit-Reset header as datetime from FileTime
$headers = $response.Headers
$resetTime = Get-HttpHeaderValue -Headers $headers -HeaderName "X-RateLimit-Reset" -ExpectedType ([long]) -DefaultValue 0
if ($resetTime -gt 0) {
    $resetDateTime = [datetime]::FromFileTimeUtc($resetTime)
}
```

### EXAMPLE 3
```
# Extract custom header as string
$customValue = Get-HttpHeaderValue -Headers $response.Headers -HeaderName "X-Custom-Header" -ExpectedType ([string]) -DefaultValue "default"
```

## PARAMETERS

### -Headers
The collection of HTTP headers to search through.
Each header should have a Key and Value property.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeaderName
The name of the header to search for (case-insensitive).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpectedType
The .NET type to convert the header value to (e.g., \[int\], \[datetime\], \[string\], \[double\]).

```yaml
Type: Type
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultValue
The default value to return if the header is not found or cannot be parsed.
Must be compatible with ExpectedType.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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

### Returns the typed header value if found and successfully parsed, otherwise returns the DefaultValue.
## NOTES

## RELATED LINKS
