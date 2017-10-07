program hello_world

  use messaging

  implicit none

  type(Messenger) :: hello, bye

  hello%message_ = 'Hello, CMake world!'
  print *, print_message(hello)

  bye%message_ = 'Bye, CMake world!'
  print *, print_message(bye)

end program
