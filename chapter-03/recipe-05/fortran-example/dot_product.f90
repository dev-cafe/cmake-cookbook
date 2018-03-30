program main

!*****************************************************************************80
!
!! MAIN is the main program for DOT_PRODUCT.
!
!  Discussion:
!
!    This program illustrates how a vector dot product could be set up
!    in a FORTRAN90 program using OpenMP.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    05 April 2008
!
!  Author:
!
!    John Burkardt
!
  use omp_lib

  implicit none

  real ( kind = 8 ) factor
  integer ( kind = 4 ) i
  integer ( kind = 4 ) n
  real ( kind = 8 ) wtime
  real ( kind = 8 ), allocatable, dimension ( : ) :: x
  real ( kind = 8 ) xdoty
  real ( kind = 8 ), allocatable, dimension ( : ) :: y

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'DOT_PRODUCT'
  write ( *, '(a)' ) '  FORTRAN90/OpenMP version'
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) '  A program which computes a vector dot product.'

  write ( *, '(a,i8)' ) '  The number of processors available = ', omp_get_num_procs ( )
  write ( *, '(a,i8)' ) '  The number of threads available    = ', omp_get_max_threads ( )
!
!  Set up the vector data.
!  N may be increased to get better timing data.
!
!  The value FACTOR is chosen so that the correct value of the dot product
!  of X and Y is N.
!
  n = 100

  do while ( n < 1000000 )

    n = n * 10

    allocate ( x(1:n) )
    allocate ( y(1:n) )

    factor = real ( n, kind = 8 )
    factor = 1.0D+00 / sqrt ( 2.0D+00 * factor * factor + 3 * factor + 1.0D+00 )

    do i = 1, n
      x(i) = i * factor
    end do

    do i = 1, n
      y(i) = i * 6 * factor
    end do

    write ( *, '(a)' ) ' '
!
!  Test #1
!
    wtime = omp_get_wtime ( )

    call test01 ( n, x, y, xdoty )

    wtime = omp_get_wtime ( ) - wtime

    write ( * , '(2x,a10,2x,i8,2x,g14.6,2x,f15.10)' ) 'Sequential', n, xdoty, wtime
!
!  Test #2
!
    wtime = omp_get_wtime ( )

    call test02 ( n, x, y, xdoty )

    wtime = omp_get_wtime ( ) - wtime

    write ( * , '(2x,a10,2x,i8,2x,g14.6,2x,f15.10)' ) 'Parallel  ', n, xdoty, wtime

    deallocate ( x )
    deallocate ( y )

  end do
!
!  Terminate.
!
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'DOT_PRODUCT'
  write ( *, '(a)' ) '  Normal end of execution.'

  stop
end
subroutine test01 ( n, x, y, xdoty )

!*****************************************************************************80
!
!! TEST01 computes the dot product with no parallel processing directives.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    05 April 2008
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) N, the order of the vectors.
!
!    Input, real ( kind = 8 ) X(N), Y(N), the vectors.
!
!    Output, real ( kind = 8 ) XDOTY, the dot product of X and Y.
!
  implicit none

  integer n

  integer ( kind = 4 ) i
  real ( kind = 8 ) xdoty
  real ( kind = 8 ) x(n)
  real ( kind = 8 ) y(n)

  xdoty = 0.0D+00

  do i = 1, n
    xdoty = xdoty + x(i) * y(i)
  end do

  return
end
subroutine test02 ( n, x, y, xdoty )

!*****************************************************************************80
!
!! TEST02 computes the dot product with parallel processing directives.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    05 April 2008
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) N, the order of the vectors.
!
!    Input, real ( kind = 8 ) X(N), Y(N), the vectors.
!
!    Output, real ( kind = 8 ) XDOTY, the dot product of X and Y.
!
  implicit none

  integer n

  integer ( kind = 4 ) i
  real ( kind = 8 ) xdoty
  real ( kind = 8 ) x(n)
  real ( kind = 8 ) y(n)

  xdoty = 0.0D+00

!$omp parallel &
!$omp   shared ( x, y ) &
!$omp   private ( i )

!$omp do reduction ( + : xdoty )
  do i = 1, n
    xdoty = xdoty + x(i) * y(i)
  end do
!$omp end do

!$omp end parallel

  return
end
