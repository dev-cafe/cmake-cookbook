Anaconda_VERSION="5.1.0"
echo "-- Installing Anaconda $Anaconda_VERSION"
if [[ -d "c:\Deps\conda\bin" ]]; then
  echo "-- Anaconda $Anaconda_VERSION FOUND in cache"
else
  echo "-- Anaconda $Anaconda_VERSION NOT FOUND in cache"
  curl -Ls https://repo.anaconda.com/archive/Anaconda3-${Anaconda_VERSION}-Windows-x86_64.exe > conda.exe
  # Appveyor creates the cached directories for us.
  # This is problematic when wanting to install Anaconda for the first time...
  rm -rf C:\Deps\conda
  start /wait "" conda.exe /InstallationType=JustMe /RegisterPython=0 /S /D=C:\Deps\conda
  set PATH=C:\Deps\conda;%PATH%
  conda config --set always_yes yes --set changeps1 no
  conda update -q conda
  conda info -a
  rm -f conda.exe
fi
echo "-- Done with Anaconda $Anaconda_VERSION"
