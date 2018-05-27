#include "mkl.h"

#include <cassert>
#include <cmath>
#include <iostream>
#include <random>

int main() {
  // generate a uniform distribution of real number between -1.0 and 1.0
  std::random_device rd;
  std::mt19937 mt(rd());
  std::uniform_real_distribution<double> dist(-1.0, 1.0);

  int m = 500;
  int k = 1000;
  int n = 2000;

  double *A = (double *)mkl_malloc(m * k * sizeof(double), 64);
  double *B = (double *)mkl_malloc(k * n * sizeof(double), 64);
  double *C = (double *)mkl_malloc(m * n * sizeof(double), 64);
  double *D = new double[m * n];

  for (int i = 0; i < (m * k); i++) {
    A[i] = dist(mt);
  }

  for (int i = 0; i < (k * n); i++) {
    B[i] = dist(mt);
  }

  for (int i = 0; i < (m * n); i++) {
    C[i] = 0.0;
  }

  double alpha = 1.0;
  double beta = 0.0;
  cblas_dgemm(CblasRowMajor,
              CblasNoTrans,
              CblasNoTrans,
              m,
              n,
              k,
              alpha,
              A,
              k,
              B,
              n,
              beta,
              C,
              n);

  // D_mn = A_mk B_kn
  for (int r = 0; r < m; r++) {
    for (int c = 0; c < n; c++) {
      D[r * n + c] = 0.0;
      for (int i = 0; i < k; i++) {
        D[r * n + c] += A[r * k + i] * B[i * n + c];
      }
    }
  }

  // compare the two matrices
  double r = 0.0;
  for (int i = 0; i < (m * n); i++) {
    r += std::pow(C[i] - D[i], 2.0);
  }
  assert(r < 1.0e-12 && "ERROR: matrices C and D do not match");

  mkl_free(A);
  mkl_free(B);
  mkl_free(C);
  delete[] D;

  std::cout << "MKL DGEMM example worked!" << std::endl;

  return 0;
}
