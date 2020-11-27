$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'kdeconnect-kde'
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url64bit      = 'https://binary-factory.kde.org/job/kdeconnect-kde_Release_win64/lastSuccessfulBuild/artifact/kdeconnect-kde-1.4-418-windows-msvc2019_64-cl.exe'
  softwareName  = 'KDE Connect*'
  checksum64    = '47EA14BCB2BF62880B23CCDEA8A931BAF5276D89605F6F23FA9888A20A2D6AC7'
  checksumType64= 'sha256'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs