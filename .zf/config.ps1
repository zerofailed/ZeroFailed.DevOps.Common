# Extensions setup
$zerofailedExtensions = @(
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
task PostBuild UpdateDocumentation
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

task UpdateDocumentation {

    $outPath = Join-Path $here 'docs\functions'
    $tmpPath = Join-Path $outPath 'ZeroFailed.DevOps.Common'

    # Put .md files where the New-MarkdownCommandHelp cmdlet expects to find them
    New-Item $tmpPath -ItemType Directory -Force | Out-Null
    Move-Item -Path $outPath\*.md -Destination $tmpPath\
    
    # Ensure latest version of module is imported
    Import-Module ($PowerShellModulesToPublish[0].ModulePath) -Force

    # Generate any markdown files for new functions
    $newMarkdownCommandHelpSplat = @{
        ModuleInfo = Get-Module ZeroFailed.DevOps.Common
        OutputFolder = $outPath
        HelpVersion = '1.0.0.0'
        WithModulePage = $false
        WarningAction = 'SilentlyContinue'  # suppress warnings about pre-existing files
    }
    New-MarkdownCommandHelp @newMarkdownCommandHelpSplat

    # Update existing markdown files to reflect changes in latest version
    Measure-PlatyPSMarkdown -Path $outPath\*.md |
        Where-Object Filetype -match 'CommandHelp' |
        Update-CommandHelp -Path {$_.FilePath} |
        Export-MarkdownCommandHelp -OutputFolder $outPath -Force


    # Move the markdown files back to where we want them in the repo
    Move-Item -Path $tmpPath\*.md -Destination $outPath\
    Remove-Item $tmpPath
}