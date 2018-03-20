! This is the F2003 version of the h5_compound.c example source code.
! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
! Copyright by the Board of Trustees of the University of Illinois.         *
! All rights reserved.                                                      *
!                                                                           *
! This file is part of HDF5.  The full HDF5 copyright notice, including     *
! terms governing use, modification, and redistribution, is contained in    *
!   the COPYING file, which can be found at the root of the source code       *
!   distribution tree, or in https://support.hdfgroup.org/ftp/HDF5/releases.  *
!   If you do not have access to either file, you may request a copy from     *
!   help@hdfgroup.org.                                                        *
! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
!
! This example shows how to create a compound data type,
! write an array which has the compound data type to the file,
! and read back fields' subsets.
!

PROGRAM main
  USE hdf5
  USE ISO_C_BINDING
  IMPLICIT NONE

! KIND parameters

  INTEGER, PARAMETER :: int_k1 = SELECTED_INT_KIND(1)  ! This should map to INTEGER*1 on most modern processors
  INTEGER, PARAMETER :: int_k2 = SELECTED_INT_KIND(4)  ! This should map to INTEGER*2 on most modern processors
  INTEGER, PARAMETER :: int_k4 = SELECTED_INT_KIND(8)  ! This should map to INTEGER*4 on most modern processors
  INTEGER, PARAMETER :: int_k8 = SELECTED_INT_KIND(16) ! This should map to INTEGER*8 on most modern processors

  INTEGER, PARAMETER :: r_k4 = SELECTED_REAL_KIND(5)  ! This should map to REAL*4 on most modern processors
  INTEGER, PARAMETER :: r_k8 = SELECTED_REAL_KIND(10) ! This should map to REAL*8 on most modern processors

! FILES

  CHARACTER(LEN=*), PARAMETER :: H5FILE_NAME = "SDScompound.h5"
  CHARACTER(LEN=*), PARAMETER :: DATASETNAME = "ArrayOfStructures"

  INTEGER, PARAMETER :: LENGTH = 10
  INTEGER, PARAMETER :: RANK = 1

!----------------------------------------------------------------
! First derived-type and dataset
  TYPE s1_t
     CHARACTER(LEN=1), DIMENSION(1:13) :: chr
     INTEGER(KIND=int_k1) :: a
     REAL(KIND=r_k4) :: b
     REAL(KIND=r_k8) :: c
  END TYPE s1_t

  TYPE(s1_t), TARGET :: s1(LENGTH)
  INTEGER(hid_t) :: s1_tid     ! File datatype identifier

!----------------------------------------------------------------
! Second derived-type (subset of s1_t)  and dataset
  TYPE s2_t
     CHARACTER(LEN=1), DIMENSION(1:13) :: chr
     REAL(KIND=r_k8) :: c
     INTEGER(KIND=int_k1) :: a
  END TYPE s2_t

  type(s2_t), target :: s2(LENGTH)
  integer(hid_t) :: s2_tid    ! Memory datatype handle

