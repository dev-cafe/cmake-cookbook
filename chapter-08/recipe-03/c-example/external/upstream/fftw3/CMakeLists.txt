find_package(FFTW3 CONFIG QUIET)

if(FFTW3_FOUND)
  get_property(_loc TARGET FFTW3::fftw3 PROPERTY LOCATION)
  message(STATUS "Found FFTW3: ${_loc} (found version ${FFTW3_VERSION})")
  add_library(fftw3_external INTERFACE)  # dummy
else()
  message(STATUS "Suitable FFTW3 could not be located. Downloading and building!")

  include(ExternalProject)
  ExternalProject_Add(fftw3_external
    URL
      http://www.fftw.org/fftw-3.3.8.tar.gz
    URL_HASH
      MD5=8aac833c943d8e90d51b697b27d4384d
    DOWNLOAD_NO_PROGRESS
      1
    UPDATE_COMMAND
      ""
    LOG_CONFIGURE
      1
    LOG_BUILD
      1
    LOG_INSTALL
      1
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${STAGED_INSTALL_PREFIX}
      -DBUILD_TESTS=OFF
    CMAKE_CACHE_ARGS
      -DCMAKE_C_FLAGS:STRING=$<$<BOOL:WIN32>:-DWITH_OUR_MALLOC>
    )

  include(GNUInstallDirs)

  set(
    FFTW3_DIR ${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/fftw3
    CACHE PATH "Path to internally built FFTW3Config.cmake"
    FORCE
    )
endif()
