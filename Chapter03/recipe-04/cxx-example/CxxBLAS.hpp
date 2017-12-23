// Resolve mangling of some BLAS subroutines
// Adapted from Psi4

#pragma once

#include <cstddef>

#ifdef __cplusplus
extern "C" {
#endif

#define F_DGEMM dgemm_
extern void F_DGEMM(char *,
                    char *,
                    int *,
                    int *,
                    int *,
                    double *,
                    double *,
                    int *,
                    double *,
                    int *,
                    double *,
                    double *,
                    int *);

#define F_DSCAL dscal_
extern void F_DSCAL(int * n, double * alpha, double * vec, int * inc);

#ifdef __cplusplus
}
#endif

void C_DGEMM(char transa,
             char transb,
             int m,
             int n,
             int k,
             double alpha,
             double * a,
             int lda,
             double * b,
             int ldb,
             double beta,
             double * c,
             int ldc);

/*!
 * This function scales a vector by a real scalar.
 *
 * \param length length of array
 * \param alpha  scale factor
 * \param vec    vector to scale
 * \param inc    how many places to skip to get to next element in vec
 *
 */
void C_DSCAL(size_t length, double alpha, double * vec, int inc);
