program example

  use version, only: VERSION_STRING, VERSION_MAJOR

  implicit none

  print *, "This is output from example code ", VERSION_STRING
  print *, "The major version number is", VERSION_MAJOR
  print *, "Hello CMake world!"

end program
