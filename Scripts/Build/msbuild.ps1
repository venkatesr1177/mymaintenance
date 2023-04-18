# # Define variables
$projectName = "myMaintenance"
$tfsUrl = "http://tfs:8080/tfs/DefaultCollection"
$tfsProjectPath = "$/Enterprise Applications/NAM/myMainteance/Main"
$buildConfig = "Release"
$outputPath = "C:\BuildOutput"
$localWorkspacePath = "C:\test101"

# # Map the TFS project to a local workspace
# tf workspace -new MyWorkspace /noprompt /comment:"Creating a new workspace" /permission:PublicLimited /collection:$tfsUrl /login:sysadmin,test@123456789

# tf workfold /map /collection:$tfsUrl /workspace:MyWorkspace $tfsProjectPath $localWorkspacePath

# # Get the latest version of the TFS project
# tf.exe get /all /recursive /force /overwrite $localWorkspacePath

# # Invoke MSBuild to build the project
# msbuild.exe /t:Build /p:Configuration=$buildConfig /p:OutDir="$outputPath" /p:Platform="Any CPU" "$localWorkspacePath\$projectName.csproj" /p:VisualStudioVersion=14.0 /m

# # Check if the build succeeded
# if ($LASTEXITCODE -ne 0) {
#     Write-Error "Build failed with exit code $($LASTEXITCODE)"
#     exit $LASTEXITCODE
# }

# Write-Output "Build succeeded"

# # Delete the local workspace
# tf workspace /delete /noprompt MyWorkspace; 


git tfs clone --branches=auto http://tfs:8080/tfs/DefaultCollection  '$/Enterprise Applications/NAM/myMainteance/Main'

Write-Host  "$localWorkspacePath\Main\$projectName\$projectName.csproj"

msbuild.exe /t:Build /p:Configuration=$buildConfig /p:OutDir="$outputPath"  "$localWorkspacePath\Main\$projectName\$projectName.csproj" /p:VisualStudioVersion=14.0 /m


msbuild "$localWorkspacePath\Main\$projectName\$projectName.csproj"