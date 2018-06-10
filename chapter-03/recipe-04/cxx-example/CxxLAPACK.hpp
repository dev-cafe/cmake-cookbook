// resolve mangling, adapted from Psi4

#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#define F_DGESV dgesv_
extern int F_DGESV(int *, int *, double *, int *, int *, double *, int *, int *);

#ifdef __cplusplus
}
#endif

int C_DGESV(int n, int nrhs, double *a, int lda, int *ipiv, double *b, int ldb);
