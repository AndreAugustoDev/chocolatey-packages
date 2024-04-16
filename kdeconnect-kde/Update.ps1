Import-Module chocolatey-au

$metainfo = 'https://invent.kde.org/network/kdeconnect-kde/-/raw/master/data/org.kde.kdeconnect.metainfo.xml'

function global:au_BeforeUpdate() {
    # $wc = [System.Net.WebClient]::new()
    # $RemoteFileHash = Get-FileHash -InputStream ($wc.OpenRead($Latest.URL64))
    # $Latest.Checksum64 = $RemoteFileHash.hash
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
		$version    = $release.Node.version
		$url64      = $release.Node.artifacts.artifact.location
        $checksum64 = $release.Node.artifacts.artifact.checksum
		break
	}

    return @{
		URL64        	= $url64;
        Version      	= $version;
        Checksum64   	= $checksum64;
    }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = 'Not Found'
   if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
