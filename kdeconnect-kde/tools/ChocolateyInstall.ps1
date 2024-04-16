$ErrorActionPreference  = 'Stop';
$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64	                = 'https://download.kde.org/stable/release-service/24.02.0/windows/kdeconnect-kde-release_24.02-3692-windows-cl-msvc2022-x86_64.exe'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  fileType        = 'exe'
  url64     		  = $url64
  softwareName    = 'kdeconnect*'
  checksum64	    = '8f7eb541bbe21a5fb1800d5f362fe1ea25328631894c30e937bd4bc259327ebd'
  checksumType64  = 'sha256'

  silentArgs      = '/S'
  validExitCodes  = @(0)
}

Install-ChocolateyPackage @packageArgs
