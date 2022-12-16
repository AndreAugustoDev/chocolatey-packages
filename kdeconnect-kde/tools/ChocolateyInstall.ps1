$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64	= 'https://binary-factory.kde.org/job/kdeconnect-kde_Release_win64/lastSuccessfulBuild/artifact/kdeconnect-kde-22.12.0-1189-windows-cl-msvc2019-x86_64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url     		= $url64
  softwareName  = 'kdeconnect*'
  checksum64	= 'bc646e6048647f0da6818639b3bb14b8253aee954373d3e2d265e573cd89ea99'
  checksumType64= 'sha256'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
