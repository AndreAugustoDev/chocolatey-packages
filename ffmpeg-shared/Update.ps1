Import-Module au

$releases = 'https://www.gyan.dev/ffmpeg/builds'

function global:au_GetLatest   {
  $download_page = Invoke-WebRequest -Uri "$releases/packages/" -UseBasicParsing -Header @{ Referer = $releases }
  $re			 = 'full_build-shared\.7z$'
  $url64		 = $download_page.links | ? href -match $re | Select -Expand href -First 1
  $rv			 = ($url64 -split '/ffmpeg-')[-1] -split '-' | Select -SkipLast 2
  $version		 = $rv[0] + '.' + ($rv[1,2,3] -join '')
  $dlversion	 = $rv -join '-'
  @{
    URL64 			= "https://github.com/GyanD/codexffmpeg/releases/download/${dlversion}/ffmpeg-${dlversion}-full_build-shared.7z"
    Version 		= $version
	ChecksumType64	= 'sha256'
	DownloadVersion	= $dlversion
  }
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
			"(^[$]version\s*=\s*)('.*')"      = "`$1'$($Latest.DownloadVersion)'"
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