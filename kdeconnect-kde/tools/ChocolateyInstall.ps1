$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64	= 'https://download.kde.org/stable/release-service/23.04.0/windows/kdeconnect-kde-23.04.0-1322-windows-cl-msvc2019-x86_64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url     		= $url64
  softwareName  = 'kdeconnect*'
  checksum64	= 'B32A83AC7F89F284C2330B5DD01F430294D1ADB201AB5C0F11AAE19F29866EAE'
  checksumType64= 'sha256'
  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
