// resolve mangling, adapted from Psi4

#pragma once

#include <cstddef>

#ifdef __cplusplus
extern "C" {
#endif

#define F_DSCAL dscal_
extern void F_DSCAL(int *n, double *alpha, double *vec, int *inc);

#ifdef __cplusplus
}
#endif

// scales a vector by a real scalar
void C_DSCAL(size_t length, double alpha, double *vec, int inc);
