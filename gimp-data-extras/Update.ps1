Import-Module chocolatey-au

$releases = 'https://download.gimp.org/gimp/extras/'

function global:au_BeforeUpdate {
    $Latest.Checksum = Get-RemoteChecksum $Latest.URL
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "gimp-data-extras-\d+(\.\d+)+"    = "gimp-data-extras-$($Latest.Version)"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $versions = @(
        [regex]::Matches($page.Content, 'gimp-data-extras-(\d+(?:\.\d+)+)\.tar\.bz2') |
            ForEach-Object { [version]$_.Groups[1].Value } |
            Sort-Object -Descending -Unique
    )

    if ($versions.Count -eq 0) {
        throw "No gimp-data-extras tarballs found at $releases"
    }

    $version = $versions[0].ToString()

    @{
        Version = $version
        URL     = "${releases}gimp-data-extras-$version.tar.bz2"
    }
}

try {
    update -ChecksumFor none
}
catch {
    $ignore = 'Not Found'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' } else { throw $_ }
}