# <copyright file="Get-DotNetTool.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

function Get-DotNetTool
{
    [CmdletBinding(DefaultParameterSetName="global")]
    param (
        [Parameter(Mandatory=$true)]
        [string] $Name,

        [Parameter()]
        [string] $Version,
        
        [Parameter(ParameterSetName="global")]
        [switch] $Global,

        [Parameter(ParameterSetName="local")]
        [switch] $Local,

        [Parameter(ParameterSetName="toolpath")]
        [string] $ToolPath
    )

    switch ($PSCmdlet.ParameterSetName) {
        "global" { $scopeArg = @("--global") }
        "local" { $scopeArg = @("--local") }
        "toolpath" { $scopeArg = @("--tool-path", $ToolPath) }
    }

    # Parse the output from the dotnet cli to check whether the tool is already installed:
    #  - Skip first 2 'header' lines of output
    #  - The output is not tab delimited, so convert the whitespace between columns to a comma
    #  - Convert the now CSV-formatted output into an object
    #  - Match the specified tool name
    $existingInstall = _runDotNetToolList $scopeArg |
                            Select-Object -Skip 2 |
                            ForEach-Object { $_ -ireplace "\s+","," } |
                            ConvertFrom-Csv -Header name,version,commands |
                            Where-Object { $_.name -eq $Name }

    return $existingInstall
}

# Internal wrapper function to enable mocking in tests
function _runDotNetToolList {
    [CmdletBinding()]
    param (
        $scopeArg
    )

    & dotnet tool list @scopeArg
}
