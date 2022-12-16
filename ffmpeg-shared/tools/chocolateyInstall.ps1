$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version	= '5.1.2'
$dir 		= "ffmpeg-${version}-full_build-shared"
$url64      = 'https://github.com/GyanD/codexffmpeg/releases/download/5.1.2/ffmpeg-5.1.2-full_build-shared.7z'

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
