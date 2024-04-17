$ErrorActionPreference = 'Stop';
$toolsPath              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
}

Remove-Item -Recurse -Force -Path "$toolsPath"
