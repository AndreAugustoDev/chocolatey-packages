$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ffmpeg*'
}

Remove-Item -Recurse -Force -Path "$env:PROGRAMFILES\FFmpeg"
