# Sample script to install Miniconda under Windows
# Authors: Olivier Grisel, Jonathan Helmus and Kyle Kastner, Robert McGibbon
# License: CC0 1.0 Universal: http://creativecommons.org/publicdomain/zero/1.0/
# Modified by Roberto Di Remigio to install Anaconda

function DownloadAnaconda ($Anaconda_VERSION) {
    $webclient = New-Object System.Net.WebClient
    $filename = "Anaconda3-" + $Anaconda_VERSION + "-Windows-x86_64.exe"
    $url = "https://repo.anaconda.com/archive/" + $filename

    $basedir = $pwd.Path + "\"
    $filepath = $basedir + $filename
    if (Test-Path $filename) {
        Write-Host "Reusing" $filepath
        return $filepath
    }

    # Download and retry up to 3 times in case of network transient errors.
    Write-Host "Downloading" $filename "from" $url
    $retry_attempts = 2
    for($i=0; $i -lt $retry_attempts; $i++){
        try {
            $webclient.DownloadFile($url, $filepath)
            break
        }
        Catch [Exception]{
            Start-Sleep 1
        }
   }
   if (Test-Path $filepath) {
       Write-Host "File saved at" $filepath
   } else {
       # Retry once to get the error message if any at the last try
       $webclient.DownloadFile($url, $filepath)
   }
   return $filepath
}

function InstallAnaconda ($Anaconda_VERSION, $Anaconda_cache) {
    Write-Host "Installing Anaconda" $Anaconda_VERSION
    if (Test-Path $Anaconda_cache) {
        Write-Host "-- Anaconda " $Anaconda_VERSION "FOUND in cache"
        return $false
    }

    Write-Host "-- Anaconda " $Anaconda_VERSION "NOT FOUND in cache"
    $filepath = DownloadAnaconda $Anaconda_VERSION
    Write-Host "Installing" $filepath "to" $Anaconda_cache
    $install_log = $Anaconda_cache + ".log"
    $args = "/InstallationType=JustMe /RegisterPython=0 /S /D=$Anaconda_cache"
    Write-Host $filepath $args
    Start-Process -FilePath $filepath -ArgumentList $args -Wait -Passthru
    if (Test-Path $Anaconda_cache) {
        Write-Host "Anaconda $Anaconda_VERSION installation complete"
    } else {
        Write-Host "Failed to install Python in $Anaconda_cache"
        Get-Content -Path $install_log
        Exit 1
    }
}

function SetUpConda ($Anaconda_cache) {
    $conda_path = $Anaconda_cache + "\Scripts\conda.exe"
    Write-Host "Setting up conda..."

    $args = "config --set always_yes yes --set changeps1 no"
    Write-Host $conda_path $args
    Start-Process -FilePath "$conda_path" -ArgumentList $args -Wait -Passthru

    $args = "update -q conda"
    Write-Host $conda_path $args
    Start-Process -FilePath "$conda_path" -ArgumentList $args -Wait -Passthru

    $args = "info -a"
    Write-Host $conda_path $args
    Start-Process -FilePath "$conda_path" -ArgumentList $args -Wait -Passthru
}


function main () {
    $Anaconda_VERSION = "5.1.0"
    $Anaconda_cache = "C:\Deps\conda"
    InstallAnaconda $Anaconda_VERSION $Anaconda_cache
    SetUpConda $Anaconda_cache
}

main
