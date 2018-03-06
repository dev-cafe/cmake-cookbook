/*  libuuid sample program
 *  https://gist.github.com/yoggy/4483031
 */

#include <uuid/uuid.h>

int main(int argc, char *argv[]) {
  uuid_t uuid;

  uuid_generate(uuid);

  return 0;
}
