rem install pipenv dependencies
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pipenv install"

rem finally we start with the actual tests
if "%ANACONDA_TESTS_ONLY%"=="1" (
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-04'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-05'"
) else (
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-03'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-02'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-01'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-09/recipe-*'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-07/recipe-*'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-06/recipe-*'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-05/recipe-*'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-04/recipe-*'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-03/recipe-*'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-02/recipe-*'"
  rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-01/recipe-*'"
)
