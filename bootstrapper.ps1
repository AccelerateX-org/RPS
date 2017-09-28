$repositoryOwner = "AccelerateX-org"
$repositoryName = "RPS"
$branch = "develop"

$path = ".\Build"
$guid = [guid]::NewGuid()

$downloadURL = [string]::Format("https://github.com/{0}/{1}/archive/{2}.zip", $repositoryOwner, $repositoryName, $branch)
$downloadFile = ".\" + $guid + ".zip"
$tempDir =  ".\" + $guid
$base = [string]::Format("{0}\{1}-{2}\", $tempDir, $repositoryName, $branch)
$buildDefinitions = $base + "BuildDefinitions\*"
$cakeBootstrapper = $base + "build.ps1"

If(!(Test-Path $path))
{
    New-Item -ItemType Directory -Force -Path $path | Out-Null
}

Invoke-WebRequest $downloadURL -OutFile $downloadFile

Expand-Archive -Path $downloadFile -DestinationPath $tempDir

Remove-Item -Path $downloadFile -Force

Copy-Item -Path $buildDefinitions -Recurse -Force -Destination $path -Container
Copy-Item -Path $cakeBootstrapper -Force -Destination ".\build.ps1" 

Remove-Item -Path $tempDir -Force -Recurse