// Resolve mangling of some LAPACK subroutines
// Adapted from Psi4

#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#define F_DGESV dgesv_
extern int F_DGESV(int *, int *, double *, int *, int *, double *, int *, int *);

#define F_DSYEV dsyev_
extern int
F_DSYEV(char *, char *, int *, double *, int *, double *, double *, int *, int *);

#ifdef __cplusplus
}
#endif

int C_DGESV(int n, int nrhs, double * a, int lda, int * ipiv, double * b, int ldb);

int C_DSYEV(char jobz,
            char uplo,
            int n,
            double * a,
            int lda,
            double * w,
            double * work,
            int lwork);
