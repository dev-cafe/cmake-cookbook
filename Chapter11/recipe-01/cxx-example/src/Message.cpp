#include "Message.hpp"

#include <iostream>
#include <string>

#ifndef EXCLUDE_UUID
#include <uuid/uuid.h>
#endif

std::ostream &Message::printObject(std::ostream &os) {
  os << "This is my very nice message: " << std::endl;
  os << message_ << std::endl;
  os << "...and here is its UUID: " << getUUID();

  return os;
}

#ifdef EXCLUDE_UUID
std::string getUUID() { return "Ooooops, no UUID for you!"; }
#else
std::string getUUID() {
  uuid_t uuid;
  uuid_generate(uuid);
  char uuid_str[37];
  uuid_unparse_lower(uuid, uuid_str);
  uuid_clear(uuid);
  std::string uuid_cxx(uuid_str);
  return uuid_cxx;
}
#endif
