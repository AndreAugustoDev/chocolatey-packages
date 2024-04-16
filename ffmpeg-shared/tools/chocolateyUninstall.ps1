$ErrorActionPreference = 'Stop';
$toolsPath              = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
}

Remove-Item -Recurse -Force -Path "$toolsPath"
