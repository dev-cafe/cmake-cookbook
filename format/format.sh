#!/usr/bin/env bash

for file in $(find ../ -type f -name CMakeLists.txt); do
    pipenv run cmake-format -c cmake-format.yaml -i $file
done

exit 0
