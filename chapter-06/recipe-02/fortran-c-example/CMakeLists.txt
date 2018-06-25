cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-02 LANGUAGES Fortran C)

# Get username
execute_process(
  COMMAND
    whoami
  TIMEOUT
    1
  OUTPUT_VARIABLE
    _user_name
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )

# host name information
cmake_host_system_information(RESULT _host_name QUERY HOSTNAME)
cmake_host_system_information(RESULT _fdqn QUERY FQDN)

# processor information
cmake_host_system_information(RESULT _processor_name QUERY PROCESSOR_NAME)
cmake_host_system_information(RESULT _processor_description QUERY PROCESSOR_DESCRIPTION)

# os information
cmake_host_system_information(RESULT _os_name QUERY OS_NAME)
cmake_host_system_information(RESULT _os_release QUERY OS_RELEASE)
cmake_host_system_information(RESULT _os_version QUERY OS_VERSION)
cmake_host_system_information(RESULT _os_platform QUERY OS_PLATFORM)

string(TIMESTAMP _configuration_time "%Y-%m-%d %H:%M:%S [UTC]" UTC)

# we loop through all variables known at this stage
# and build a dictionary which we will pass on to python
get_cmake_property(_vars VARIABLES)
foreach(_var IN ITEMS ${_vars})
  string(REPLACE ";" "\;" _var_escaped "${${_var}}")
  list(APPEND _vars_dict "'${_var}': '''${_var_escaped}'''")
endforeach()
string(REPLACE ";" "," _vars_dict "${_vars_dict}")

set(_config_script
"
import sys
sys.path.insert(0, '${CMAKE_CURRENT_SOURCE_DIR}')

import os
input_file = os.path.join('${CMAKE_CURRENT_SOURCE_DIR}', 'print_info.c.in')
output_file = os.path.join('${CMAKE_CURRENT_BINARY_DIR}', 'print_info.c')

from configurator import configure_file
vars_dict = {${_vars_dict}}
configure_file(input_file, output_file, vars_dict)
")

find_package(PythonInterp QUIET REQUIRED)

execute_process(
  COMMAND
    ${PYTHON_EXECUTABLE} "-c" ${_config_script}
  )

add_custom_target(build_info
  ALL DEPENDS
    ${CMAKE_CURRENT_BINARY_DIR}/print_info.c
  )

add_executable(example "")

target_sources(example
  PRIVATE
    example.f90
    ${CMAKE_CURRENT_BINARY_DIR}/print_info.c
  )
