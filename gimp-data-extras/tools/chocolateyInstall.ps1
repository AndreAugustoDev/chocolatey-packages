
$ErrorActionPreference = 'Stop';
$toolsDir   	= "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url 			= 'https://ftp.gimp.org/pub/gimp/extras/gimp-data-extras-2.0.4.tar.bz2'
$GIMPdata   	= "$env:APPDATA\GIMP"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $GIMPdata
  url           = $url
  softwareName  = 'gimp-data-extras*'
  checksum      = '7455e4861101e4c349a6908d6ef91f8acd83bf3dd63131c93b73c46341273f90'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs | Out-Null
Get-ChocolateyUnzip "$GIMPdata\gimp-data-extras-2.0.4.tar" "$GIMPdata" | Out-Null
Get-ChildItem "$GIMPdata\gimp-data-extras-2.0.4\Makefile*" -Recurse | foreach { Remove-Item -Path $_.FullName }
Get-ChildItem "$GIMPdata\gimp-data-extras-2.0.4\*" -File | foreach { Remove-Item -Path $_.FullName }
Copy-Item  -Recurse -Force -Path "$GIMPdata\gimp-data-extras-2.0.4\*" -Destination "$GIMPdata\2.10" | Out-Null
Remove-Item -Recurse -Force -Path "$GIMPdata\gimp-data-extras*" | Out-Null
