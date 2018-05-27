program test
  use buggy, only: function_out_of_bounds
  implicit none

  if (function_out_of_bounds() /= 0) then
    error stop
  end if
end program
