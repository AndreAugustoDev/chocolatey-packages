$ErrorActionPreference = 'Stop';
$url64 = 'https://download.kde.org/stable/release-service/26.08.2/windows/kdeconnect-kde-windows-cl-msvc2022-x86_64.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64          = $url64
  softwareName   = 'kdeconnect*'
  checksum64     = '5a3536bd37673599aab651ca12715a6efcf5a7a1323306c4f979edcca052b7d'
  checksumType64 = 'sha256'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
