program test

  use evolution, only: evolve

  implicit none

  integer :: row(9)
  integer :: expected_result(9)
  integer :: rule_binary(8)
  integer :: i

  ! test rule 90
  row = (/0, 1, 0, 1, 0, 1, 0, 1, 0/)
  rule_binary = (/0, 1, 0, 1, 1, 0, 1, 0/)
  call evolve(row, rule_binary)
  expected_result = (/1, 0, 0, 0, 0, 0, 0, 0, 1/)
  do i = 1, 9
    if (row(i) /= expected_result(i)) then
      print *, 'ERROR: test for rule 90 failed'
      call exit(1)
    end if
  end do

  ! test rule 222
  row = (/0, 0, 0, 0, 1, 0, 0, 0, 0/)
  rule_binary = (/1, 1, 0, 1, 1, 1, 1, 0/)
  call evolve(row, rule_binary)
  expected_result = (/0, 0, 0, 1, 1, 1, 0, 0, 0/)
  do i = 1, 9
    if (row(i) /= expected_result(i)) then
      print *, 'ERROR: test for rule 222 failed'
      call exit(1)
    end if
  end do

end program
