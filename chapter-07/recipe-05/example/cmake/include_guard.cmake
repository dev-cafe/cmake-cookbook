macro(include_guard)
  if (CMAKE_VERSION VERSION_LESS "3.10")
    # for CMake below 3.10 we define our
    # own include_guard(GLOBAL)
    message(STATUS "calling our custom include_guard")

    # if this macro is called the first time
    # we start with an empty list
    if(NOT DEFINED included_modules)
        set(included_modules)
    endif()

    if ("${CMAKE_CURRENT_LIST_FILE}" IN_LIST included_modules)
      message(WARNING "module ${CMAKE_CURRENT_LIST_FILE} processed more than once")
    endif()

    list(APPEND included_modules ${CMAKE_CURRENT_LIST_FILE})
  else()
    # for CMake 3.10 or higher we augment
    # the built-in include_guard
    message(STATUS "calling the built-in include_guard")

    _include_guard(${ARGV})
  endif()
endmacro()
