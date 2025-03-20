$ErrorActionPreference = 'Stop';
$url = 'https://github.com/Diolinux/PhotoGIMP/releases/download/3.0/PhotoGIMP.zip'
$GIMPdata = "$env:APPDATA\GIMP"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = "$env:APPDATA\GIMP"
  url            = $url
  softwareName   = 'PhotoGIMP'
  checksum       = '3CDC73D36851923B25E55388ECD400AE9A987C7D4F5D882E48F857EE8044DDF6'
  checksumType   = 'sha256'
  SpecificFolder = "3.0"
}

Install-ChocolateyZipPackage @packageArgs
New-Item -Path "$GIMPdata\3.0" -Force | Out-Null
Copy-Item  -Recurse -Force -Path "$GIMPdata\*" -Destination "$GIMPdata\3.0" | Out-Null
Remove-Item -Recurse -Force -Path "$GIMPdata"