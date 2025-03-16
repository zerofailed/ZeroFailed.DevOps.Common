# <copyright file="ZeroFailed.DevOps.Common.psd1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

# find all the functions that make-up this module
$functions = Get-ChildItem -Recurse $PSScriptRoot/functions -Include *.ps1 | `
                                Where-Object { $_ -notmatch ".Tests.ps1" }
                    
# dot source the individual scripts that make-up this module
foreach ($function in ($functions)) { . $function.FullName }

# export the non-private functions (by convention, private function scripts must begin with an '_' character)
Export-ModuleMember -Function ( $functions | 
                                    ForEach-Object { (Get-Item $_).BaseName } | 
                                        Where-Object { -not $_.StartsWith("_") }
                            )
