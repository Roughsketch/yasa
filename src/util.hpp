#ifndef YASA_UTIL
#define YASA_UTIL

#include <string>
#include <sstream>
#include <cstdlib>

namespace util
{
  bool isnum(const std::string& s);

  enum Conversion
  {
    Unheadered = 0,
    Headered,
    PctoSnes,
    SnestoPc = 0,
    LoRom = 0
  };

  //  Code taken from Alcaro's post: http://smwc.me/735496
  int convaddr(int addr, Conversion mode = SnestoPc);

  /*
    Returns byte size taken up by a number up to 3 bytes (max SNES limit for a parameter)
  */
  template <typename T> int bytesize(const T& n)
  {
    static_assert(std::is_integral<T>::value, "Function requires an integral type.");

    if (n == (n & 0xFF))
    {
      return 1;
    }
    else if (n == (n & 0xFFFF))
    {
      return 2;
    }
    else if (n == (n & 0xFFFFFF))
    {
      return 3;
    }

    return 0;
  }

  template <typename T> std::string to_string(const T& n)
  {
    std::ostringstream stm;
    stm << n;
    return stm.str();
  }
}

#endif
