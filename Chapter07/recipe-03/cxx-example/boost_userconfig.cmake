# To get boost to compile MPI we need to append "using mpi ;" to the end of the
# user-config.jam file. MPI_SENT will be the command we append
set(MPI_SENT "")
if(ENABLE_MPI AND MPI_FOUND)
    set(MPI_SENT "using mpi \;")
endif()
file(WRITE ${CUSTOM_BOOST_LOCATION}/user-config.jam ${MPI_SENT})
# Write user-config.jam
add_custom_command(
    OUTPUT ${CUSTOM_BOOST_LOCATION}/boost.user-config
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CUSTOM_BOOST_LOCATION}/user-config.jam ${BOOST_BUILD_DIR}/user-config.jam
    COMMAND ${CMAKE_COMMAND} -E touch boost.user-config
    DEPENDS ${CUSTOM_BOOST_LOCATION}/boost.unpacked
    WORKING_DIRECTORY ${CUSTOM_BOOST_LOCATION}
    COMMENT "Generating user-config.jam")
