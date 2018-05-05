program example

  use omp_lib

  implicit none

  integer(8) :: i, n, s
  character(len=32) :: arg
  real(8) :: t0, t1

  print *, "number of available processors:", omp_get_num_procs()
  print *, "number of threads:", omp_get_max_threads()

  call get_command_argument(1, arg)
  read(arg , *) n

  print *, "we will form sum of numbers from 1 to", n

  ! start timer
  t0 = omp_get_wtime()

  s = 0
!$omp parallel do reduction(+:s)
  do i = 1, n
    s = s + i
  end do

  ! stop timer
  t1 = omp_get_wtime()

  print *, "sum:", s
  print *, "elapsed wall clock time (seconds):", t1 - t0

end program
