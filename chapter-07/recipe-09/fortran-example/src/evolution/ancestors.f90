module ancestors

  implicit none
  public compute_ancestors
  private

contains

  pure integer function compute_ancestors(row, left, center, right) result(i)
    integer, intent(in) :: row(:)
    integer, intent(in) :: left, center, right

    i = 4*row(left) + 2*row(center) + 1*row(right)
    i = 8 - i
  end function

end module
