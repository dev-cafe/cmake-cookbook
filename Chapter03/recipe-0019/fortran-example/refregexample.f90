!   Copyright by The HDF Group.                                               *
!   Copyright by the Board of Trustees of the University of Illinois.         *
!   All rights reserved.                                                      *
!                                                                             *
!   This file is part of HDF5.  The full HDF5 copyright notice, including     *
!   terms governing use, modification, and redistribution, is contained in    *
!   the COPYING file, which can be found at the root of the source code       *
!   distribution tree, or in https://support.hdfgroup.org/ftp/HDF5/releases.  *
!   If you do not have access to either file, you may request a copy from     *
!   help@hdfgroup.org.                                                        *
! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
!
!
!    This program shows how to create, store and dereference references
!    to the dataset regions.
!    Program creates a file and writes two dimensional integer dataset
!    to it. Then program creates and stores references to the hyperslab
!    and 3 points selected in the integer dataset, in the second dataset.
!    Program reopens the second dataset, reads and dereferences region
!    references, and then reads and displays selected data from the
!    integer dataset.
!
PROGRAM REG_REFERENCE

   USE HDF5 ! This module contains all necessary modules

IMPLICIT NONE
CHARACTER(LEN=10), PARAMETER :: filename = "FORTRAN.h5"
CHARACTER(LEN=6), PARAMETER :: dsetnamev = "MATRIX"
CHARACTER(LEN=17), PARAMETER :: dsetnamer = "REGION_REFERENCES"

INTEGER(HID_T) :: file_id       ! File identifier
INTEGER(HID_T) :: space_id      ! Dataspace identifier
INTEGER(HID_T) :: spacer_id     ! Dataspace identifier
INTEGER(HID_T) :: dsetv_id      ! Dataset identifier
INTEGER(HID_T) :: dsetr_id      ! Dataset identifier
INTEGER     ::   error
TYPE(hdset_reg_ref_t_f) , DIMENSION(2) :: ref     ! Buffers to store references
TYPE(hdset_reg_ref_t_f) , DIMENSION(2) :: ref_out !
INTEGER(HSIZE_T), DIMENSION(2) :: dims = (/2,9/)  ! Datasets dimensions
INTEGER(HSIZE_T), DIMENSION(1) :: dimsr = (/2/)   !
INTEGER(HSIZE_T), DIMENSION(2) :: start
INTEGER(HSIZE_T), DIMENSION(2) :: count
INTEGER :: rankr = 1
INTEGER :: rank = 2
INTEGER , DIMENSION(2,9) ::  data
INTEGER , DIMENSION(2,9) ::  data_out = 0
INTEGER(HSIZE_T) , DIMENSION(2,3) :: coord
INTEGER(SIZE_T) ::num_points = 3  ! Number of selected points
INTEGER :: i, j
INTEGER(HSIZE_T), DIMENSION(1) :: ref_size
INTEGER(HSIZE_T), DIMENSION(2) :: data_dims
coord = reshape((/1,1,2,7,1,9/), (/2,3/))   ! Coordinates of selected points
data = reshape ((/1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6/), (/2,9/))
!
!  Initialize FORTRAN interface.
!
CALL h5open_f(error)
!
!  Create a new file.
!
CALL h5fcreate_f(filename, H5F_ACC_TRUNC_F, file_id, error)
                                    ! Default file access and file creation
                                    ! properties are used.
!
! Create  dataspaces:
!
! for dataset with references to dataset regions
!
CALL h5screate_simple_f(rankr, dimsr, spacer_id, error)
!
! for integer dataset
!
CALL h5screate_simple_f(rank, dims, space_id, error)
!
! Create  and write datasets:
!
! Integer dataset
!
CALL h5dcreate_f(file_id, dsetnamev, H5T_NATIVE_INTEGER, space_id, &
                 dsetv_id, error)
data_dims(1) = 2
data_dims(2) = 9
CALL h5dwrite_f(dsetv_id, H5T_NATIVE_INTEGER, data, data_dims, error)
CALL h5dclose_f(dsetv_id, error)
!
! Dataset with references
!
CALL h5dcreate_f(file_id, dsetnamer, H5T_STD_REF_DSETREG, spacer_id, &
                 dsetr_id, error)
!
! Create a reference to the hyperslab selection.
!
start(1) = 0
start(2) = 3
count(1) = 2
count(2) = 3
CALL h5sselect_hyperslab_f(space_id, H5S_SELECT_SET_F, &
                           start, count, error)
CALL h5rcreate_f(file_id, dsetnamev, space_id, ref(1), error)
!
! Create a reference to elements selection.
!
CALL h5sselect_none_f(space_id, error)
CALL h5sselect_elements_f(space_id, H5S_SELECT_SET_F, rank, num_points,&
                          coord, error)
CALL h5rcreate_f(file_id, dsetnamev, space_id, ref(2), error)
!
! Write dataset with the references.
!
ref_size(1) = size(ref)
CALL h5dwrite_f(dsetr_id, H5T_STD_REF_DSETREG, ref, ref_size, error)
!
! Close all objects.
!
CALL h5sclose_f(space_id, error)
CALL h5sclose_f(spacer_id, error)
CALL h5dclose_f(dsetr_id, error)
CALL h5fclose_f(file_id, error)
!
! Reopen the file to test selections.
!
CALL h5fopen_f (filename, H5F_ACC_RDWR_F, file_id, error)
CALL h5dopen_f(file_id, dsetnamer, dsetr_id, error)
!
! Read references to the dataset regions.
!
ref_size(1) = size(ref_out)
CALL h5dread_f(dsetr_id, H5T_STD_REF_DSETREG, ref_out, ref_size, error)
!
! Dereference the first reference.
!
CALL H5rdereference_f(dsetr_id, ref_out(1), dsetv_id, error)
CALL H5rget_region_f(dsetr_id, ref_out(1), space_id, error)
!
! Read selected data from the dataset.
!
CALL h5dread_f(dsetv_id, H5T_NATIVE_INTEGER, data_out, data_dims, error, &
                mem_space_id = space_id, file_space_id = space_id)
     write(*,*) "Hypeslab selection"
     write(*,*)
     do i = 1,2
     write(*,*) (data_out (i,j), j = 1,9)
     enddo
     write(*,*)
CALL h5sclose_f(space_id, error)
CALL h5dclose_f(dsetv_id, error)
data_out = 0
!
! Dereference the second reference.
!
CALL H5rdereference_f(dsetr_id, ref_out(2), dsetv_id, error)
CALL H5rget_region_f(dsetr_id, ref_out(2), space_id, error)
!
! Read selected data from the dataset.
!
CALL h5dread_f(dsetv_id, H5T_NATIVE_INTEGER, data_out, data_dims, error, &
                mem_space_id = space_id, file_space_id = space_id)
     write(*,*) "Point selection"
     write(*,*)
     do i = 1,2
     write(*,*) (data_out (i,j), j = 1,9)
     enddo
!
! Close all objects
!
CALL h5sclose_f(space_id, error)
CALL h5dclose_f(dsetv_id, error)
CALL h5dclose_f(dsetr_id, error)
!
! Close FORTRAN interface.
!
CALL h5close_f(error)

END PROGRAM REG_REFERENCE
