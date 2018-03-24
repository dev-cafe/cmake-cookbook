function Download ($filename, $url) {
  $webclient = New-Object System.Net.WebClient

  $basedir = $pwd.Path + "\"
  $filepath = $basedir + $filename
  if (Test-Path $filename) {
    Write-Host "Reusing" $filepath
    return $filepath
  }

  # Download and retry up to 3 times in case of network transient errors.
  Write-Host "Downloading" $filename "from" $url
  $retry_attempts = 2
  for ($i = 0; $i -lt $retry_attempts; $i++) {
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

function main () {
  # Install dependencies in C:\projects\deps
  New-Item -ItemType Directory -Force -Path C:\projects\deps
  Set-Location -Path C:\projects\deps
  if (($env:GENERATOR -eq "Visual Studio 14 2015") `
      -or ($env:GENERATOR -eq "Visual Studio 15 2017")) {
      vcpkg integrate install
      vcpkg install msmpi hdf5
  } else {
      mingw-get install fortran
  }
  # Install Kitware-maintained Ninja
  $ninjaurl = "https://github.com/Kitware/ninja/releases/download/v1.7.2.gaad58.kitware.dyndep-1/ninja-1.7.2.gaad58.kitware.dyndep-1_i686-pc-windows-msvc.zip"
  Download "ninja.zip" $ninjaurl
  $outputpath = "C:\projects\deps\ninja"
  New-Item -ItemType Directory -Force -Path $outputpath
  7z e ninja.zip "-o${outputpath}"
  # Upgrade to the latest version of pip to avoid it displaying warnings
  # about it being out of date.
  pip install --disable-pip-version-check --user --upgrade pip pipenv
}

main
