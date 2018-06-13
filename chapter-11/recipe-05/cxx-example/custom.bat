rem build directory is provided by the main script
set build_directory=%~1
mkdir %build_directory%
cd %build_directory%

set PATH=C:\Deps\conda\Scripts:%PATH%

conda create -q --name test-environment-dgemm
source activate test-environment-dgemm

xcopy /s ../conda-recipe .
copy ../CMakeLists.txt .
copy ../example.cpp .

conda build conda-recipe
conda install --use-local conda-example-dgemm

dgemm-example

exit %errorlevel%