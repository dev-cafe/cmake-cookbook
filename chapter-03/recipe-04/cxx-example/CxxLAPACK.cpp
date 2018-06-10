// Adapted from Psi4

#include "CxxLAPACK.hpp"

// see http://www.netlib.no/netlib/lapack/double/dgesv.f
int C_DGESV(int n, int nrhs, double *a, int lda, int *ipiv, double *b, int ldb) {
  int info;
  ::DGESV(&n, &nrhs, a, &lda, ipiv, b, &ldb, &info);
  return info;
}
