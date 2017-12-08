cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-02 Fortran C)

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
# Get hostname
cmake_host_system_information(RESULT _host_name QUERY HOSTNAME)
# Get Fully Qualified Domain Name
cmake_host_system_information(RESULT _fdqn QUERY FQDN)
# Get processor name
cmake_host_system_information(RESULT _processor_name QUERY PROCESSOR_NAME)
cmake_host_system_information(RESULT _processor_description QUERY PROCESSOR_DESCRIPTION)
cmake_host_system_information(RESULT _os_name QUERY OS_NAME)
cmake_host_system_information(RESULT _os_release QUERY OS_RELEASE)
cmake_host_system_information(RESULT _os_version QUERY OS_VERSION)
cmake_host_system_information(RESULT _os_platform QUERY OS_PLATFORM)
string(TIMESTAMP _configuration_time "%Y-%m-%d %H:%M:%S [UTC]" UTC)

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/print_info.c
  "
#include <stdio.h>
#include <unistd.h>

void print_info(void) {
  printf(\"Configuration and build information\\n\");
  printf(\"-----------------------------------\\n\");
  printf(\"\\n\");
  printf(\"Who compiled                | %s\\n\", \"${_user_name}\");
  printf(\"Compilation hostname        | %s\\n\", \"${_host_name}\");
  printf(\"Fully qualified domain name | %s\\n\", \"${_fqdn}\");
  printf(\"Operating system            | %s\\n\", \"${_os_name}, ${_os_release}, ${_os_version}\");
  printf(\"Platform                    | %s\\n\", \"${_os_platform}\");
  printf(\"Processor info              | %s\\n\", \"${_processor_name}, ${_processor_description}\");
  printf(\"CMake version               | %s\\n\", \"${CMAKE_VERSION}\");
  printf(\"CMake generator             | %s\\n\", \"${CMAKE_GENERATOR}\");
  printf(\"Configuration time          | %s\\n\", \"${_configuration_time}\");
  printf(\"Fortran compiler            | %s\\n\", \"${CMAKE_Fortran_COMPILER}\");
  printf(\"C compiler                  | %s\\n\", \"${CMAKE_C_COMPILER}\");
  printf(\"\\n\");

  fflush(stdout);
}
  "
  )

add_custom_target(build_info
  ALL DEPENDS
    ${CMAKE_CURRENT_BINARY_DIR}/print_info.c
  )

add_executable(hello-world hello-world.f90)
target_compile_options(hello-world
  PUBLIC
    -std=f2003
  )
target_sources(hello-world
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/print_info.c
  )
add_dependencies(hello-world build_info)
