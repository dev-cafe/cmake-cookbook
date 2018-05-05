/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright by The HDF Group.                                               *
 * Copyright by the Board of Trustees of the University of Illinois.         *
 * All rights reserved.                                                      *
 *                                                                           *
 * This file is part of HDF5.  The full HDF5 copyright notice, including     *
 * terms governing use, modification, and redistribution, is contained in    *
 * the COPYING file, which can be found at the root of the source code       *
 * distribution tree, or in https://support.hdfgroup.org/ftp/HDF5/releases.  *
 * If you do not have access to either file, you may request a copy from     *
 * help@hdfgroup.org.                                                        *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*
 *  This example illustrates how to create a compressed dataset.
 *  It is used in the HDF5 Tutorial.
 */

#include "hdf5.h"

#define FILE    "cmprss.h5"
#define RANK    2
#define DIM0    100
#define DIM1    20

int main () {

    hid_t    file_id, dataset_id, dataspace_id; /* identifiers */
    hid_t    plist_id;

    size_t   nelmts;
    unsigned flags, filter_info;
    H5Z_filter_t filter_type;

    herr_t   status;
    hsize_t  dims[2];
    hsize_t  cdims[2];

    int      idx;
    int      i,j, numfilt;
    int      buf[DIM0][DIM1];
    int      rbuf [DIM0][DIM1];

    /* Uncomment these variables to use SZIP compression
    unsigned szip_options_mask;
    unsigned szip_pixels_per_block;
    */

    /* Create a file.  */
    file_id = H5Fcreate (FILE, H5F_ACC_TRUNC, H5P_DEFAULT, H5P_DEFAULT);


    /* Create dataset "Compressed Data" in the group using absolute name.  */
    dims[0] = DIM0;
    dims[1] = DIM1;
    dataspace_id = H5Screate_simple (RANK, dims, NULL);

    plist_id  = H5Pcreate (H5P_DATASET_CREATE);

    /* Dataset must be chunked for compression */
    cdims[0] = 20;
    cdims[1] = 20;
    status = H5Pset_chunk (plist_id, 2, cdims);

    /* Set ZLIB / DEFLATE Compression using compression level 6.
     * To use SZIP Compression comment out these lines.
    */
    status = H5Pset_deflate (plist_id, 6);

    /* Uncomment these lines to set SZIP Compression
    szip_options_mask = H5_SZIP_NN_OPTION_MASK;
    szip_pixels_per_block = 16;
    status = H5Pset_szip (plist_id, szip_options_mask, szip_pixels_per_block);
    */

    dataset_id = H5Dcreate2 (file_id, "Compressed_Data", H5T_STD_I32BE,
                            dataspace_id, H5P_DEFAULT, plist_id, H5P_DEFAULT);

    for (i = 0; i< DIM0; i++)
        for (j=0; j<DIM1; j++)
           buf[i][j] = i+j;

    status = H5Dwrite (dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT, buf);

    status = H5Sclose (dataspace_id);
    status = H5Dclose (dataset_id);
    status = H5Pclose (plist_id);
    status = H5Fclose (file_id);

    /* Now reopen the file and dataset in the file. */
    file_id = H5Fopen (FILE, H5F_ACC_RDWR, H5P_DEFAULT);
    dataset_id = H5Dopen2 (file_id, "Compressed_Data", H5P_DEFAULT);

    /* Retrieve filter information. */
    plist_id = H5Dget_create_plist (dataset_id);

    numfilt = H5Pget_nfilters (plist_id);
    printf ("Number of filters associated with dataset: %i\n", numfilt);

    for (i=0; i<numfilt; i++) {
       nelmts = 0;
       filter_type = H5Pget_filter2 (plist_id, 0, &flags, &nelmts, NULL, 0, NULL,
                     &filter_info);
       printf ("Filter Type: ");
       switch (filter_type) {
         case H5Z_FILTER_DEFLATE:
              printf ("H5Z_FILTER_DEFLATE\n");
              break;
         case H5Z_FILTER_SZIP:
              printf ("H5Z_FILTER_SZIP\n");
              break;
         default:
              printf ("Other filter type included.\n");
         }
    }

    status = H5Dread (dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL,
                      H5P_DEFAULT, rbuf);

    status = H5Dclose (dataset_id);
    status = H5Pclose (plist_id);
    status = H5Fclose (file_id);
}
