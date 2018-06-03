module class_Polygon

  implicit none
  private
  real :: pi = acos(-1.0d0)

  type, public :: Polygon
    integer :: nSides
    real :: side
  contains
    procedure :: area => polygon_area
    procedure :: print => polygon_print
  end type

contains

  pure function polygon_area(this) result(area)

    class(Polygon), intent(in) :: this
    real :: area
    real :: perimeter, apothem

    perimeter = this%nSides * this%side
    apothem = this%side / (2.0d0 * tan(pi / this%nSides))

    area = (perimeter * apothem) / 2.0d0

  end function

  subroutine polygon_print(this)

    class(Polygon), intent(in) :: this
    real:: area

    area = this%area()
    print *, 'Polygon: nSides = ', this%nSides, ' side = ', this%side, ' area = ', area

  end subroutine

end module
