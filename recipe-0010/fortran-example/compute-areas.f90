program compute_areas

  use iso_fortran_env, only: compiler_version, compiler_options

  use class_Circle
  use class_Polygon
  use class_Rhombus
  use class_Square

  implicit none

  type(Circle) :: c
  type(Polygon) :: p
  type(Rhombus) :: r
  type(Square) :: s

  print '(4a)', 'This file was compiled by ', &
              compiler_version(), ' using the options ', &
              compiler_options()

  c = Circle(2.5293)
  p = Polygon(19, 1.29312)
  r = Rhombus(5.0, 7.8912)
  s = Square(10.0)

  call c%print
  call p%print
  call r%print
  call s%print

end program
