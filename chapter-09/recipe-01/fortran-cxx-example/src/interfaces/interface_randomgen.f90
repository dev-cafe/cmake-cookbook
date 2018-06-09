module interface_randomgen

  implicit none

  interface
    function randomgen(lower, upper) result(rn) bind(C)
      use, intrinsic :: iso_c_binding, only: c_int
      integer(c_int), intent(in), value :: lower, upper
      integer(c_int) :: rn
    end function
  end interface

end module
