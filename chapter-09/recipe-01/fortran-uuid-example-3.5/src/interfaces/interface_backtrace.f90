module interface_backtrace

  implicit none

  interface
    function backtrace(buffer, size) result(bt) bind(C, name="backtrace")
      use, intrinsic :: iso_c_binding, only: c_int, c_ptr
      type(c_ptr) :: buffer
      integer(c_int), value :: size
      integer(c_int) :: bt
    end function

    subroutine backtrace_symbols_fd(buffer, size, fd) bind(C, name="backtrace_symbols_fd")
      use, intrinsic :: iso_c_binding, only: c_int, c_ptr
      type(c_ptr) :: buffer
      integer(c_int), value :: size, fd
    end subroutine
  end interface

end module
