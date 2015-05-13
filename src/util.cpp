#include "util.hpp"

namespace util
{
  bool isnum(const std::string& s)
  {
    if (s.empty() || ((!isdigit(s[0])) && (s[0] != '-') && (s[0] != '+')))
    {
      return false;
    }

    char *p;
    strtol(s.c_str(), &p, 10);

    return (*p == 0);
  }

  int convaddr(int addr, Conversion mode) 
  {
    bool header = mode & 1;
    bool ispc = mode & 2;

    if (ispc) 
    {
      if (header) 
      {
        addr -= 512;
      } 

      if (addr < 0 || addr >= 0x400000) 
      {
        return -1;
      } 

      addr = ((addr << 1) & 0x7F0000) | (addr & 0x7FFF) | 0x8000;

      if ((addr & 0xF00000) == 0x700000) 
      {
        addr |= 0x800000;
      } 
    }
    else 
    {
      if (addr < 0 || addr > 0xFFFFFF ||(addr & 0xFE0000) == 0x7E0000 || (addr & 0x408000) == 0x000000) 
      {
        return -1;
      } 

      addr = ((addr & 0x7F0000) >> 1|(addr & 0x7FFF));

      if (header) 
      {
        addr = 512;
      }
    }

    return addr;
  }
}