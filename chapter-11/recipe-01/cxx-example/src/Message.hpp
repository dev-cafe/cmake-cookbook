#pragma once

#include "messageExport.h"

#include <iosfwd>
#include <string>

class message_EXPORT Message {
public:
  Message(const std::string &m) : message_(m) {}

  friend std::ostream &operator<<(std::ostream &os, Message &obj) {
    return obj.printObject(os);
  }

private:
  std::string message_;
  std::ostream &printObject(std::ostream &os);
};

std::string getUUID();
