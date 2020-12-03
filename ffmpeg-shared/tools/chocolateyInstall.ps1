$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version	= '4.3.1-2020-11-19'
$dir 		= "ffmpeg-$version-full_build-shared"
$url64      = "https://github.com/GyanD/codexffmpeg/releases/download/$version/ffmpeg-$version-full_build-shared.7z"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = "$env:PROGRAMFILES"
  url64bit       = $url64
  softwareName   = 'ffmpeg*'
  checksum64     = 'c1be009528e2af88efa1f80ea977835ad1b5bd70f768dd9604e317699b9870b2'
  checksumType64 = 'sha256'
  SpecificFolder = "$dir"
}

Install-ChocolateyZipPackage @packageArgs
Copy-Item -Recurse -Force -Path "$env:PROGRAMFILES\$dir" -Destination "$env:PROGRAMFILES\FFmpeg" | Out-Null
Remove-Item -Recurse -Force -Path "$env:PROGRAMFILES\$dir" | Out-Null
