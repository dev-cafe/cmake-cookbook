module interface_uuid

  implicit none

  interface
    subroutine uuid_generate(uu) bind(C)
      use, intrinsic :: iso_c_binding, only: c_char
      character(kind=c_char, len=1), intent(out) :: uu(16)
    end subroutine

    subroutine uuid_generate_random(uu) bind(C)
      use, intrinsic :: iso_c_binding, only: c_char
      character(kind=c_char, len=1), intent(out) :: uu(16)
    end subroutine

    subroutine uuid_clear(uu) bind(C)
      use, intrinsic :: iso_c_binding, only: c_char
      character(kind=c_char, len=1), intent(inout) :: uu(16)
    end subroutine

    function uuid_compare(uu1, uu2) result(compare) bind(C)
      use, intrinsic :: iso_c_binding, only: c_char, c_int
      character(kind=c_char, len=1), intent(in) :: uu1(16), uu2(16)
      integer(c_int) :: compare
    end function

    subroutine uuid_copy(dst, src) bind(C)
      use, intrinsic :: iso_c_binding, only: c_char
      character(kind=c_char, len=1), intent(out) :: dst(16)
      character(kind=c_char, len=1), intent(in) :: src(16)
    end subroutine

    function uuid_is_null(uu) result(is_null) bind(C)
      use, intrinsic :: iso_c_binding, only: c_char, c_int
      character(kind=c_char, len=1), intent(in) :: uu(16)
      integer(c_int) :: is_null
    end function

    function uuid_parse(uu_str, uu) result(success) bind(C)
      use, intrinsic :: iso_c_binding, only: c_char, c_int
      character(kind=c_char, len=1), intent(inout) :: uu_str(37)
      character(kind=c_char, len=1), intent(in) :: uu(16)
      integer(c_int) :: success
      end function

    subroutine uuid_unparse(uu, uu_str) bind(C)
      use, intrinsic :: iso_c_binding, only: c_char
      character(kind=c_char, len=1), intent(in) :: uu(16)
      character(kind=c_char, len=1), intent(out) :: uu_str(37)
    end subroutine
  end interface

end module
