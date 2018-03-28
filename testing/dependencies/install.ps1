$ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
. "$ScriptDir\download.ps1"

function main () {
  $DownloadDir = "C:\projects\downloads"
  $DepsDir = "C:\projects\deps"
  # Check if C:\projects\deps exists
  if(!(Test-Path -Path C:\projects\deps)){
    New-Item -ItemType Directory -Force -Path $DepsDir
  }
  # Move into C:\projects\deps
  Set-Location -Path $DepsDir
  # MS-MPI
  if(!(Test-Path -Path C:\projects\deps\MSMPI)){
    . "$ScriptDir\install-msmpi.ps1"
    InstallMicrosoftMPI
  }
  # Ninja
  if(!(Test-Path -Path C:\projects\deps\ninja)){
    $ninjaurl = "https://github.com/Kitware/ninja/releases/download/v1.7.2.gaad58.kitware.dyndep-1/ninja-1.7.2.gaad58.kitware.dyndep-1_i686-pc-windows-msvc.zip"
    Download $ninjaurl "ninja.zip" $DownloadDir
    $outputpath = "$DepsDir\ninja"
    New-Item -ItemType Directory -Force -Path $outputpath
    7z e "$DownloadDir\ninja.zip" "-o${outputpath}"
  }
  # Eigen
  if(!(Test-Path -Path C:\projects\deps\eigen)){
    $eigenurl = "http://bitbucket.org/eigen/eigen/get/3.3.4.zip"
    Download $eigenurl "eigen.zip" $DownloadDir
    Expand-Archive "$DownloadDir\eigen.zip" -DestinationPath "$pwd"
    Set-Location -Path "eigen-eigen-5a0156e40feb"
    (cmake -H"$pwd" -Bbuild_eigen -DCMAKE_INSTALL_PREFIX="$DepsDir\eigen") 2>&1 | out-null
    (cmake --build build_eigen -- install) 2>&1 | out-null
    Set-Location -Path $DepsDir
  }
  nuget install OpenBLAS -OutputDirectory "${DepsDir}"
  nuget install hdf5-v120-complete -OutputDirectory "${DepsDir}"
  if (($env:GENERATOR -eq "Visual Studio 14 2015") `
      -or ($env:GENERATOR -eq "Visual Studio 15 2017")) {
    vcpkg integrate install
  } else {
    mingw-get help
    mingw-get install fortran
    mingw-get search pkg-config
  }
  # Upgrade to the latest version of pip to avoid it displaying warnings
  # about it being out of date.
  pip install --disable-pip-version-check --user --upgrade pip pipenv
  # Get back to APPVEYOR_BUILD_FOLDER
  Set-Location -Path $env:APPVEYOR_BUILD_FOLDER
}

main
