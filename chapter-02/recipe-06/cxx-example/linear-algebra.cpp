#include <Eigen/Dense>
#include <chrono>
#include <iostream>

using namespace Eigen;
using namespace std;

EIGEN_DONT_INLINE
double simple_function(VectorXd &va, VectorXd &vb) {
  // this simple function computes the dot product of two vectors
  // of course it could be expressed more compactly
  double d = va.dot(vb);
  return d;
}

int main() {
  int len = 1000000;
  int num_repetitions = 100;

  std::chrono::time_point<std::chrono::system_clock> start, end;
  std::chrono::duration<double> elapsed_seconds;
  std::time_t end_time;

  // generate two random vectors
  VectorXd va = VectorXd::Random(len);
  VectorXd vb = VectorXd::Random(len);

  double result;
  start = std::chrono::system_clock::now();
  for (auto i = 0; i < num_repetitions; i++) {
    result = simple_function(va, vb);
  }
  end = std::chrono::system_clock::now();
  elapsed_seconds = end - start;

  cout << "result: " << result << endl;
  cout << "elapsed seconds: " << elapsed_seconds.count() << endl;
}
