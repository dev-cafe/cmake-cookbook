#include <cstdio>
#include <map>
#include <pthread.h>
#include <string>

typedef std::map<std::string, std::string> map_t;

void *threadfunc(void *p) {
  map_t &m = *(map_t *)p;
  m["foo"] = "bar";
  return 0;
}

int main() {
  map_t m;
  pthread_t t;
  pthread_create(&t, 0, threadfunc, &m);
  printf("foo=%s\n", m["foo"].c_str());
  pthread_join(t, 0);
}
