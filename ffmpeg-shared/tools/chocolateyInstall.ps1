$ErrorActionPreference = 'Stop';
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.gyan.dev/ffmpeg/builds/packages/ffmpeg-8.1.1-full_build-shared.7z'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsPath
  url           = $url
  checksum      = '7a6c3e86f54b0dd3bceff31f81bf3b70397171fcf35d1a13b9ed9cbf1040fc18'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "$packageName installed to $toolsPath"
