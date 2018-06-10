// resolve mangling, adapted from Psi4

#pragma once

#include "fc_mangle.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int DGESV(int *, int *, double *, int *, int *, double *, int *, int *);

#ifdef __cplusplus
}
#endif

int C_DGESV(int n, int nrhs, double *a, int lda, int *ipiv, double *b, int ldb);
