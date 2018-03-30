module io

  implicit none
  public print_row
  private

contains

  subroutine print_row(row)
    integer, intent(in) :: row(:)
    character(size(row)) :: line
    integer :: i

    do i = 1, size(row)
      if (row(i) == 1) then
        line(i:i) = '*'
      else
        line(i:i) = ' '
      end if
    end do

    print *, line
  end subroutine

end module
