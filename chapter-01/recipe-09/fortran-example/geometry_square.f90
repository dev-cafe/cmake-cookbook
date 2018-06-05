module class_Square

  implicit none
  private

  type, public :: Square
    real :: side
  contains
    procedure :: area => square_area
    procedure :: print => square_print
  end type

contains

  pure function square_area(this) result(area)

    class(Square), intent(in) :: this
    real :: area

    area = this%side**2

  end function

  subroutine square_print(this)

    class(Square), intent(in) :: this
    real:: area

    area = this%area()
    print *, 'Square: l = ', this%side, ' area = ', area

  end subroutine

end module
