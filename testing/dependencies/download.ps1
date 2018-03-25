# Copied from: https://raw.githubusercontent.com/mpi4py/mpi4py/master/conf/ci/appveyor/download.ps1
# Author:  Lisandro Dalcin
# Contact: dalcinl@gmail.com

function Download ($url, $filename, $destdir) {
    if ($destdir) {
        $item = New-Item $destdir -ItemType directory -Force
        $destdir = $item.FullName
    } else {
        $destdir = $pwd.Path
    }
    $filepath = Join-Path $destdir $filename
    if (Test-Path $filepath) {
        Write-Host "Reusing" $filename "from" $destdir
        return $filepath
    }
    Write-Host "Downloading" $filename "from" $url
    $webclient = New-Object System.Net.WebClient
    foreach($i in 1..3) {
        try {
            $webclient.DownloadFile($url, $filepath)
            Write-Host "File saved at" $filepath
            return $filepath
        }
        Catch [Exception] {
            Start-Sleep 1
        }
    }
    Write-Host "Failed to download" $filename "from" $url
    return $null
}
