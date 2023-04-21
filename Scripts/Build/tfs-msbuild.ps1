# # Define variables
$projectName = "myMaintenance"
$tfsUrl = "http://tfs:8080/tfs/DefaultCollection"
$tfsProjectPath = "$/Enterprise Applications/NAM/myMaintenance/Main"
$buildConfig = "Release"
$outputPath = "C:\BuildOutput"
$localWorkspacePath = "C:\test101"
$workSpaceName = "test101"

# Map the TFS project to a local workspace
tf workspace -new $workSpaceName /noprompt /comment:"Creating a new workspace" /permission:PublicLimited /collection:$tfsUrl /login:sysadmin,test@123456789

tf workfold /map /collection:$tfsUrl /workspace:$workSpaceName $tfsProjectPath $localWorkspacePath

# Get the latest version of the TFS project
tf.exe get /recursive /force /overwrite $localWorkspacePath

# Invoke MSBuild to build the project
msbuild.exe /t:Build /p:Configuration=$buildConfig /p:OutDir="$outputPath" "$localWorkspacePath\$projectName\$projectName.csproj"  

# Check if the build succeeded
if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed with exit code $($LASTEXITCODE)"
    exit $LASTEXITCODE
}

Write-Output "Build succeeded"

# Delete the local workspace
tf workspace /delete /noprompt $workSpaceName; 