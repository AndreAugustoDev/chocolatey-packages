Import-Module au

$release  = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z.ver'
$checksum = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z.sha256'

function global:au_GetLatest   {
  $get_version = Invoke-WebRequest -Uri "$release" -UseBasicParsing -Header @{ Referer = $release }
  $get_sha256  = Invoke-WebRequest -Uri "$checksum" -UseBasicParsing -Header @{ Referer = $checksum }
  $version     = $get_version.ToString()
  $sha256      = $get_sha256.ToString()
  @{
    URL64 			= "https://github.com/GyanD/codexffmpeg/releases/download/${version}/ffmpeg-${version}-full_build-shared.7z"
    Version 		= $version
    Checksum64      = $sha256
	ChecksumType64	= 'sha256'
  }
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
			"(^[$]version\s*=\s*)('.*')"      = "`$1'$($Latest.Version)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
		}
	}
}

try {
    update -ChecksumFor 64
} catch {
    $ignore = 'Not Found'
   if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
