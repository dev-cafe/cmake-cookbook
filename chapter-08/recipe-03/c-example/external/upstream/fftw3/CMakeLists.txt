find_package(FFTW3 CONFIG QUIET)
if(FFTW3_FOUND AND (NOT FFTW3_FORCE_SUPERBUILD))
  get_property(_loc TARGET FFTW3::fftw3 PROPERTY LOCATION)
  message(STATUS "Found FFTW3: ${_loc} (found version ${FFTW3_VERSION})")
  add_library(fftw3_external INTERFACE)  # dummy
else()
  if(FFTW3_FORCE_SUPERBUILD)
    message(STATUS "Forcing superbuild of FFTW3.")
  else()
    message(STATUS "Suitable FFTW3 could not be located. Downloading and building!")
  endif()
  include(ExternalProject)
  ExternalProject_Add(fftw3_external
    URL
      http://www.fftw.org/fftw-3.3.7.tar.gz
    URL_HASH
      MD5=0d5915d7d39b3253c1cc05030d79ac47
    DOWNLOAD_NO_PROGRESS
      1
    LOG_CONFIGURE
      1
    LOG_BUILD
      1
    LOG_INSTALL
      1
    UPDATE_COMMAND
      ""
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${STAGED_INSTALL_PREFIX}
      -DBUILD_TESTS=OFF
    CMAKE_CACHE_ARGS
      -DCMAKE_C_FLAGS:STRING=$<$<BOOL:WIN32>:-DWITH_OUR_MALLOC>
    )
  include(GNUInstallDirs)
  set(FFTW3_DIR ${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/fftw3
    CACHE PATH "Path to internally built FFTW3Config.cmake" FORCE)
endif()
