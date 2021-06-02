$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64	= 'https://binary-factory.kde.org/job/kdeconnect-kde_Release_win64/607/artifact/kdeconnect-kde-21.04.1-607-windows-msvc2019_64-cl.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url     		= $url64
  softwareName  = 'kdeconnect*'
  checksum64	= 'c4cdb36e4c24c62f22906ec128f5f36a045b2136483826b60cd29904f6d883d2'
  checksumType64= 'sha256'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
