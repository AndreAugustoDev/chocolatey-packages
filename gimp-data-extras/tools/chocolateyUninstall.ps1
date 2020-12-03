
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\helpers.ps1"
$GIMPdata	= "$env:APPDATA\GIMP\2.10"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'gimp-data-extras*'
}

$uninstalled = $false

ForEach ($file in $files){
		Remove-Item "$GIMPdata\$file" -Force
	}
	