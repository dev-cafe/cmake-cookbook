module conversion

  implicit none
  public binary_representation
  private

contains

  pure function binary_representation(n_decimal)
    integer, intent(in) :: n_decimal
    integer :: binary_representation(8)
    integer :: pos
    integer :: n

    binary_representation = 0
    pos = 8
    n = n_decimal
    do while (n > 0)
      binary_representation(pos) = mod(n, 2)
      n = (n - binary_representation(pos))/2
      pos = pos - 1
    end do
  end function

end module
