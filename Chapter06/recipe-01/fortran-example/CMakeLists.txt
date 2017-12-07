cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-01 Fortran C)

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

configure_file(print_info.c.in print_info.c @ONLY)

add_executable(hello-world hello-world.f90)
target_compile_options(hello-world
  PUBLIC
    -std=f2003
  )
target_sources(hello-world
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/print_info.c
  )
