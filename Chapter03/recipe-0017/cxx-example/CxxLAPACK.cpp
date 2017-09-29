// Adapted from Psi4

#include "CxxLAPACK.hpp"

/*!
 *  Purpose
 *  =======
 *
 *  DGESV computes the solution to a real system of linear equations
 *     A * X = B,
 *  where A is an N-by-N matrix and X and B are N-by-NRHS matrices.
 *
 *  The LU decomposition with partial pivoting and row interchanges is
 *  used to factor A as
 *     A = P * L * U,
 *  where P is a permutation matrix, L is unit lower triangular, and U is
 *  upper triangular.  The factored form of A is then used to solve the
 *  system of equations A * X = B.
 *
 *  Arguments
 *  =========
 *
 *  N       (input) INTEGER
 *          The number of linear equations, i.e., the order of the
 *          matrix A.  N >= 0.
 *
 *  NRHS    (input) INTEGER
 *          The number of right hand sides, i.e., the number of columns
 *          of the matrix B.  NRHS >= 0.
 *
 *  A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
 *          On entry, the N-by-N coefficient matrix A.
 *          On exit, the factors L and U from the factorization
 *          A = P*L*U; the unit diagonal elements of L are not stored.
 *
 *  LDA     (input) INTEGER
 *          The leading dimension of the array A.  LDA >= max(1,N).
 *
 *  IPIV    (output) INTEGER array, dimension (N)
 *          The pivot indices that define the permutation matrix P;
 *          row i of the matrix was interchanged with row IPIV(i).
 *
 *  B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
 *          On entry, the N-by-NRHS matrix of right hand side matrix B.
 *          On exit, if INFO = 0, the N-by-NRHS solution matrix X.
 *
 *  LDB     (input) INTEGER
 *          The leading dimension of the array B.  LDB >= max(1,N).
 *
 *  C++ Return value: INFO    (output) INTEGER
 *          = 0:  successful exit
 *          < 0:  if INFO = -i, the i-th argument had an illegal value
 *          > 0:  if INFO = i, U(i,i) is exactly zero.  The factorization
 *                has been completed, but the factor U is exactly
 *                singular, so the solution could not be computed.
 *
 */
int C_DGESV(int n, int nrhs, double * a, int lda, int * ipiv, double * b, int ldb) {
  int info;
  ::F_DGESV(&n, &nrhs, a, &lda, ipiv, b, &ldb, &info);
  return info;
}

/*!
 * C_DSYEV(): Computes all eigenvalues and, optionally, eigenvectors of
 * a real symmetric matrix A.
 *
 * These arguments mimic their Fortran counterparts.
 *
 * \param jobz =   'N' or 'n' = compute eigenvalues only;
 *                 'V' or 'v' = compute both eigenvalues and eigenvectors.
 *
 * \param uplo =   'U' or 'u' = A contains the upper triangular part
 *                 of the matrix;
 *                 'L' or 'l' = A contains the lower triangular part
 *                 of the matrix.
 *
 * \param n    =   The order of the matrix A.
 *
 * \param A    =   On entry, the two-dimensional array with dimensions
 *                 n by lda.
 *                 On exit, if jobz = 'V', the columns of the matrix
 *                 contain the eigenvectors of A, but if jobz = 'N',
 *                 the contents of the matrix are destroyed.
 *
 * \param lda   =  The second dimension of A (i.e., the number of columns
 *                 allocated for A).
 *
 * \param w     =  The computed eigenvalues in ascending order.
 *
 * \param work  =  An array of length lwork.  On exit, if the return
 *                 value is 0, work[0] contains the optimal value of lwork.
 *
 * \param lwork =  The length of the array work.  A useful value of
 *                 lwork seems to be 3*N.
 *
 * Returns:  0 = successful exit
 *          <0 = the value of the i-th argument to the function was illegal
 *          >0 = the algorithm failed to converge.
 */
int C_DSYEV(char jobz,
            char uplo,
            int n,
            double * A,
            int lda,
            double * w,
            double * work,
            int lwork) {
  int info;

  ::F_DSYEV(&jobz, &uplo, &n, A, &lda, w, work, &lwork, &info);

  return info;
}
