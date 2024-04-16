Import-Module chocolatey-au

$release  = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z.ver'
$checksum = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z.sha256'
$url      = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z'
# $url    = "https://github.com/GyanD/codexffmpeg/releases/download/${version}/ffmpeg-${version}-full_build-shared.7z"

function global:au_GetLatest   {
  $get_version = Invoke-WebRequest -Uri "$release" -UseBasicParsing -Header @{ Referer = $release }
  $get_sha256  = Invoke-WebRequest -Uri "$checksum" -UseBasicParsing -Header @{ Referer = $checksum }
  $version     = $get_version.ToString()
  $sha256      = $get_sha256.ToString()
  @{
    URL    			    = $url
    Version 		    = $version
    Checksum        = $sha256
	  ChecksumType  	= 'sha256'
  }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]version\s*=\s*)('.*')"        = "`$1'$($Latest.Version)'"
      "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum)'"
    }
  }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = 'Not Found'
   if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
