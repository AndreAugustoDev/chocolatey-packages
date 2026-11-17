$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/Diolinux/PhotoGIMP/releases/download/3.1/PhotoGIMP.zip'
$GIMPdata = "$env:APPDATA\GIMP"

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = $url
  checksum     = 'de6a17ffb70000051372d84141b7e69fc2e60a0af3bd3b3100c9afd5e0ff3ae6'
  checksumType = 'sha256'
}

$zipFile = Join-Path $env:TEMP "PhotoGIMP-$($env:ChocolateyPackageVersion).zip"

try {
  Get-ChocolateyWebFile -PackageName $packageArgs.packageName `
    -FileFullPath $zipFile `
    -Url $packageArgs.url `
    -Checksum $packageArgs.checksum `
    -ChecksumType $packageArgs.checksumType | Out-Null
  
  # Generate the list of files to uninstall from the actual contents of the zip.
  # The paths are relative to "$GIMPdata" (the zip contains the folder "3.0\...").
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  $archive = [System.IO.Compression.ZipFile]::OpenRead($zipFile)
  try {
    $entries = @($archive.Entries | ForEach-Object { $_.FullName -replace '/', '\' })
  }
  finally {
    $archive.Dispose()
  }

  $listFile = Join-Path $toolsDir 'installed-files.txt'
  [System.IO.File]::WriteAllLines($listFile, [string[]]$entries, (New-Object System.Text.UTF8Encoding($false)))

  Get-ChocolateyUnzip -FileFullPath $zipFile -Destination $GIMPdata -PackageName $packageArgs.packageName | Out-Null
}
finally {
  Remove-Item -LiteralPath $zipFile -Force -ErrorAction SilentlyContinue
}
