pure function say_hello() result(message)

  implicit none

  character(len=19) :: message

  message = 'Hello, CMake world!'

end function

program hello_world

  implicit none

  character(len=19) :: say_hello

  interface
      subroutine print_info() bind(C, name="print_info")
      end subroutine print_info
  end interface

  call print_info()

  print *, say_hello()

end program
