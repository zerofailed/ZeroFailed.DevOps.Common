---
document type: cmdlet
external help file: ZeroFailed.DevOps.Common-Help.xml
HelpUri: ''
Locale: en-GB
Module Name: ZeroFailed.DevOps.Common
ms.date: 11/13/2025
PlatyPS schema version: 2024-05-01
title: New-TemporaryDirectory
---

# New-TemporaryDirectory

## SYNOPSIS

Creates a new temporary directory with a unique name.

## SYNTAX

### __AllParameterSets

```
New-TemporaryDirectory [<CommonParameters>]
```

## ALIASES

## DESCRIPTION

This function creates a new directory in the system's temporary folder with a randomly generated GUID as its name.
This ensures that the directory name is unique and avoids potential naming conflicts. The function returns the DirectoryInfo object for the newly created directory.

## EXAMPLES

### EXAMPLE 1

```powershell
$tempDir = New-TemporaryDirectory
PS> $tempDir.FullName
C:\Users\username\AppData\Local\Temp\a1b2c3d4-e5f6-7890-1234-567890abcdef
```

### EXAMPLE 2 - Demonstrate typical script usage

```powershell
$tempDir = New-TemporaryDirectory
try {
    # Use temporary directory for operations
    # ...
}
finally {
    # Clean up when done
    Remove-Item -Path $tempDir -Recurse -Force
}
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.DirectoryInfo

The function returns the DirectoryInfo object for the created temporary directory.

## NOTES

## RELATED LINKS

- []()
