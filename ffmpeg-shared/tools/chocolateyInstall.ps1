$ErrorActionPreference = 'Stop';
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z'
$checksum = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z.sha256'
$get_sha256 = (Invoke-WebRequest -Uri "$checksum" -UseBasicParsing -Header @{ Referer = $checksum }).ToString()

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsPath
  url           = $url
  checksum      = $get_sha256
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "$packageName installed to $toolsPath"
