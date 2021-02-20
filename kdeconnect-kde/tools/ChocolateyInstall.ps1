$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64	= 'https://binary-factory.kde.org/job/kdeconnect-kde_Release_win64/503/artifact/kdeconnect-kde-1.4-503-windows-msvc2019_64-cl.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url     		= $url64
  softwareName  = 'kdeconnect*'
  checksum64	= ''
  checksumType64= 'sha256'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
