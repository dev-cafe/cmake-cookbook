rem install pipenv dependencies
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pipenv install"

rem finally we start with the actual tests
rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-01/recipe-*'"
rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-02/recipe-*'"
rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-03/recipe-*'"
rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-04/recipe-*'"
rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-05/recipe-*'"
rem bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-06/recipe-*'"
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-07/recipe-03'"
