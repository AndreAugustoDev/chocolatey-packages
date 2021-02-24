$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64	= 'https://binary-factory.kde.org/job/kdeconnect-kde_Release_win64/507/artifact/kdeconnect-kde-1.4-507-windows-msvc2019_64-cl.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url     		= $url64
  softwareName  = 'kdeconnect*'
  checksum64	= '8f68566ed7219ba5f2a69087f2d1e0cf386f93e3d39992c9aa8aa6d67e071d4b'
  checksumType64= 'sha256'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
