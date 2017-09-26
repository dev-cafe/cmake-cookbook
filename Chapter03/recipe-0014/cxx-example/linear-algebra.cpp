// Original example by Evgenii Rudnyi http://MatrixProgramming.com
// found at: http://matrixprogramming.com/files/code/LAPACK/dgesv.cpp

#include <chrono>
#include <cmath>
#include <cstdlib>
#include <ctime>
#include <iomanip>
#include <iostream>
#include <vector>

#include "CxxBLAS.hpp"
#include "CxxLAPACK.hpp"

int main(int argc, char ** argv) {
  if (argc != 2) {
    std::cout << "Vector and matrix dimensions " << std::endl;
    return 0;
  }
  std::chrono::time_point<std::chrono::system_clock> start, end;
  std::chrono::duration<double> elapsed_seconds;
  std::time_t end_time;

  // Allocate matrices and right-hand side vector
  start = std::chrono::system_clock::now();
  int dim = std::atoi(argv[1]);
  std::vector<double> a(dim * dim);
  std::vector<double> b(dim);
  std::vector<int> ipiv(dim);
  std::srand(1); // seed the random # generator with a known value
  double maxr = (double)RAND_MAX;
  for (int r = 0; r < dim; r++) { // set a to a random matrix, i to the identity
    for (int c = 0; c < dim; c++) {
      a[r + c * dim] = rand() / maxr;
    }
    b[r] = rand() / maxr;
  }
  std::vector<double> a1(a);
  std::vector<double> b1(b);
  end = std::chrono::system_clock::now();
  // Report times
  elapsed_seconds = end - start;
  end_time = std::chrono::system_clock::to_time_t(end);
  std::cout << "matrices allocated and initialized " << std::ctime(&end_time)
            << "elapsed time: " << elapsed_seconds.count() << "s\n";

  int info;
  start = std::chrono::system_clock::now();
  int one = 1;
  info = C_DGESV(dim, one, a.data(), dim, ipiv.data(), b.data(), dim);
  end = std::chrono::system_clock::now();
  // Report times
  elapsed_seconds = end - start;
  end_time = std::chrono::system_clock::to_time_t(end);

  std::cout << "dgesv done " << std::ctime(&end_time)
            << "elapsed time: " << elapsed_seconds.count() << "s\n";
  std::cout << "info is " << info << std::endl;

  double eps = 0.;
  for (int i = 0; i < dim; ++i) {
    double sum = 0.;
    for (int j = 0; j < dim; ++j)
      sum += a1[i + j * dim] * b[j];
    eps += std::fabs(b1[i] - sum);
  }
  std::cout << "check is " << eps << std::endl;

  return 0;
}
