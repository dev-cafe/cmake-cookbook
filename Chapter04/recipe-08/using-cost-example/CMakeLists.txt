# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name
project(recipe-08)

# define tests
enable_testing()
add_test(a ${PROJECT_SOURCE_DIR}/test/a.sh)
add_test(b ${PROJECT_SOURCE_DIR}/test/b.sh)
add_test(c ${PROJECT_SOURCE_DIR}/test/c.sh)
add_test(d ${PROJECT_SOURCE_DIR}/test/d.sh)
set_tests_properties(a b c d PROPERTIES COST 0.5)

add_test(e ${PROJECT_SOURCE_DIR}/test/e.sh)
add_test(f ${PROJECT_SOURCE_DIR}/test/f.sh)
add_test(g ${PROJECT_SOURCE_DIR}/test/g.sh)
set_tests_properties(e f g PROPERTIES COST 1.5)

add_test(h ${PROJECT_SOURCE_DIR}/test/h.sh)
set_tests_properties(h PROPERTIES COST 2.5)

add_test(i ${PROJECT_SOURCE_DIR}/test/i.sh)
set_tests_properties(i PROPERTIES COST 3.5)

add_test(j ${PROJECT_SOURCE_DIR}/test/j.sh)
set_tests_properties(j PROPERTIES COST 4.5)
