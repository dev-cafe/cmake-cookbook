module empty

  implicit none
  public empty_subroutine
  private

contains

  subroutine empty_subroutine()
  end subroutine

end module


subroutine empty_subroutine_no_interface()
  use empty, only: empty_subroutine
  call empty_subroutine()
end subroutine
