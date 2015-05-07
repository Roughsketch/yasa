#ifndef YASA_UTIL
#define YASA_UTIL

#include <string>
#include <sstream>
#include <cstdlib>

namespace util
{
  bool isnum(const std::string& s);

  template <typename T> std::string to_string(const T& n)
  {
    std::ostringstream stm;
    stm << n;
    return stm.str();
  }
}

#endif
