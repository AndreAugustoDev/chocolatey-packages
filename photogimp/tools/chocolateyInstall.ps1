$ErrorActionPreference = 'Stop';
$url = 'https://github.com/Diolinux/PhotoGIMP/releases/download/3.0/PhotoGIMP.zip'
$GIMPdata = "$env:APPDATA\GIMP"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $GIMPdata
  url           = $url
  softwareName  = 'PhotoGIMP'
  checksum      = '3CDC73D36851923B25E55388ECD400AE9A987C7D4F5D882E48F857EE8044DDF6'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
