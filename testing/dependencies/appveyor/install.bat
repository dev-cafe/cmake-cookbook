rem Finally found a use for De Morgan's laws of boolean algebra!
rem We can't use logical OR in IF statements, so we check for the negation of
rem the AND (implicit when chaining IF-s) of the negation of each separate statement
set nonVSGenerator=true
if not "%GENERATOR%"=="Ninja" if not "%GENERATOR%"=="MSYS Makefiles" set nonVSGenerator=false

if "%nonVSGenerator%"=="true" (
  echo "Using non-VS generator %GENERATOR%"
  echo "Let's get MSYS64 working"

  rem upgrade the msys2 platform
  bash "pacman -S --needed --noconfirm pacman-mirrors"

  rem --ask=127 is taken from https://github.com/appveyor/ci/issues/2074#issuecomment-364842018
  bash "pacman -Syuu --needed --noconfirm --ask=127"

  rem search for packages with
  rem bash "pacman -Ss boost"

  rem more packages
  bash "pacman -S --noconfirm mingw64/mingw-w64-x86_64-boost"
  bash "pacman -S --noconfirm mingw64/mingw-w64-x86_64-ninja"
  bash "pacman -S --noconfirm mingw64/mingw-w64-x86_64-openblas"
  bash "pacman -S --noconfirm mingw64/mingw-w64-x86_64-eigen3"
  bash "pacman -S --noconfirm mingw64/mingw-w64-x86_64-pkg-config"
  bash "pacman -S --noconfirm mingw64/mingw-w64-x86_64-zeromq"
) else (
  echo "Using VS generator %GENERATOR%"
  echo "Let's get VcPkg working"

  vcpkg install boost-filesystem boost-system boost-test boost-python zeromq eigen3 --triplet x64-windows
  cd c:\tools\vcpkg
  vcpkg integrate install
  cd %APPVEYOR_BUILD_FOLDER%
)
