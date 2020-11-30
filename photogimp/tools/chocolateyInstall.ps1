$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Diolinux/PhotoGIMP/releases/download/1.0/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip'
$GIMPdata   = "$env:APPDATA\GIMP"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = "$env:APPDATA\GIMP"
  url            = $url
  softwareName   = 'PhotoGIMP'
  checksum       = '579DB0BE5FE4AC6669555F3C433D70FAA10D27527FDC119D3A464A2E2A729FAD'
  checksumType   = 'sha256'
  SpecificFolder = "PhotoGIMP by Diolinux v2020 for Flatpak\.var\app\org.gimp.GIMP\config\GIMP\"
}

Install-ChocolateyZipPackage @packageArgs
md -Force "$GIMPdata\2.10" | Out-Null
Copy-Item  -Recurse -Force -Path "$GIMPdata\PhotoGIMP by Diolinux v2020 for Flatpak\.var\app\org.gimp.GIMP\config\GIMP\2.10\*" -Destination "$GIMPdata\2.10" | Out-Null
Remove-Item -Recurse -Force -Path "$GIMPdata\PhotoGIMP by Diolinux v2020 for Flatpak"