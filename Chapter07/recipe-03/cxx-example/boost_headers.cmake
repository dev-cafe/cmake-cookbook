# Install Boost
add_custom_command(
    OUTPUT ${CUSTOM_BOOST_LOCATION}/boost.installed
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${BOOST_BUILD_DIR}/boost ${CUSTOM_BOOST_LOCATION}/include/boost
    COMMAND ${CMAKE_COMMAND} -E touch ${CUSTOM_BOOST_LOCATION}/boost.installed
    WORKING_DIRECTORY ${BOOST_BUILD_DIR}
    DEPENDS ${CUSTOM_BOOST_LOCATION}/boost.user-config
    COMMENT "Installing Boost headers")
