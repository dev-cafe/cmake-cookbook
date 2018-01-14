# Run bootstrap.sh to configure the build. We will install in ${PROJECT_BINARY_DIR}/boost
# This is not Windows-friendly!
add_custom_command(
    OUTPUT ${CUSTOM_BOOST_LOCATION}/boost.configured
    COMMAND ./bootstrap.sh --with-toolset=${toolset}
            ${select_libraries}
        --with-python=${PYTHON_EXECUTABLE}
        --prefix=${CUSTOM_BOOST_LOCATION} 1> ${CUSTOM_BOOST_LOCATION}/boost.configured.log 2> ${CUSTOM_BOOST_LOCATION}/boost.configured.err
    COMMAND ${CMAKE_COMMAND} -E touch ${CUSTOM_BOOST_LOCATION}/boost.configured
    WORKING_DIRECTORY ${BOOST_BUILD_DIR}
    DEPENDS ${CUSTOM_BOOST_LOCATION}/boost.user-config
    COMMENT "Configuring Boost")
