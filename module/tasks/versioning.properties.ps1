# <copyright file="versioning.properties.ps1" company="Endjin Limited">
# Copyright (c) Endjin Limited. All rights reserved.
# </copyright>

# Synopsis: When true, the versioning tasks will be skipped. Default is false.
$SkipVersion = property ZF_SkipVersion $false

# Synopsis: When true, the GitVersion tool will be used to determine the version number. Default is true.
$UseGitVersion = property ZF_UseGitVersion $true

# Synopsis: Path to the GitVersion configuration file. Default is a "GitVersion.yml" file alongside the running script.
$GitVersionConfigPath = property ZF_GitVersionConfigPath "$here/GitVersion.yml"

# Synopsis: The version of the GitVersion tool to use. Default is "5.8.0".
$GitVersionToolVersion = property ZF_GitVersionToolVersion "5.8.0"

# Synopsis: When defined, the value will used as an override of the GitVersion output. This can be useful when you want to force a particular version tag unrelated to the current branch etc. Not set by default.
$GitVersion = property ZF_GitVersion @{}