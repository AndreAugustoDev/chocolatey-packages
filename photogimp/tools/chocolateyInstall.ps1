$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Diolinux/PhotoGIMP/releases/download/1.0/PhotoGIMP.by.Diolinux.v2020.for.Flatpak.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$toolsDir\pkg"
  url           = $url
  softwareName  = 'PhotoGIMP'
  checksum      = '579DB0BE5FE4AC6669555F3C433D70FAA10D27527FDC119D3A464A2E2A729FAD'
  checksumType  = 'sha256'
}

$downloadArgs = @{
	packageName		= $env:ChocolateyPackageName
	fileFullPath	= "$toolsDir\pkg.zip"
	url 			= $url
}

Get-ChocolateyWebFile @downloadArgs

7z x "$toolsDir\pkg.zip" -o"$env:TEMP\chocolatey\photogimp" -y -bso0 -bd -aoa
$path = "PhotoGIMP by Diolinux v2020 for Flatpak\.var\app\org.gimp.GIMP\config\GIMP\2.10\*"
Write-Host "PhotoGIMP patch extracted to $env:APPDATA\GIMP\2.10"
Copy-Item -Path "$env:TEMP\chocolatey\photogimp\$path" -Destination "$env:APPDATA\GIMP\2.10" -Recurse -Force
Remove-Item -Recurse -Force -Path "$env:TEMP\chocolatey\photogimp"