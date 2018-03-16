module parser

  implicit none
  public get_arg_as_int
  private

contains

  integer function get_arg_as_int(n) result(i)
    integer, intent(in) :: n
    character(len=32) :: arg

    call get_command_argument(n, arg)
    read(arg , *) i
  end function

end module
