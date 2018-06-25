program hello_world

  implicit none

  interface
    subroutine print_info() bind(c, name="print_info")
    end subroutine print_info
  end interface

  call print_info()

end program
