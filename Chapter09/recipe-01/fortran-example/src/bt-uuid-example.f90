program bt_uuid_example
  use, intrinsic :: iso_c_binding, only: c_char &
                                       , c_int  &
                                       , c_ptr  &
                                       , c_loc
  use, intrinsic :: iso_fortran_env, only: output_unit &
                                         , error_unit
  use interface_backtrace
  use interface_uuid
  use util_strings

  character(kind=c_char, len=1) :: uuid_bin(16)
  character(kind=c_char, len=1), target :: uuid_str(37)
  type(c_ptr) :: ptr
  character(len=36) :: uuid
  type(c_ptr), target :: buffer(100)
  type(c_ptr) :: c_buf
  integer(c_int) :: bt_size

  call uuid_generate(uuid_bin)
  ptr = c_loc(uuid_str)
  call uuid_unparse(uuid_bin, uuid_str)
  uuid = carray_to_fstring(uuid_str)

  write(output_unit, '(1X,"UUID:",1X,A36)') uuid

  write(error_unit, '(A)') 'Printing backtrace'
  c_buf = c_loc(buffer)
  bt_size = backtrace(c_buf, 100)
  call backtrace_symbols_fd(c_buf, bt_size, 2)
end program
