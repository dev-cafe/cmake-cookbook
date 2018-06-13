rem build directory is provided by the main script
set build_directory=%~1
mkdir %build_directory%
cd %build_directory%

dir ..
copy ../account/test.py .

PIPENV_MAX_DEPTH=1 pipenv install ..
pipenv run python test.py

exit %errorlevel%