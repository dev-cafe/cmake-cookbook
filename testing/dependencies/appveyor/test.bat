rem install pipenv dependencies
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pipenv install"

rem finally we start with the actual tests
if "%ANACONDA_TESTS_ONLY%"=="1" (
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-04'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-05'"
) else (
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-03'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-02'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-11/recipe-01'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-09/recipe-*'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-07/recipe-*'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-06/recipe-*'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-05/recipe-*'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-04/recipe-*'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-03/recipe-*'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-02/recipe-*'"
  bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-01/recipe-*'"
)
