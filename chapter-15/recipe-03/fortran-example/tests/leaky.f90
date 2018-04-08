program test
  use buggy, only: function_leaky
  implicit none

  if (function_leaky() /= 0) then
    error stop
  end if
end program
