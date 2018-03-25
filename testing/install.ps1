$ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
. "$ScriptDir\download.ps1"
. "$ScriptDir\install-msmpi.ps1"

function main () {
  # Install MS-MPI
  InstallMicrosoftMPI
  if (($env:GENERATOR -eq "Visual Studio 14 2015") `
      -or ($env:GENERATOR -eq "Visual Studio 15 2017")) {
      vcpkg integrate install
      # vcpkg install hdf5
  } else {
      mingw-get install fortran
  }
  # Install Kitware-maintained Ninja
  $ninjaurl = "https://github.com/Kitware/ninja/releases/download/v1.7.2.gaad58.kitware.dyndep-1/ninja-1.7.2.gaad58.kitware.dyndep-1_i686-pc-windows-msvc.zip"
  Download $ninjaurl "ninja.zip" "C:\projects\deps"
  $outputpath = "C:\projects\deps\ninja"
  New-Item -ItemType Directory -Force -Path $outputpath
  7z e ninja.zip "-o${outputpath}"
  # Upgrade to the latest version of pip to avoid it displaying warnings
  # about it being out of date.
  pip install --disable-pip-version-check --user --upgrade pip pipenv
}

main
