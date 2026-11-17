Import-Module chocolatey-au

$release = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z.ver'
$checksum = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z.sha256'
$url = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
    }
  }
}

function global:au_GetLatest {
  return @{
    URL          = $url
    Version      = (Invoke-WebRequest -Uri "$release" -UseBasicParsing -Header @{ Referer = $release }).ToString()
    Checksum     = (Invoke-WebRequest -Uri "$checksum" -UseBasicParsing -Header @{ Referer = $checksum }).ToString()
  }
}

try {
  update -ChecksumFor none
}
catch {
  $ignore = 'Not Found'
  if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
