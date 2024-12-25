
$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$GIMPdata = "$env:APPDATA\GIMP\2.10"
. "$toolsDir\helpers.ps1"

ForEach ($file in $files) {
		Remove-Item "$GIMPdata\$file" -Force
}

$tdc = "$GIMPdata"
$dirs = Get-ChildItem $tdc -directory -recurse | Where-Object { (Get-ChildItem $_.fullName).count -eq 0 } | Select-Object -expandproperty FullName
$dirs | Foreach-Object { Remove-Item $_ }