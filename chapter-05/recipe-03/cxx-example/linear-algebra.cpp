// Original example by Evgenii Rudnyi http://MatrixProgramming.com
// found at: http://matrixprogramming.com/files/code/LAPACK/dgesv.cpp

#include "CxxBLAS.hpp"
#include "CxxLAPACK.hpp"

#include <chrono>
#include <cstdlib>
#include <iostream>
#include <random>
#include <vector>

int main(int argc, char **argv) {
  if (argc != 2) {
    std::cout << "Usage: ./linear-algebra dim" << std::endl;
    return EXIT_FAILURE;
  }

  // Generate a uniform distribution of real number between -1.0 and 1.0
  std::random_device rd;
  std::mt19937 mt(rd());
  std::uniform_real_distribution<double> dist(-1.0, 1.0);

  std::chrono::time_point<std::chrono::system_clock> start, end;
  std::chrono::duration<double> elapsed_seconds;
  std::time_t end_time;

  // Allocate matrices and right-hand side vector
  start = std::chrono::system_clock::now();
  int dim = std::atoi(argv[1]);
  std::vector<double> A(dim * dim);
  std::vector<double> b(dim);
  std::vector<int> ipiv(dim);
  // Fill matrix and RHS with random numbers between -1.0 and 1.0
  for (int r = 0; r < dim; r++) {
    for (int c = 0; c < dim; c++) {
      A[r + c * dim] = dist(mt);
    }
    b[r] = dist(mt);
  }
  end = std::chrono::system_clock::now();
  // Report times
  elapsed_seconds = end - start;
  end_time = std::chrono::system_clock::to_time_t(end);
  std::cout << "matrices allocated and initialized " << std::ctime(&end_time)
            << "elapsed time: " << elapsed_seconds.count() << "s\n";

  start = std::chrono::system_clock::now();
  // Scale RHS vector by a random number between -1.0 and 1.0
  C_DSCAL(dim, dist(mt), b.data(), 1);
  // Save matrix and RHS
  std::vector<double> A1(A);
  std::vector<double> b1(b);
  end = std::chrono::system_clock::now();
  end_time = std::chrono::system_clock::to_time_t(end);
  std::cout << "C_DSCAL done, A and b saved " << std::ctime(&end_time)
            << "elapsed time: " << elapsed_seconds.count() << "s\n";

  int info;
  start = std::chrono::system_clock::now();
  info = C_DGESV(dim, 1, A.data(), dim, ipiv.data(), b.data(), dim);
  end = std::chrono::system_clock::now();
  // Report times
  elapsed_seconds = end - start;
  end_time = std::chrono::system_clock::to_time_t(end);

  std::cout << "C_DGESV done " << std::ctime(&end_time)
            << "elapsed time: " << elapsed_seconds.count() << "s\n";
  std::cout << "info is " << info << std::endl;

  double eps = 0.;
  for (int i = 0; i < dim; ++i) {
    double sum = 0.;
    for (int j = 0; j < dim; ++j)
      sum += A1[i + j * dim] * b[j];
    eps += std::abs(b1[i] - sum);
  }
  std::cout << "check is " << eps << std::endl;

  return 0;
}
