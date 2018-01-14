# Install Boost
# This is not Windows-friendly!
add_custom_command(
    OUTPUT ${CUSTOM_BOOST_LOCATION}/boost.installed
    COMMAND ./b2 install toolset=${toolset} variant=${type} link=static
    threading=multi --user-config=user-config.jam 1> ${CUSTOM_BOOST_LOCATION}/boost.installed.log 2> ${CUSTOM_BOOST_LOCATION}/boost.installed.err
    COMMAND ${CMAKE_COMMAND} -E touch ${CUSTOM_BOOST_LOCATION}/boost.installed
    WORKING_DIRECTORY ${BOOST_BUILD_DIR}
    DEPENDS ${CUSTOM_BOOST_LOCATION}/boost.built
    COMMENT "Installing Boost headers and libs")
