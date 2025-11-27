# <copyright file="Resolve-Value.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

function Resolve-Value {
    [CmdletBinding()]
    [OutputType([Object])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [AllowEmptyString()]
        [AllowNull()]
        $Value
    )

    if ($Value -is [scriptblock]) {
        $Value.Invoke()
    }
    else {
        $Value
    }
}
