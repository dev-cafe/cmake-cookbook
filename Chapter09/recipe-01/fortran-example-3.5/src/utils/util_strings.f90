module util_strings
  use, intrinsic :: iso_c_binding, only: c_char, c_null_char
  implicit none

contains

  ! \brief Convert a Fortran string into a C string.
  ! \param[in] string_f03 a Fortran character string.
  ! \return array_c Null-terminated C string in a character array.
  pure function fstring_to_carray(string_f03) result(array_c)
    character(len=*), intent(in) :: string_f03
    character(kind=c_char) :: array_c(len(string_f03)+1)

    integer :: i

    do i = 1, len(string_f03)
        array_c(i) = string_f03(i:i)
    end do
    array_c(i) = c_null_char
  end function

  ! \brief Convert a C string into a Fortran string.
  ! \param[in] array_c a null-terminated C string in a character array.
  ! \return string_f03 Fortran character string (without null termination).
  pure function carray_to_fstring(array_c) result(string_f03)
    character(kind=c_char), intent(in) :: array_c(:)
    character(len=size(array_c)-1) :: string_f03

    integer :: i

    ! Don't copy any (presumably garbage) from beyond the null character.
    string_f03 = ''
    do i = 1, size(array_c)-1
        if (array_c(i) == c_null_char) exit
        string_f03(i:i) = array_c(i)
    end do
  end function

end module
