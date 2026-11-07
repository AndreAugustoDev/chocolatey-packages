Import-Module chocolatey-au

$metainfo = 'https://raw.githubusercontent.com/KDE/kdeconnect-kde/refs/heads/master/data/org.kde.kdeconnect.metainfo.xml'

function global:au_BeforeUpdate() {
    # $wc = [System.Net.WebClient]::new()
    # $RemoteFileHash = Get-FileHash -InputStream ($wc.OpenRead($Latest.URL64))
    # $Latest.Checksum64 = $RemoteFileHash.hash
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $content = (Invoke-WebRequest -Uri $metainfo -UseBasicParsing).Content
    $releases = Select-Xml -XPath '//release' -Content $content

    foreach ($release in $releases) {
        $artifact = $release.Node.SelectSingleNode("artifacts/artifact[@type='binary' and contains(@platform,'windows')]")
        if (-not $artifact) {
            continue
        }

        return @{
            Version    = $release.Node.version;
            URL64      = $artifact.SelectSingleNode('location').InnerText;
            Checksum64 = $artifact.SelectSingleNode('checksum').InnerText;
        }
    }

    throw "No release with a Windows artifact found in $metainfo"
}

try {
    update -ChecksumFor none
}
catch {
    $ignore = 'Not Found'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
