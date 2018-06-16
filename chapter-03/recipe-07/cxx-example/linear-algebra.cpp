#include <chrono>
#include <cmath>
#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <vector>

#include <Eigen/Dense>

int main(int argc, char **argv) {
  if (argc != 2) {
    std::cout << "Usage: ./linear-algebra dim" << std::endl;
    return EXIT_FAILURE;
  }

  std::chrono::time_point<std::chrono::system_clock> start, end;
  std::chrono::duration<double> elapsed_seconds;
  std::time_t end_time;

  std::cout << "Number of threads used by Eigen: " << Eigen::nbThreads()
            << std::endl;

  // Allocate matrices and right-hand side vector
  start = std::chrono::system_clock::now();
  int dim = std::atoi(argv[1]);
  Eigen::MatrixXd A = Eigen::MatrixXd::Random(dim, dim);
  Eigen::VectorXd b = Eigen::VectorXd::Random(dim);
  end = std::chrono::system_clock::now();

  // Report times
  elapsed_seconds = end - start;
  end_time = std::chrono::system_clock::to_time_t(end);
  std::cout << "matrices allocated and initialized "
            << std::put_time(std::localtime(&end_time), "%a %b %d %Y %r\n")
            << "elapsed time: " << elapsed_seconds.count() << "s\n";

  start = std::chrono::system_clock::now();
  // Save matrix and RHS
  Eigen::MatrixXd A1 = A;
  Eigen::VectorXd b1 = b;
  end = std::chrono::system_clock::now();
  end_time = std::chrono::system_clock::to_time_t(end);
  std::cout << "Scaling done, A and b saved "
            << std::put_time(std::localtime(&end_time), "%a %b %d %Y %r\n")
            << "elapsed time: " << elapsed_seconds.count() << "s\n";

  start = std::chrono::system_clock::now();
  Eigen::VectorXd x = A.lu().solve(b);
  end = std::chrono::system_clock::now();

  // Report times
  elapsed_seconds = end - start;
  end_time = std::chrono::system_clock::to_time_t(end);

  double relative_error = (A * x - b).norm() / b.norm();

  std::cout << "Linear system solver done "
            << std::put_time(std::localtime(&end_time), "%a %b %d %Y %r\n")
            << "elapsed time: " << elapsed_seconds.count() << "s\n";
  std::cout << "relative error is " << relative_error << std::endl;

  return 0;
}
