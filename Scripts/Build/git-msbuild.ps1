# Define variables
$githubRepoUrl = "https://github.eastus2.cloudapp.azure.com/NE-Enterprise-Applications/myMaintenance.git"
$githubRepoName = "myMaintenance"
$msbuildPath = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
$outputDir = "C:\BuildOutput"
$branchName = "main"
$buildConfig = "Release"

# Clone the repository
git clone $githubRepoUrl -b $branchName

# Navigate to the repository directory
cd $githubRepoName

# Build the solution using MSBuild
msbuild.exe /t:Build  /p:Configuration=$buildConfig "$githubRepoName\$githubRepoName.csproj" /p:OutDir="$outputPath" 
