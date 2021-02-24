$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version	= '4.3.2-2021-02-20'
$dir 		= "ffmpeg-${version}-full_build-shared"
$url64      = 'https://github.com/GyanD/codexffmpeg/releases/download/4.3.2-2021-02-20/ffmpeg-4.3.2-2021-02-20-full_build-shared.7z'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = "$env:PROGRAMFILES"
  url64bit       = $url64
  softwareName   = 'ffmpeg*'
  checksum64     = '149eeb4ddda840d3c072c1083cee3552fb19d6e086bedd7030c2eea6dd12950a'
  checksumType64 = 'sha256'
  SpecificFolder = "$dir"
}

Install-ChocolateyZipPackage @packageArgs
Copy-Item -Recurse -Force -Path "$env:PROGRAMFILES\$dir" -Destination "$env:PROGRAMFILES\FFmpeg" | Out-Null
Remove-Item -Recurse -Force -Path "$env:PROGRAMFILES\$dir" | Out-Null
