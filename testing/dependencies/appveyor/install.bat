PATH C:\msys64\%MSYSTEM%\bin;C:\msys64\usr\bin;%PATH%

rem upgrade the msys2 platform
bash -lc "pacman -S --needed --noconfirm pacman-mirrors"

rem --ask=127 is taken from https://github.com/appveyor/ci/issues/2074#issuecomment-364842018
bash -lc "pacman -Syuu --needed --noconfirm --ask=127"

rem we will run the tests inside pipenv
bash -lc "pip install pipenv"

rem more packages
bash -lc "pacman -S --noconfirm mingw64/mingw-w64-x86_64-boost"
bash -lc "pacman -S --noconfirm mingw64/mingw-w64-x86_64-ninja"
bash -lc "pacman -S --noconfirm mingw64/mingw-w64-x86_64-openblas"
bash -lc "pacman -S --noconfirm mingw64/mingw-w64-x86_64-eigen3"