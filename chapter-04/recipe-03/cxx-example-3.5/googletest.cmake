# download and unpack googletest at configure time

# the following code to fetch googletest
# is inspired by and adapted after https://crascit.com/2015/07/25/cmake-gtest/

function(fetch_googletest _download_module_path _download_root)
  # Variable used in googletest-download.cmake
  set(GOOGLETEST_DOWNLOAD_ROOT ${_download_root})
  configure_file(
    ${_download_module_path}/googletest-download.cmake
    ${_download_root}/CMakeLists.txt
    @ONLY
    )
  unset(GOOGLETEST_DOWNLOAD_ROOT)

  execute_process(
    COMMAND
      "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
    WORKING_DIRECTORY
      ${_download_root}
    )
  execute_process(
    COMMAND
      "${CMAKE_COMMAND}" --build .
    WORKING_DIRECTORY
      ${_download_root}
    )

  # Prevent GoogleTest from overriding our compiler/linker options
  # when building with Visual Studio
  set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
  # Prevent GoogleTest from using PThreads
  set(gtest_disable_pthreads ON CACHE BOOL "" FORCE)

  # adds the targets: gtest, gtest_main, gmock, gmock_main
  add_subdirectory(
    ${_download_root}/googletest-src
    ${_download_root}/googletest-build
    )
endfunction()
