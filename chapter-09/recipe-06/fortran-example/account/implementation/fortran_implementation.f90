module account_implementation

  use, intrinsic :: iso_c_binding, only: c_double, c_ptr

  implicit none

  private

  public account_new
  public account_free
  public account_deposit
  public account_withdraw
  public account_get_balance

  type :: account
    private
    real(c_double) :: balance
    logical :: is_initialized = .false.
  end type

contains

  type(c_ptr) function account_new() bind (c)
    use, intrinsic :: iso_c_binding, only: c_loc
    type(account), pointer :: f_context
    type(c_ptr) :: context

    allocate(f_context)
    context = c_loc(f_context)
    account_new = context
    f_context%balance = 0.0d0
    f_context%is_initialized = .true.
  end function

  subroutine account_free(context) bind (c)
    use, intrinsic :: iso_c_binding, only: c_f_pointer
    type(c_ptr), value :: context
    type(account), pointer :: f_context

    call c_f_pointer(context, f_context)
    call check_valid_context(f_context)
    f_context%balance = 0.0d0
    f_context%is_initialized = .false.
    deallocate(f_context)
  end subroutine

  subroutine check_valid_context(f_context)
    type(account), pointer, intent(in) :: f_context
    if (.not. associated(f_context)) then
        print *, 'ERROR: context is not associated'
        stop 1
    end if
    if (.not. f_context%is_initialized) then
        print *, 'ERROR: context is not initialized'
        stop 1
    end if
  end subroutine

  subroutine account_withdraw(context, amount) bind (c)
    use, intrinsic :: iso_c_binding, only: c_f_pointer
    type(c_ptr), value :: context
    real(c_double), value :: amount
    type(account), pointer :: f_context

    call c_f_pointer(context, f_context)
    call check_valid_context(f_context)
    f_context%balance = f_context%balance - amount
  end subroutine

  subroutine account_deposit(context, amount) bind (c)
    use, intrinsic :: iso_c_binding, only: c_f_pointer
    type(c_ptr), value :: context
    real(c_double), value :: amount
    type(account), pointer :: f_context

    call c_f_pointer(context, f_context)
    call check_valid_context(f_context)
    f_context%balance = f_context%balance + amount
  end subroutine

  real(c_double) function account_get_balance(context) bind (c)
    use, intrinsic :: iso_c_binding, only: c_f_pointer
    type(c_ptr), value, intent(in) :: context
    type(account), pointer :: f_context

    call c_f_pointer(context, f_context)
    call check_valid_context(f_context)
    account_get_balance = f_context%balance
  end function

end module
