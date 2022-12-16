Import-Module au

$releases = 'https://invent.kde.org/network/kdeconnect-kde/-/tags'
$artifacts64 = 'https://binary-factory.kde.org/job/kdeconnect-kde_Release_win64/lastSuccessfulBuild/artifact/'

function global:au_BeforeUpdate() {
    $wc = [System.Net.WebClient]::new()
    $RemoteFileHash = Get-FileHash -InputStream ($wc.OpenRead($Latest.URL64))
    $Latest.Checksum64 = $RemoteFileHash.hash
  }

function global:au_SearchReplace {
        @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
			}
        }
}

function global:au_GetLatest {
	$download_page     = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$artifacts64_page  = Invoke-WebRequest $artifacts64 -UseBasicParsing
	$url64             = $download_page.links | ? href -match '.zip$' | select -First 1 -expand href
	$kdeversion        = ($url64 -split '/|.zip' | select -Last 1 -Skip 1).Replace('v','')
	$version           = ($artifacts64_page.links | ? href -match '.exe$' | select -First 1 -expand href) -split '-' | select -First 1 -Skip 2
	$build64           = ($artifacts64_page.links | ? href -match '.exe$' | select -First 1 -expand href) -split '-' | select -First 1 -Skip 3

    return @{
		URL64        	= 'https://binary-factory.kde.org/job/kdeconnect-kde_Release_win64/lastSuccessfulBuild/artifact/kdeconnect-kde-' + $version + '-' + $build64 + '-windows-cl-msvc2019-x86_64.exe';
        Version      	= $version + '.' + $build64;
    }
}

try {
    update -ChecksumFor 64
} catch {
    $ignore = 'Not Found'
   if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
