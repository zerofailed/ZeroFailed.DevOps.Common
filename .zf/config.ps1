# Extensions setup
$zerofailedExtensions = @(
    # Ensure that builds always using the current repository version of this extension:
    # - Validates that any changes work with the build process
    # - Avoids any conflicts when generating PlatyPS markdown documentation for the repository version
    @{
        Name = "ZeroFailed.DevOps.Common"
        Path = "$here/module"
    }

    @{
        Name = "ZeroFailed.Build.PowerShell"
        GitRepository = "https://github.com/zerofailed/ZeroFailed.Build.PowerShell.git"
        GitRef = "main"
    }
    @{
        Name = "ZeroFailed.Build.GitHub"
        GitRepository = "https://github.com/zerofailed/ZeroFailed.Build.GitHub.git"
        GitRef = "main"
    }
)

# Load the tasks and process
. ZeroFailed.tasks -ZfPath $here/.zf

# Set the required build options
$PesterTestsDir = "$here/module"
$PesterCodeCoveragePaths = @("$here/module/functions")
$PesterVersion = "5.7.1"
$PowerShellModulesToPublish = @(
    @{
        ModulePath = "$here/module/ZeroFailed.DevOps.Common.psd1"
        FunctionsToExport = @("*")
        CmdletsToExport = @()
        AliasesToExport = @()
    }
)
$PowerShellRepositories = @(
    @{
        Name = 'PSGallery'
        ApiKey = { $PSRepositoryApiKey }
        BlockPreReleaseVersions = $true
    }
    @{
        Name = 'GitHubPackages'
        SourceLocation = 'https://nuget.pkg.github.com/zerofailed/index.json'
        ApiKey = { $env:ZF_BUILD_GITHUB_PACKAGES_TOKEN }
        Credential = {
            if ($env:ZF_BUILD_GITHUB_PACKAGES_TOKEN) {
                [pscredential]::new('github-actions', (ConvertTo-SecureString $env:ZF_BUILD_GITHUB_PACKAGES_TOKEN -AsPlainText -Force))
            }
        }
    }
)
if ($env:ZF_BUILD_PS_REPOSITORY_NAME) {
    $targetRepository = $PowerShellRepositories | Where-Object Name -EQ $env:ZF_BUILD_PS_REPOSITORY_NAME
    if (!$targetRepository) {
        throw "PowerShell repository '$env:ZF_BUILD_PS_REPOSITORY_NAME' is not configured."
    }
    $PowerShellRepositories = @($targetRepository)
}

$PSMarkdownDocsFlattenOutputPath = $true
$PSMarkdownDocsOutputPath = './docs/functions'
$PSMarkdownDocsIncludeModulePage = $false

$CreateGitHubRelease = $true

# Customise the build process
task . FullBuild

#
# Build Process Extensibility Points - uncomment and implement as required
#

# task RunFirst {}
# task PreInit {}
# task PostInit {}
# task PreVersion {}
# task PostVersion {}
# task PreBuild {}
# task PostBuild {}
# task PreTest {}
# task PostTest {}
# task PreTestReport {}
# task PostTestReport {}
# task PreAnalysis {}
# task PostAnalysis {}
# task PrePackage {}
# task PostPackage {}
# task PrePublish {}
# task PostPublish {}
# task RunLast {}
