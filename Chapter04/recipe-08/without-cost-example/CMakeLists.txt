# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name
project(recipe-08)

# define tests
enable_testing()
add_test(a ${PROJECT_SOURCE_DIR}/test/a.sh)
add_test(b ${PROJECT_SOURCE_DIR}/test/b.sh)
add_test(c ${PROJECT_SOURCE_DIR}/test/c.sh)
add_test(d ${PROJECT_SOURCE_DIR}/test/d.sh)
add_test(e ${PROJECT_SOURCE_DIR}/test/e.sh)
add_test(f ${PROJECT_SOURCE_DIR}/test/f.sh)
add_test(g ${PROJECT_SOURCE_DIR}/test/g.sh)
add_test(h ${PROJECT_SOURCE_DIR}/test/h.sh)
add_test(i ${PROJECT_SOURCE_DIR}/test/i.sh)
add_test(j ${PROJECT_SOURCE_DIR}/test/j.sh)
