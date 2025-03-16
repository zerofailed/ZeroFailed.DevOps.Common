# <copyright file="Resolve-Value.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

<#
.SYNOPSIS
    A helper function that enables lazy evaluation of configuration values when they are specified as a PowerShell script block.
.DESCRIPTION
    Given an input value that is a scriptblock, this function will invoke the script block and return the result.  Otherwise, it will return the input value.
.PARAMETER Value
    The value to resolve.  If this is a script block, it will be invoked and the result returned, otherwise the value will be returned as-is.
.EXAMPLE
    PS C:\> $aSetting = { $SomeVariableNotYetDefined }; $SomeVariableNotYetDefined = "foo"; Resolve-Value -Value $aSetting
    foo
#>

function Resolve-Value {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Value
    )

    if ($Value -is [scriptblock]) {
        $Value.Invoke()
    }
    else {
        $Value
    }
}
