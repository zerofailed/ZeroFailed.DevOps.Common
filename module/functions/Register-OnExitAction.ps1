# <copyright file="Register-OnExitAction.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

function Register-OnExitAction
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [scriptblock] $Action
    )

    # Do not register the action if we're already running in the context of one of these actions
    if (!(Test-Path variable:/__RunningInExitAction) -or !$__RunningInExitAction)
    {
        $script:OnExitActions.Add($Action)
    }
}