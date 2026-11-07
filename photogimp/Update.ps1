Import-Module chocolatey-au

$releasesUrl = 'https://api.github.com/repos/Diolinux/PhotoGIMP/releases/latest'
$assetName = 'PhotoGIMP.zip'

function global:au_BeforeUpdate {
    $Latest.Checksum = Get-RemoteChecksum $Latest.URL
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
        ".\photogimp.nuspec"            = @{
            "(<releaseNotes>).*(</releaseNotes>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $headers = @{ 'User-Agent' = 'chocolatey-au'; 'Accept' = 'application/vnd.github+json' }
    if ($env:github_api_key) {
        $headers['Authorization'] = "Bearer $($env:github_api_key)"
    }

    $release = Invoke-RestMethod -Uri $releasesUrl -Headers $headers

    $version = $release.tag_name -replace '^[vV]', ''
    if ($version -notmatch '^\d+(\.\d+)+$') {
        throw "Unexpected release tag: $($release.tag_name)"
    }

    $asset = $release.assets | Where-Object { $_.name -eq $assetName } | Select-Object -First 1
    if (-not $asset) {
        throw "Asset '$assetName' not found in release $($release.tag_name)"
    }

    @{
        Version      = $version
        URL          = $asset.browser_download_url
        ReleaseNotes = $release.html_url
    }
}

try {
    update -ChecksumFor none
}
catch {
    $ignore = 'Not Found'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' } else { throw $_ }
}