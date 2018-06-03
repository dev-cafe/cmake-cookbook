module class_Rhombus

  implicit none
  private

  type, public :: Rhombus
    real :: d1
    real :: d2
  contains
    procedure :: area => rhombus_area
    procedure :: print => rhombus_print
  end type

contains

  pure function rhombus_area(this) result(area)

    class(Rhombus), intent(in) :: this
    real :: area

    area = (this%d1 * this%d2) / 2.0d0

  end function

  subroutine rhombus_print(this)

    class(Rhombus), intent(in) :: this
    real:: area

    area = this%area()
    print *, 'Rhombus: d1 = ', this%d1, ' d2 = ', this%d2, ' area = ', area

  end subroutine

end module
