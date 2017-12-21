cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-03 Fortran C)

# Get processor name
cmake_host_system_information(RESULT _processor_name QUERY PROCESSOR_NAME)
cmake_host_system_information(RESULT _processor_description QUERY PROCESSOR_DESCRIPTION)
cmake_host_system_information(RESULT _os_name QUERY OS_NAME)
cmake_host_system_information(RESULT _os_release QUERY OS_RELEASE)
cmake_host_system_information(RESULT _os_version QUERY OS_VERSION)
cmake_host_system_information(RESULT _os_platform QUERY OS_PLATFORM)

set(_config_script
"
import os, sys
sys.path.append('${CMAKE_CURRENT_SOURCE_DIR}')
import configurator as cf
conf_dict = cf.prepare_configuration_dictionary(processor_name='${_processor_name}',
            processor_description='${_processor_description}',
            os_name='${_os_name}',
            os_release='${_os_release}',
            os_version='${_os_version}',
            os_platform='${_os_platform}',
            cmake_version='${CMAKE_VERSION}',
            cmake_generator='${CMAKE_GENERATOR}',
            fc='${CMAKE_Fortran_COMPILER}',
            cc='${CMAKE_C_COMPILER}')
cf.configure_file(conf_dict, 'print_info.c', in_path=os.getcwd(), out_path='${CMAKE_CURRENT_BINARY_DIR}', suffix='.in')
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

add_executable(hello-world hello-world.f90)
target_sources(hello-world
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/print_info.c
  )
