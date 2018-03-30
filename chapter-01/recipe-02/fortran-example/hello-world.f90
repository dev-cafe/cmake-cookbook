pure function say_hello() result(message)

  implicit none

  character(len=19) :: message

  message = 'Hello, CMake world!'

end function

program hello_world

  implicit none

  character(len=19) :: say_hello

  print *, say_hello()

end program
