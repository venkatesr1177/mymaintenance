$visualStudiopath = 'C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer'

Add-Type -Path "$visualStudiopath\Microsoft.TeamFoundation.Client.dll"
Add-Type -Path "$visualStudiopath\Microsoft.TeamFoundation.Common.dll"
Add-Type -Path "$visualStudiopath\Microsoft.TeamFoundation.VersionControl.Client.dll"

# TFS Collection URL
$collectionUrl = "http://tfs:8080/tfs/DefaultCollection"

# Create TFS connection object
$tfsCollection = [Microsoft.TeamFoundation.Client.TfsTeamProjectCollectionFactory]::GetTeamProjectCollection($collectionUrl)

# Get version control server object
$versionControl = $tfsCollection.GetService([Microsoft.TeamFoundation.VersionControl.Client.VersionControlServer])

Write-Host $versionControl

# Get root folder for version control
$rootFolder = $versionControl.GetItem("$/")


# Get items recursively in root folder
$items = $versionControl.GetItems($rootFolder.ServerItem, [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::Full)

foreach ($item in $items) {
       if ($item.ItemType -eq "File") {
           # Get file size
           $fileSize = $item.ContentLength
   
           Write-Output "File: $($item.ServerItem) Size: $($fileSize / 1KB) KB"
       }
       else {
              

           $folderItems = $versionControl.GetItems($item.ServerItem + "/*", [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::Full)
           $folderSize = ($folderItems | Measure-Object Length -Sum).Sum
   
           Write-Output "Folder: $($item.ServerItem) Size: $($folderSize / 1KB) KB"
       }
   }