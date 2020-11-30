$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://binary-factory.kde.org/view/Windows%2064-bit/job/kdeconnect-kde_Release_win64/422/artifact/kdeconnect-kde-1.4-422-windows-msvc2019_64-cl.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url64bit      = $url64
  softwareName  = 'KDE Connect*'
  checksum64	= 'baee9324e592b08db85edddcb9b5aeb880f6cd1053bbe3d817ecb4450e52eddf'
  checksumType64= 'sha256'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
