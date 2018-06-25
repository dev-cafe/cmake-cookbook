#include <iostream>

#ifdef HAVE_MPI
#include <mpi.h>
#endif

int main() {
#ifdef HAVE_MPI
  // initialize MPI
  MPI_Init(NULL, NULL);

  // query and print the rank
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  std::cout << "hello from rank " << rank << std::endl;

  // initialize MPI
  MPI_Finalize();
#else
  std::cout << "hello from a sequential binary" << std::endl;
#endif /* HAVE_MPI */
}
