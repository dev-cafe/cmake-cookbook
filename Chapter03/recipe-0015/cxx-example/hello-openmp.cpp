#include <cstdlib>
#include <iostream>
#include <random>
#include <vector>

#include <omp.h>

/*  Purpose:
 *    This program has each thread print out its ID.
 *    This is a "Hello, World" program for OpenMP.
 *
 *  Licensing:
 *    This code is distributed under the GNU LGPL license.
 *
 *  Modified:
 *    19 May 2010
 *    27 September 2017
 *
 *  Author:
 *    John Burkardt
 *    Roberto Di Remigio
 */

int main(int argc, char * argv[]) {
  std::cout << "\n";
  std::cout << "HELLO_OPENMP" << std::endl;
  std::cout << "  C++11/OpenMP version" << std::endl;

  std::cout << "\n";
  std::cout << "  Number of processors available = " << omp_get_num_procs()
            << std::endl;
  std::cout << "  Number of threads =              " << omp_get_max_threads()
            << std::endl;

  // Generate a uniform distribution of real number between -1.0 and 1.0
  std::random_device rd;
  std::mt19937 mt(rd());
  std::uniform_real_distribution<double> dist(-1.0, 1.0);
  size_t dim = 100;

  int id;
  double start, end, elapsed;
  start = omp_get_wtime();

// Have each thread say hello
#pragma omp parallel private(id)
  {
    id = omp_get_thread_num();
    std::cout << "  This is process " << id << std::endl;
  }
  // Finish up by measuring the elapsed time.
  end = omp_get_wtime();
  elapsed = end - start;

  std::vector<double> a(dim);

#pragma omp parallel
  {
#pragma omp single
    {
      for (auto x : a) {
#pragma omp task
        {
          x = dist(mt);
          std::cout << x << std::endl;
        }
      }
    }
  }
  //  Terminate.
  std::cout << "\n";
  std::cout << "HELLO_OPENMP" << std::endl;
  std::cout << "  Normal end of execution." << std::endl;

  std::cout << "\n";
  std::cout << "  Elapsed wall clock time = " << elapsed << std::endl;

  return 0;
}