!----------------------------------------------------------------
! Third "derived-type" (will be used to read float field of s1)
  INTEGER(hid_t) :: s3_tid   ! Memory datatype handle
  REAL(KIND=r_k4), TARGET :: s3(LENGTH)

  INTEGER :: i
  INTEGER(hid_t) :: file, dataset, space
  !type(H5F_fileid_type) :: file
  !type(H5D_dsetid_type) :: dataset
  !type(H5S_spaceid_type) :: space
  INTEGER(hsize_t) :: DIM(1) = (/LENGTH/)   ! Dataspace dimensions
  INTEGER(SIZE_T) :: type_size  ! Size of the datatype
  INTEGER(SIZE_T) :: offset, sizeof_compound
  INTEGER :: hdferr
  TYPE(C_PTR) :: f_ptr

  INTEGER(SIZE_T) :: type_sizei  ! Size of the integer datatype
  INTEGER(SIZE_T) :: type_sizer  ! Size of the real datatype
  INTEGER(SIZE_T) :: type_sized  ! Size of the double datatype
  INTEGER(hid_t) :: tid3      ! /* Nested Array Datatype ID	*/
  INTEGER(HSIZE_T), DIMENSION(1) :: tdims1=(/13/)
  !
  ! Initialize FORTRAN interface.
  !

  CALL h5open_f(hdferr)

  !
  ! Initialize the data
  !
  DO i = 0, LENGTH-1
     s1(i+1)%chr(1)(1:1) = 'a'
     s1(i+1)%chr(2)(1:1) = 'b'
     s1(i+1)%chr(3)(1:1) = 'c'
     s1(i+1)%chr(4:12)(1:1) = ' '
     s1(i+1)%chr(13)(1:1) = 'd'
     s1(i+1)%a = i
     s1(i+1)%b = i*i
     s1(i+1)%c = 1./REAL(i+1)
  END DO
  !
  ! Create the data space.
  !
  !
  CALL H5Screate_simple_f(RANK, dim, space, hdferr)

  !
  ! Create the file.
  !
  CALL H5Fcreate_f(H5FILE_NAME, H5F_ACC_TRUNC_F, file, hdferr)

  !
  ! Create the memory data type.
  !
  CALL H5Tcreate_f(H5T_COMPOUND_F, H5OFFSETOF(C_LOC(s1(1)), C_LOC(s1(2))), s1_tid, hdferr)

  CALL h5tarray_create_f(H5T_NATIVE_CHARACTER, 1, tdims1, tid3, hdferr)

  CALL H5Tinsert_f(s1_tid, "chr_name", H5OFFSETOF(C_LOC(s1(1)),C_LOC(s1(1)%chr)),tid3, hdferr)
  CALL H5Tinsert_f(s1_tid, "a_name", H5OFFSETOF(C_LOC(s1(1)),C_LOC(s1(1)%a)), h5kind_to_type(int_k1,H5_INTEGER_KIND), hdferr)
  CALL H5Tinsert_f(s1_tid, "c_name", H5OFFSETOF(C_LOC(s1(1)),C_LOC(s1(1)%c)), h5kind_to_type(r_k8,H5_REAL_KIND), hdferr)
  CALL H5Tinsert_f(s1_tid, "b_name", H5OFFSETOF(C_LOC(s1(1)),C_LOC(s1(1)%b)), h5kind_to_type(r_k4,H5_REAL_KIND), hdferr)

  !
  ! Create the dataset.
  !
  CALL H5Dcreate_f(file, DATASETNAME, s1_tid, space, dataset, hdferr)

  !
  ! Write data to the dataset
  !

  f_ptr = C_LOC(s1(1))
  CALL H5Dwrite_f(dataset, s1_tid, f_ptr, hdferr)

  !
  ! Release resources
  !
  CALL H5Tclose_f(s1_tid, hdferr)
  CALL H5Sclose_f(space, hdferr)
  CALL H5Dclose_f(dataset, hdferr)
  CALL H5Fclose_f(file, hdferr)

  !
  ! Open the file and the dataset.
  !

  CALL H5Fopen_f(H5FILE_NAME, H5F_ACC_RDONLY_F, file, hdferr)

  CALL H5Dopen_f(file, DATASETNAME, dataset,hdferr)

  !
  ! Create a data type for s2
  !
  CALL H5Tcreate_f(H5T_COMPOUND_F,  H5OFFSETOF(C_LOC(s2(1)), C_LOC(s2(2))), s2_tid, hdferr)

  CALL H5Tinsert_f(s2_tid, "chr_name", H5OFFSETOF(C_LOC(s2(1)),C_LOC(s2(1)%chr)), tid3, hdferr)
  CALL H5Tinsert_f(s2_tid, "c_name", H5OFFSETOF(C_LOC(s2(1)),C_LOC(s2(1)%c)), h5kind_to_type(r_k8,H5_REAL_KIND), hdferr)
  CALL H5Tinsert_f(s2_tid, "a_name", H5OFFSETOF(C_LOC(s2(1)),C_LOC(s2(1)%a)), h5kind_to_type(int_k1,H5_INTEGER_KIND), hdferr)

  !
  ! Read two fields c and a from s1 dataset. Fields in the file
  ! are found by their names "c_name" and "a_name".
  s2(:)%c=-1; s2(:)%a=-1;


  f_ptr = C_LOC(s2(1))
  CALL H5Dread_f(dataset, s2_tid, f_ptr, hdferr)

  !
  ! Display the fields
  !
  DO i = 1, length
     WRITE(*,'(/,A,/,999(A,1X))') "Field chr :", s2(i)%chr(1:13)(1:1)
  ENDDO
  WRITE(*,'(/,A,/,999(F8.4,1X))') "Field c :", s2(:)%c
  WRITE(*,'(/,A,/,999(I0,1X))') "Field a :", s2(:)%a
  !
  ! Create a data type for s3.
  !
  CALL H5Tcreate_f(H5T_COMPOUND_F, H5OFFSETOF(C_LOC(s3(1)),C_LOC(s3(2))),s3_tid, hdferr)

  CALL H5Tinsert_f(s3_tid, "b_name", 0_size_t, h5kind_to_type(r_k4,H5_REAL_KIND), hdferr)
  !
  ! Read field b from s1 dataset. Field in the file is found by its name.
  !
  s3(:)=-1
  f_ptr = C_LOC(s3(1))
  CALL H5Dread_f(dataset, s3_tid, f_ptr, hdferr)
  !
  ! Display the field
  !
  WRITE(*,'(/,A,/,999(F8.4,1X))') "Field b :",s3(:)
  !
  ! Release resources
  !
  CALL H5Tclose_f(s2_tid, hdferr)
  CALL H5Tclose_f(s3_tid, hdferr)
  CALL H5Dclose_f(dataset, hdferr)
  CALL H5Fclose_f(file, hdferr)

END PROGRAM main
