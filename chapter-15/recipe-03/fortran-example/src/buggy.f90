module buggy

  implicit none

  public function_leaky

  private

contains

  integer function function_leaky()
    real(8), pointer :: my_array(:)
    allocate(my_array(1000))
    ! accidentally allocate twice
    allocate(my_array(1000))

    ! do some work ...

    deallocate(my_array)

    function_leaky = 0
  end function

end module
