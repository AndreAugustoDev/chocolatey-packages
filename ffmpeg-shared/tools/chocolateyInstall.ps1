$ErrorActionPreference = 'Stop';
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsPath
  url           = $url
  checksum      = '4d2060a8b34a940aa47d785142055bb92a63053781e55f2ace4546edd519a8f5'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "$($env:ChocolateyPackageName) installed to $toolsPath"
