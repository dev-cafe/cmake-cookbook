cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-02 LANGUAGES NONE)

find_package(PythonInterp REQUIRED)

# this is set as variable to prepare
# for abstraction using loops or functions
set(_module_name "cffi")

execute_process(
  COMMAND
    ${PYTHON_EXECUTABLE} "-c" "import ${_module_name}; print(${_module_name}.__version__)"
  OUTPUT_VARIABLE _stdout
  ERROR_VARIABLE _stderr
  OUTPUT_STRIP_TRAILING_WHITESPACE
  ERROR_STRIP_TRAILING_WHITESPACE
  )

if(_stderr MATCHES "ModuleNotFoundError")
  message(STATUS "Module ${_module_name} not found")
else()
  message(STATUS "Found module ${_module_name} v${_stdout}")
endif()
