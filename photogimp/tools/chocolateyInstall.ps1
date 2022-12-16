$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Diolinux/PhotoGIMP/releases/download/1.1/PhotoGIMP.by.Diolinux.v2020.1.for.Flatpak.zip'
$GIMPdata   = "$env:APPDATA\GIMP"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = "$env:APPDATA\GIMP"
  url            = $url
  softwareName   = 'PhotoGIMP'
  checksum       = 'cae2739dc54ea90baec832f4ad60d8d5cc2dd1533f06acc91e95318f6f205e3b'
  checksumType   = 'sha256'
  SpecificFolder = "PhotoGIMP.by.Diolinux.v2020.1.for.Flatpak\.var\app\org.gimp.GIMP\config\GIMP\"
}

Install-ChocolateyZipPackage @packageArgs
md -Force "$GIMPdata\2.10" | Out-Null
Copy-Item  -Recurse -Force -Path "$GIMPdata\PhotoGIMP.by.Diolinux.v2020.1.for.Flatpak\.var\app\org.gimp.GIMP\config\GIMP\2.10\*" -Destination "$GIMPdata\2.10" | Out-Null
Remove-Item -Recurse -Force -Path "$GIMPdata\PhotoGIMP.by.Diolinux.v2020.1.for.Flatpak"