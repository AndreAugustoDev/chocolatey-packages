$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$GIMPdata = "$env:APPDATA\GIMP"
$listFile = Join-Path $toolsDir 'installed-files.txt'

if (-not (Test-Path -LiteralPath $listFile)) {
  Write-Warning "Installed file list not found ($listFile). Nothing will be removed."
}
else {
  $root = [System.IO.Path]::GetFullPath($GIMPdata).TrimEnd('\') + '\'
  $entries = @(Get-Content -LiteralPath $listFile -Encoding UTF8 | Where-Object { $_.Trim() })
  $dirs = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)

  foreach ($entry in $entries) {
    $full = [System.IO.Path]::GetFullPath((Join-Path $GIMPdata $entry)).TrimEnd('\')
    
		# Only remove files and folders that are inside the GIMP data directory, ignoring any paths that are outside of it.
    if (-not ($full + '\').StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
      Write-Warning "Ignoring path outside of $GIMPdata`: $entry"
      continue
    }

    if ($entry.EndsWith('\')) {
      [void]$dirs.Add($full)
    }
    else {
      Remove-Item -LiteralPath $full -Force -ErrorAction SilentlyContinue
    }

		# Parents (up to "$GIMPdata", exclusive) are also candidates for removal
    $parent = [System.IO.Path]::GetDirectoryName($full)
    while ($parent -and (($parent + '\') -ne $root) -and ($parent + '\').StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
      [void]$dirs.Add($parent)
      $parent = [System.IO.Path]::GetDirectoryName($parent)
    }
  }

  # Remove only folders that are empty (the deepest ones first)
  $dirs | Sort-Object Length -Descending | ForEach-Object {
    if ((Test-Path -LiteralPath $_ -PathType Container) -and -not (Get-ChildItem -LiteralPath $_ -Force | Select-Object -First 1)) {
      Remove-Item -LiteralPath $_ -Force -ErrorAction SilentlyContinue
    }
  }
}