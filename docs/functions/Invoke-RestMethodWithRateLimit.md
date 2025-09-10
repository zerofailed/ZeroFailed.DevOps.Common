---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 09/10/2025
PlatyPS schema version: 2024-05-01
title: Invoke-RestMethodWithRateLimit
---

# Invoke-RestMethodWithRateLimit

## SYNOPSIS

Invokes REST API calls with automatic rate limit handling and exponential backoff retry logic.

## SYNTAX

### __AllParameterSets

```
Invoke-RestMethodWithRateLimit [-Splat] <hashtable> [[-MaxRetries] <int>]
 [[-BaseDelaySeconds] <double>] [[-MaxDelaySeconds] <int>]
 [[-RetryBackOffExponentialFactor] <double>] [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

This wrapper function handles Fabric API and Microsoft Graph API rate limiting by:

- Detecting HTTP 429 responses
- Extracting Retry-After headers
- Implementing exponential backoff with jitter
- Providing configurable retry attempts
- Maintaining detailed logging

## EXAMPLES

### EXAMPLE 1

```powershell
$splat = @{
    Uri = "https://api.fabric.microsoft.com/v1/connections"
    Method = "GET"
    Headers = @{ Authorization = "Bearer $token" }
}
$result = Invoke-RestMethodWithRateLimit -Splat $splat
```

### EXAMPLE 2 - Using custom retry parameters

```powershell
$result = Invoke-RestMethodWithRateLimit -Splat $splat -MaxRetries 5 -BaseDelaySeconds 2 -MaxDelaySeconds 120
```

## PARAMETERS

### -BaseDelaySeconds

Base delay in seconds for exponential backoff (default: 1).

```yaml
Type: System.Double
DefaultValue: 1
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

### -MaxDelaySeconds

Maximum delay in seconds between retries (default: 60).

```yaml
Type: System.Int32
DefaultValue: 60
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

### -MaxRetries

Maximum number of retry attempts (default: 3).

```yaml
Type: System.Int32
DefaultValue: 3
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

### -RetryBackOffExponentialFactor

The factor used when calculating how quickly the exponential backoff should increase. Defaults to 1.5.

```yaml
Type: System.Double
DefaultValue: 1.5
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Splat

Hashtable containing all parameters for Invoke-RestMethod (Uri, Method, Headers, Body, etc.)

```yaml
Type: System.Collections.Hashtable
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

The function returns the response from the REST method call.

## NOTES

## RELATED LINKS

- []()
