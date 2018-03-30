program example

  use parser, only: get_arg_as_int
  use conversion, only: binary_representation
  use initial, only: initial_distribution
  use io, only: print_row
  use evolution, only: evolve

  implicit none

  integer :: num_steps
  integer :: length
  integer :: rule_decimal
  integer :: rule_binary(8)
  integer, allocatable :: row(:)
  integer :: step

  ! parse arguments
  num_steps = get_arg_as_int(1)
  length = get_arg_as_int(2)
  rule_decimal = get_arg_as_int(3)

  ! print information about parameters
  print *, "number of steps: ", num_steps
  print *, "length: ", length
  print *, "rule: ", rule_decimal

  ! obtain binary representation for the rule
  rule_binary = binary_representation(rule_decimal)

  ! create initial distribution
  allocate(row(length))
  call initial_distribution(row)

  ! print initial configuration
  call print_row(row)

  ! the system evolves, print each step
  do step = 1, num_steps
    call evolve(row, rule_binary)
    call print_row(row)
  end do

  deallocate(row)

end program
