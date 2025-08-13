# <copyright file="Invoke-RestMethodWithRateLimit.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

<#
.SYNOPSIS
Invokes REST API calls with automatic rate limit handling and exponential backoff retry logic.

.DESCRIPTION
This wrapper function handles Fabric API and Microsoft Graph API rate limiting by:
- Detecting HTTP 429 responses
- Extracting Retry-After headers
- Implementing exponential backoff with jitter
- Providing configurable retry attempts
- Maintaining detailed logging

.PARAMETER Splat
Hashtable containing all parameters for Invoke-RestMethod (Uri, Method, Headers, Body, etc.)

.PARAMETER MaxRetries
Maximum number of retry attempts (default: 3)

.PARAMETER BaseDelaySeconds
Base delay in seconds for exponential backoff (default: 1)

.PARAMETER MaxDelaySeconds
Maximum delay in seconds between retries (default: 60)

.OUTPUTS
Returns the response from Invoke-RestMethod on successful execution.

.EXAMPLE
$splat = @{
    Uri = "https://api.fabric.microsoft.com/v1/connections"
    Method = "GET"  
    Headers = @{ Authorization = "Bearer $token" }
}
$result = Invoke-RestMethodWithRateLimit -Splat $splat

.EXAMPLE
# With custom retry parameters
$result = Invoke-RestMethodWithRateLimit -Splat $splat -MaxRetries 5 -BaseDelaySeconds 2 -MaxDelaySeconds 120
#>
function Invoke-RestMethodWithRateLimit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [hashtable] $Splat,
        
        [Parameter()]
        [int] $MaxRetries = 3,
        
        [Parameter()]
        [double] $BaseDelaySeconds = 1.0,
        
        [Parameter()]
        [int] $MaxDelaySeconds = 60,

        [Parameter()]
        [double] $RetryBackOffExponentialFactor = 1.5
    )
    
    $attempt = 0
    $lastException = $null
    
    while ($attempt -le $MaxRetries) {
        try {
            Write-Verbose "API call attempt $($attempt + 1) to $($Splat.Uri)"
            
            $response = Invoke-RestMethod @Splat
            
            if ($attempt -gt 0) {
                Write-Information "API call succeeded after $($attempt + 1) attempts"
            }
            
            return $response
            
        } catch {
            $lastException = $_
            $statusCode = $null
            $retryAfter = $null
            
            # Extract status code and retry-after header if available
            if ($_.Exception.Response) {
                $statusCode = $_.Exception.Response.StatusCode.value__
                
                # Look for Retry-After header
                if ($_.Exception.Response.Headers) {
                    $retryAfterHeader = $_.Exception.Response.Headers | Where-Object { $_.Key -eq 'Retry-After' }
                    $rateLimitRemainingHeader = $_.Exception.Response.Headers | Where-Object { $_.Key -eq 'X-RateLimit-Remaining' }
                    $rateLimitResetHeader = $_.Exception.Response.Headers | Where-Object { $_.Key -eq 'X-RateLimit-Reset' }

                    # The 'Retry-After' header take precendence (ref: spec?)
                    if ($retryAfterHeader) {
                        try {
                            $retryAfter = [int]$retryAfterHeader.Value[0]
                        } catch {
                            Write-Verbose "Could not parse Retry-After header: $($retryAfterHeader.Value[0])"
                        }
                    }
                    # Otherwise check whether we have told about a reqeust quota
                    elseif ($rateLimitRemainingHeader -and $rateLimitResetHeader) {
                        try {
                            $rateLimitRemaining = [int]$rateLimitRemainingHeader.Value[0]

                            if ($rateLimitRemaining -eq 0) {
                                try {
                                    $rateLimitReset = [int]$rateLimitResetHeader.Value[0]
                                    $rateLimitReset = [datetime]::FromFileTimeUtc($rateLimitReset)
                                    $retryAfter = ($rateLimitReset - [datetime]::UtcNow).TotalSeconds
                                    Write-Verbose "Rate limit exceeded. Waiting for quota reset in $retryAfter seconds..."
                                } catch {
                                    Write-Verbose "Could not parse X-RateLimit-Reset header: $($rateLimitResetHeader.Value[0])"
                                }
                            }
                        } catch {
                            Write-Verbose "Could not parse X-RateLimit-Remaining header: $($rateLimitRemainingHeader.Value[0])"
                        }
                    }
                }
            }
            
            # Check if this is a retryable error (429 or 5xx)
            $isRetryable = ($statusCode -eq 429) -or ($statusCode -ge 500 -and $statusCode -lt 600)
            
            if (-not $isRetryable -or $attempt -eq $MaxRetries) {
                Write-Verbose "Non-retryable error or max retries reached. Status: $statusCode, Attempt: $($attempt + 1)"
                throw $lastException
            }
            
            $attempt++
            
            # Calculate delay with exponential backoff and jitter
            if ($statusCode -eq 429 -and $retryAfter) {
                # Use server-provided retry-after value
                $delaySeconds = [Math]::Min($retryAfter, $MaxDelaySeconds)
                if ($retryAfter -gt $MaxDelaySeconds) {
                    Write-Information "Rate limited (429). Server requested waiting $retryAfter seconds, which exceeds MaxDelaySeconds. Waiting for $MaxDelaySeconds seconds."
                }
                else {
                    Write-Information "Rate limited (429). Waiting $delaySeconds seconds as requested by server."
                }
            } else {
                # Use exponential backoff with jitter
                $exponentialDelay = [Math]::Pow($RetryBackOffExponentialFactor, $attempt - 1) * $BaseDelaySeconds
                $jitter = (Get-Random -Minimum 0.0 -Maximum 1.0) * 0.1 * $exponentialDelay
                $delaySeconds = [Math]::Min($exponentialDelay + $jitter, $MaxDelaySeconds)
                
                $errorType = if ($statusCode -eq 429) { "Rate limited" } else { "Server error ($statusCode)" }
                Write-Warning "$errorType. Retrying in $([Math]::Round($delaySeconds, 2)) seconds (attempt $attempt of $MaxRetries)"
            }
            
            Start-Sleep -Seconds $delaySeconds
        }
    }
    
    throw $lastException
}