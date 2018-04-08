#include <chrono>
#include <iostream>
#include <thread>

static const int num_threads = 16;

void increase(int i, int &s) {
  std::this_thread::sleep_for(std::chrono::seconds(1));
  std::cout << "thread " << i << " increases " << s++ << std::endl;
}

int main() {
  std::thread t[num_threads];

  int s = 0;

  // start threads
  for (auto i = 0; i < num_threads; i++) {
    t[i] = std::thread(increase, i, std::ref(s));
  }

  // join threads with main thread
  for (auto i = 0; i < num_threads; i++) {
    t[i].join();
  }

  std::cout << "final s: " << s << std::endl;

  return 0;
}
