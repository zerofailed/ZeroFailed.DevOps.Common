---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# Invoke-RestMethodWithRateLimit

## SYNOPSIS
Invokes REST API calls with automatic rate limit handling and exponential backoff retry logic.

## SYNTAX

```
Invoke-RestMethodWithRateLimit [-Splat] <Hashtable> [[-MaxRetries] <Int32>] [[-BaseDelaySeconds] <Double>]
 [[-MaxDelaySeconds] <Int32>] [[-RetryBackOffExponentialFactor] <Double>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This wrapper function handles Fabric API and Microsoft Graph API rate limiting by:
- Detecting HTTP 429 responses
- Extracting Retry-After headers
- Implementing exponential backoff with jitter
- Providing configurable retry attempts
- Maintaining detailed logging

## EXAMPLES

### EXAMPLE 1
```
$splat = @{
    Uri = "https://api.fabric.microsoft.com/v1/connections"
    Method = "GET"  
    Headers = @{ Authorization = "Bearer $token" }
}
$result = Invoke-RestMethodWithRateLimit -Splat $splat
```

### EXAMPLE 2
```
# With custom retry parameters
$result = Invoke-RestMethodWithRateLimit -Splat $splat -MaxRetries 5 -BaseDelaySeconds 2 -MaxDelaySeconds 120
```

## PARAMETERS

### -Splat
Hashtable containing all parameters for Invoke-RestMethod (Uri, Method, Headers, Body, etc.)

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxRetries
Maximum number of retry attempts (default: 3)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -BaseDelaySeconds
Base delay in seconds for exponential backoff (default: 1)

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxDelaySeconds
Maximum delay in seconds between retries (default: 60)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 60
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryBackOffExponentialFactor
{{ Fill RetryBackOffExponentialFactor Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 1.5
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

### Returns the response from Invoke-RestMethod on successful execution.
## NOTES

## RELATED LINKS
