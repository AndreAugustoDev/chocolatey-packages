$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version	= '4.3.2-2021-02-02'
$dir 		= "ffmpeg-$version-full_build-shared"
$url64      = "https://github.com/GyanD/codexffmpeg/releases/download/$version/ffmpeg-$version-full_build-shared.7z"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = "$env:PROGRAMFILES"
  url64bit       = $url64
  softwareName   = 'ffmpeg*'
  checksum64     = 'F7622EB4E21BE5413CBC67B3EA0CB90369D6A4DF0F64CD2C98378787E55216B3'
  checksumType64 = 'sha256'
  SpecificFolder = "$dir"
}

Install-ChocolateyZipPackage @packageArgs
Copy-Item -Recurse -Force -Path "$env:PROGRAMFILES\$dir" -Destination "$env:PROGRAMFILES\FFmpeg" | Out-Null
Remove-Item -Recurse -Force -Path "$env:PROGRAMFILES\$dir" | Out-Null
