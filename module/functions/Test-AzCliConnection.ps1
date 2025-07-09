# <copyright file="Test-AzCliConnection.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

<#
.SYNOPSIS
    Checks whether the process is logged-in to the azure-cli.
.DESCRIPTION
    Returns true when a valid azure-cli access token is found, otherwise returns false.
.EXAMPLE
    PS:> if (Test-AzCliConnection) { & az storage list } else { Write-Error "Please run 'az login'" }
#>

function Test-AzCliConnection
{
    [CmdletBinding()]
    param (
    )

    if ($null -eq $(Get-Command az -ErrorAction Ignore)) {
        throw "The azure-cli is not installed."
    }

    $currentTokenExpiry = $(az account get-access-token --query "expiresOn" -o tsv)
    if ($null -eq $currentTokenExpiry -or ([DateTime]$currentTokenExpiry) -le [DateTime]::Now)
    {
        return $false
    }

    return $true
}