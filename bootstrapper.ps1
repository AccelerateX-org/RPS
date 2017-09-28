$repositoryOwner = "AccelerateX-org"
$repositoryName = "RPS"
$branch = "develop"

$path = ".\Build"
$guid = [guid]::NewGuid()

$downloadURL = [string]::Format("https://github.com/{0}/{1}/archive/{2}.zip", $repositoryOwner, $repositoryName, $branch)
$downloadFile = ".\" + $guid + ".zip"
$tempDir =  ".\" + $guid
$buildDefinitions = [string]::Format("{0}\{1}-{2}\BuildDefinitions\*", $tempDir, $repositoryName, $branch)

If(!(Test-Path $path))
{
    New-Item -ItemType Directory -Force -Path $path | Out-Null
}

Invoke-WebRequest $downloadURL -OutFile $downloadFile

Expand-Archive -Path $downloadFile -DestinationPath $tempDir

Remove-Item -Path $downloadFile -Force

Copy-Item -Path $buildDefinitions -Recurse -Force -Destination $path -Container

Remove-Item -Path $tempDir -Force -Recurse