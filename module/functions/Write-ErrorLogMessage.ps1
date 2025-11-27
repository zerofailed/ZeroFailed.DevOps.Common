# <copyright file="Write-ErrorLogMessage.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

function Write-ErrorLogMessage {
    [CmdletBinding()]
    [OutputType([System.Void])]
    param (
        [Parameter(Mandatory)]
        [string] $Message
    )

    if ($IsGitHubActions) {
        Write-Information -MessageData ("`n::error::{0}" -f $Message) -InformationAction Continue
    }
    elseif ($IsAzureDevOps) {
        Write-Information -MessageData ("`n##[error]{0}" -f $Message) -InformationAction Continue
    }
    else {
        Write-Error -Message $Message -ErrorAction Continue
    }
}