# <copyright file="Test-AzCliConnection.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

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