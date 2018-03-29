program example

  use version, only: PROJECT_VERSION, PROJECT_VERSION_MAJOR, PROJECT_VERSION_MINOR

  implicit none

  print *, "This is output from example code ", PROJECT_VERSION
  print *, "The major version number is", PROJECT_VERSION_MAJOR
  print *, "The minor version number is", PROJECT_VERSION_MINOR

  print *, "Hello CMake world!"

end program
