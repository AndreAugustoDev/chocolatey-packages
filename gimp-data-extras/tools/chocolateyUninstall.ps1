
$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$GIMPdata = "$env:APPDATA\GIMP\2.10"
. "$toolsDir\helpers.ps1"

ForEach ($file in $files) {
		Remove-Item "$GIMPdata\$file" -Force
}
