//  Hello World server
//
// Example adapted from: http://zguide.zeromq.org/page:all

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include <zmq.h>

int main(void) {
  // Report version
  int major, minor, patch;
  zmq_version(&major, &minor, &patch);
  printf("Current 0MQ version is %d.%d.%d\n", major, minor, patch);

  //  Socket to talk to clients
  void *context = zmq_ctx_new();
  void *responder = zmq_socket(context, ZMQ_REP);
  int rc = zmq_bind(responder, "tcp://*:5555");
  assert(rc == 0);

  while (1) {
    char buffer[10];
    zmq_recv(responder, buffer, 10, 0);
    printf("Received Hello\n");
    sleep(1); //  Do some 'work'
    zmq_send(responder, "World", 5, 0);
  }
  return 0;
}
