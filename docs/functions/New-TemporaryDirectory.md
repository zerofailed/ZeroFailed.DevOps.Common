---
external help file: ZeroFailed.DevOps.Common-help.xml
Module Name: ZeroFailed.DevOps.Common
online version:
schema: 2.0.0
---

# New-TemporaryDirectory

## SYNOPSIS
Creates a new temporary directory with a unique name.

## SYNTAX

```
New-TemporaryDirectory [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function creates a new directory in the system's temporary folder with a randomly generated
GUID as its name.
This ensures that the directory name is unique and avoids potential naming conflicts.
The function returns the DirectoryInfo object for the newly created directory.

## EXAMPLES

### EXAMPLE 1
```
$tempDir = New-TemporaryDirectory
PS> $tempDir.FullName
C:\Users\username\AppData\Local\Temp\a1b2c3d4-e5f6-7890-1234-567890abcdef
```

### EXAMPLE 2
```
$tempDir = New-TemporaryDirectory
PS> try {
PS>     # Use temporary directory for operations
PS>     # ...
PS> }
PS> finally {
PS>     # Clean up when done
PS>     Remove-Item -Path $tempDir -Recurse -Force
PS> }
```

## PARAMETERS

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects to New-TemporaryDirectory.
## OUTPUTS

### System.IO.DirectoryInfo. The function returns the DirectoryInfo object for the created temporary directory.
## NOTES
The caller is responsible for deleting the temporary directory when it's no longer needed.
The directory will not be automatically removed when the PowerShell session ends.

## RELATED LINKS
