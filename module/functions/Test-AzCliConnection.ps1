# <copyright file="Test-AzCliConnection.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

function Test-AzCliConnection
{
    [CmdletBinding()]
    [OutputType([Boolean])]
    param (
    )

    if ($null -eq $(Get-Command az -ErrorAction Ignore)) {
        throw "The azure-cli is not installed."
    }

    $currentTokenExpiry = $(az account get-access-token --query "expiresOn" -o tsv 2>$null)
    if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($currentTokenExpiry) -or ([DateTime]$currentTokenExpiry) -le [DateTime]::Now)
    {
        return $false
    }

    return $true
}