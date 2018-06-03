module class_Circle

  implicit none
  private
  real :: pi = acos(-1.0d0)

  type, public :: Circle
    real :: radius
  contains
    procedure :: area => circle_area
    procedure :: print => circle_print
  end type

contains

  pure function circle_area(this) result(area)

    class(Circle), intent(in) :: this
    real :: area

    area = pi * this%radius**2

  end function

  subroutine circle_print(this)

    class(Circle), intent(in) :: this
    real:: area

    area = this%area()
    print *, 'Circle: r = ', this%radius, ' area = ', area

  end subroutine

end module
