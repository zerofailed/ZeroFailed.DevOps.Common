# <copyright file="Resolve-Value.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

<#
.SYNOPSIS
    Evaluates a provided value which may be static or dynamic.

.DESCRIPTION
    This cmdlet accepts a value of any type and evaluates it:
    - If the value is a scriptblock, it invokes the scriptblock and returns its result
    - If the value is any other type, it returns the value unchanged
    
    This allows configuration to be defined either as static values or as scriptblocks that
    provide dynamic values determined at runtime.

.PARAMETER Value
    The configuration value to be resolved. This can be any object type, including scriptblocks.

.INPUTS
    You can pipe any object to Resolve-ConfigurationValue.

.OUTPUTS
    Returns the resolved value. If the input was a scriptblock, returns the result of invoking it;
    otherwise returns the input value unchanged.

.EXAMPLE
    PS> "StaticValue" | Resolve-ConfigurationValue
    StaticValue

.EXAMPLE
    PS> { Get-Date -Format "yyyy-MM-dd" } | Resolve-ConfigurationValue
    2023-04-15

.EXAMPLE
    PS> $foo = { $bar }
    PS> $bar = "DeferredValue"
    PS> Resolve-ConfigurationValue $foo
    DeferredValue
#>

function Resolve-Value {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $Value
    )

    if ($Value -is [scriptblock]) {
        $Value.Invoke()
    }
    else {
        $Value
    }
}
