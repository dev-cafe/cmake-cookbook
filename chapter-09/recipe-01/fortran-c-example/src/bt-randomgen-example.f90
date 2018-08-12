program bt_randomgen_example
  use, intrinsic :: iso_c_binding, only: c_int &
                                       , c_ptr  &
                                       , c_loc
  use, intrinsic :: iso_fortran_env, only: output_unit &
                                         , error_unit
  use interface_backtrace
  use interface_randomgen
  use util_strings

  integer(c_int) :: lower, upper

  type(c_ptr), target :: buffer(100)
  type(c_ptr) :: c_buf
  integer(c_int) :: bt_size

  write(output_unit, '(A)') 'Initializing randomgen C library'
  call init_randomgen(int(time()))
  lower = -2
  upper = 42
  do i = 1, 20
     write(output_unit, '(1X,"Get a random number",1X,I5)') randomgen(lower, upper)
  end do

  write(error_unit, '(A)') 'Printing backtrace'
  c_buf = c_loc(buffer)
  bt_size = backtrace(c_buf, 100)
  call backtrace_symbols_fd(c_buf, bt_size, 2)
end program
