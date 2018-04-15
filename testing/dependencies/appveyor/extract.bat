rem we download and extract and use the zip instead of the git clone
rem to avoid issues with symlinks

rem the 7z that is default on appveyor cannot handle symlinks but p7zip can
bash -lc "pacman -S --noconfirm p7zip"

bash -lc "cd /c/projects/ && 7z x ${APPVEYOR_REPO_COMMIT}.zip"
bash -lc "mv /c/projects/cmake-recipes-${APPVEYOR_REPO_COMMIT} /c/projects/cmake-recipes-no-symlinks"
