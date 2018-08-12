module evolution

  implicit none
  public evolve
  private

contains

  subroutine not_visible()
    ! no-op call to demonstrate private/public visibility
    call empty_subroutine_no_interface()
  end subroutine

  pure subroutine evolve(row, rule_binary)
    use ancestors, only: compute_ancestors

    integer, intent(inout) :: row(:)
    integer, intent(in) :: rule_binary(8)
    integer :: i
    integer :: left, center, right
    integer :: ancestry
    integer, allocatable :: new_row(:)

    allocate(new_row(size(row)))

    do i = 1, size(row)
      left = i - 1
      center = i
      right = i + 1

      if (left < 1) left = left + size(row)
      if (right > size(row)) right = right - size(row)

      ancestry = compute_ancestors(row, left, center, right)
      new_row(i) = rule_binary(ancestry)
    end do

    row = new_row
    deallocate(new_row)

  end subroutine

end module
