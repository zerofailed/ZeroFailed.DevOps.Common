# <copyright file="New-TemporaryDirectory.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

<#
.SYNOPSIS
    Creates a new temporary directory with a unique name.

.DESCRIPTION
    This function creates a new directory in the system's temporary folder with a randomly generated
    GUID as its name. This ensures that the directory name is unique and avoids potential naming conflicts.
    The function returns the DirectoryInfo object for the newly created directory.

.INPUTS
    None. You cannot pipe objects to New-TemporaryDirectory.

.OUTPUTS
    System.IO.DirectoryInfo. The function returns the DirectoryInfo object for the created temporary directory.

.EXAMPLE
    PS> $tempDir = New-TemporaryDirectory
    PS> $tempDir.FullName
    C:\Users\username\AppData\Local\Temp\a1b2c3d4-e5f6-7890-1234-567890abcdef

.EXAMPLE
    PS> $tempDir = New-TemporaryDirectory
    PS> try {
    PS>     # Use temporary directory for operations
    PS>     # ...
    PS> }
    PS> finally {
    PS>     # Clean up when done
    PS>     Remove-Item -Path $tempDir -Recurse -Force
    PS> }

.NOTES
    The caller is responsible for deleting the temporary directory when it's no longer needed.
    The directory will not be automatically removed when the PowerShell session ends.
#>

function New-TemporaryDirectory {
    [CmdletBinding()]
    param ()

    $parent = [System.IO.Path]::GetTempPath()
    [string] $name = [System.Guid]::NewGuid()
    New-Item -ItemType Directory -Path (Join-Path $parent $name)
}
