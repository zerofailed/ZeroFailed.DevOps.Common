# <copyright file="Write-ErrorLogMessage.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

<#
.SYNOPSIS
    Writes an error message formatted for the appropriate CI/CD platform, when applicable.

.DESCRIPTION
    Writes an error message formatted for the appropriate CI/CD platform, when applicable.

.PARAMETER Message
    The error message to be logged.

.EXAMPLE
    PS> Write-ErrorMessage "Something bad happened!"
#>

function Write-ErrorLogMessage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $Message
    )

    if ($IsGitHubActions) {
        Write-Information -MessageData ("`n::error::{0}" -f $Message) -InformationAction Continue
    }
    elseif ($IsAzureDevOps ) {
        Write-Information -MessageData ("`n##[error]{0}" -f $Message) -InformationAction Continue
    }
    else {
        Write-Error -Message $Message -ErrorAction Continue
    }
}