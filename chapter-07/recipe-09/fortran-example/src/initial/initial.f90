module initial

  implicit none
  public initial_distribution
  private

contains

  pure subroutine initial_distribution(row)
    integer, intent(out) :: row(:)

    row = 0
    row(size(row)/2) = 1
  end subroutine

end module
