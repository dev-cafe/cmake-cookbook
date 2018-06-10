module interface_randomgen

  implicit none

  interface
    subroutine init_randomgen(seed) bind(C)
      use, intrinsic :: iso_c_binding, only: c_int
      integer(c_int), intent(in), value :: seed
    end subroutine

    function randomgen(lower, upper) result(rn) bind(C)
      use, intrinsic :: iso_c_binding, only: c_int
      integer(c_int), intent(in), value :: lower, upper
      integer(c_int) :: rn
    end function
  end interface

end module
