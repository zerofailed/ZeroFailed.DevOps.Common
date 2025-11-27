# <copyright file="New-TemporaryDirectory.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

function New-TemporaryDirectory {
    [CmdletBinding()]
    [OutputType([System.IO.DirectoryInfo])]
    param ()

    $parent = [System.IO.Path]::GetTempPath()
    [string] $name = [System.Guid]::NewGuid()
    New-Item -ItemType Directory -Path (Join-Path $parent $name)
}
