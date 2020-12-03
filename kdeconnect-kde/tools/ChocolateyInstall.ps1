$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://binary-factory.kde.org/view/Windows%2064-bit/job/kdeconnect-kde_Release_win64/424/artifact/kdeconnect-kde-1.4-424-windows-msvc2019_64-cl.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url64bit      = $url64
  softwareName  = 'KDE Connect*'
  checksum64	= 'e83eefba341130be6e9a3ca85747330a9461f79d2ef9194df88329344a45a6d6'
  checksumType64= 'sha256'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
