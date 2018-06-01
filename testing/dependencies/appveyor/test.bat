rem install pipenv dependencies
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pipenv install"

rem finally we start with the actual tests
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-07/recipe-*'"
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-06/recipe-*'"
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-05/recipe-*'"
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-04/recipe-*'"
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-03/recipe-*'"
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-02/recipe-*'"
bash -lc "cd /c/projects/cmake-cookbook-no-symlinks && pwd && pipenv run python testing/collect_tests.py 'chapter-01/recipe-*'"
