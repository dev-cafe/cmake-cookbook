find_package(Eigen3 3.3.4 QUIET NO_MODULE)
if(TARGET Eigen3::Eigen)
  message(STATUS "Found Eigen3: ${EIGEN3_INCLUDE_DIR} (found version ${EIGEN3_VERSION_STRING})")
  add_library(eigen3_external INTERFACE)  # dummy
else()
  message(STATUS "Suitable Eigen3 could not be located. Downloading and building!")
  include(ExternalProject)
  ExternalProject_Add(eigen3_external
    HG_REPOSITORY
      https://bitbucket.org/eigen/eigen
    HG_TAG
      3.3.4
    UPDATE_COMMAND
      ""
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${DEPS_INSTALL_PREFIX}
    INSTALL_COMMAND
      ${CMAKE_MAKE_PROGRAM} install
    )
  set(Eigen3_DIR ${DEPS_INSTALL_PREFIX}/share/eigen3/cmake
    CACHE PATH
      "Path to internally built Eigen3Config.cmake"
    FORCE
    )
endif()
