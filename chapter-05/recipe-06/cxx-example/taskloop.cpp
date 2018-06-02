// example adapted from
// http://www.openmp.org/wp-content/uploads/openmp-examples-4.5.0.pdf page 85

void long_running_task(){
    // do something
};

void loop_body(int i, int j){
    // do something
};

void parallel_work() {
  int i, j;
#pragma omp taskgroup
  {
#pragma omp task
    long_running_task(); // can execute concurrently

#pragma omp taskloop private(j) grainsize(500) nogroup
    for (i = 0; i < 10000; i++) { // can execute concurrently
      for (j = 0; j < i; j++) {
        loop_body(i, j);
      }
    }
  }
}

int main() {
  parallel_work();
  return 0;
}
