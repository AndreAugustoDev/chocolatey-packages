Import-Module chocolatey-au

$releaseVersionUrl = 'https://www.gyan.dev/ffmpeg/builds/release-version'
$urlBase = 'https://www.gyan.dev/ffmpeg/builds/packages'

function global:au_GetLatest {
  $version = (Invoke-WebRequest -Uri $releaseVersionUrl -UseBasicParsing).Content.Trim()
  $url = "$urlBase/ffmpeg-$version-full_build-shared.7z"
  $checksumUrl = "$urlBase/ffmpeg-$version-full_build-shared.7z.sha256"
  $sha256 = ((Invoke-WebRequest -Uri $checksumUrl -UseBasicParsing).Content -split '\s+')[0]
  @{
    URL          = $url
    Version      = $version
    Checksum     = $sha256
    ChecksumType = 'sha256'
  }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
    }
  }
}

try {
  update -ChecksumFor none
}
catch {
  $ignore = 'Not Found'
  if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
