Import-Module au

$metainfo = 'https://invent.kde.org/network/kdeconnect-kde/-/raw/master/data/org.kde.kdeconnect.metainfo.xml'

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
	$metainfo_content  = Invoke-WebRequest -Uri $metainfo -UseBasicParsing
	$releases = Select-Xml -XPath '//release' -Content $metainfo_content
	foreach ($release in $releases) {
		if (!$release.Node.artifacts) {
			continue
		}
		$version = $release.Node.version
		$url64   = $release.Node.artifacts.artifact.location
		break
	}

    return @{
		URL64        	= $url64;
        Version      	= $version;
    }
}

try {
    update -ChecksumFor 64
} catch {
    $ignore = 'Not Found'
   if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
