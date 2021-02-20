
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\helpers.ps1"
$GIMPdata	= "$env:APPDATA\GIMP\2.10"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = $env:ChocolateyPackageName
}

$uninstalled = $false

ForEach ($file in $files){
		Remove-Item "$GIMPdata\$file" -Force
	}

$tdc="$GIMPdata"
$dirs = gci $tdc -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName
$dirs | Foreach-Object { Remove-Item $_ }
	