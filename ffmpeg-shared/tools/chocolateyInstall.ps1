$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version	= '4.4.1'
$dir 		= "ffmpeg-${version}-full_build-shared"
$url64      = 'https://github.com/GyanD/codexffmpeg/releases/download/4.4.1/ffmpeg-4.4.1-full_build-shared.7z'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = "$env:PROGRAMFILES"
  url64bit       = $url64
  softwareName   = 'ffmpeg*'
  checksum64     = ''
  checksumType64 = 'sha256'
  SpecificFolder = "$dir"
}

Install-ChocolateyZipPackage @packageArgs
Copy-Item -Recurse -Force -Path "$env:PROGRAMFILES\$dir" -Destination "$env:PROGRAMFILES\FFmpeg" | Out-Null
Remove-Item -Recurse -Force -Path "$env:PROGRAMFILES\$dir" | Out-Null
