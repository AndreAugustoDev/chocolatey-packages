import-module au

$releases = 'https://github.com/KDE/kdeconnect-kde/releases'
$artifacts64 = 'https://binary-factory.kde.org/view/Windows%2064-bit/job/kdeconnect-kde_Release_win64/lastSuccessfulBuild/artifact/'

function global:au_GetLatest {  
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url           = $download_page.links | ? href -match '.zip$' | select -First 1 -expand href
  $kdeversion    = ($url -split '/|.zip' | select -Last 1 -Skip 1).Replace('v','')
  $version       = ((Invoke-WebRequest $artifacts64 -UseBasicParsing).links | ? href -match '.exe$' | select -First 1 -expand href) -split '-' | select -First 1 -Skip 2
  $build64       = ((Invoke-WebRequest $artifacts64 -UseBasicParsing).links | ? href -match '.exe$' | select -First 1 -expand href) -split '-' | select -First 1 -Skip 3

    @{
        URL64        = 'https://binary-factory.kde.org/view/Windows%2064-bit/job/kdeconnect-kde_Release_win64/'+ $build64 +'/artifact/kdeconnect-kde-' + $version + '-' + $build64 + '-windows-msvc2019_64-cl.exe'
        Version      = $version
        ReleaseNotes = 'https://kde.org/announcements/changelog-releases.php?version=' + $kdeversion + '#kdeconnect-kde'
    }

}

function global:au_SearchReplace {
        @{
        "kdeconnect.nuspec" = @{
            "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
            }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*`").*" = "`${1}$($Latest.URL64)`""
            }
        }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = 'Not Found'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
