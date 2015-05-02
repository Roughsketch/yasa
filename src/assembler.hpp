#ifndef ASSEMBLER_H
#define ASSEMBLER_H

#include <map>
#include <string>
#include <iostream>
#include <vector>

#include "instruction.hpp"
#include "integer.hpp"

namespace yasa
{
  namespace detail
  {
    extern std::map<std::string, std::map<AddressMode, uint8_t>> ByteTable;
  }

  uint8_t get_byte(std::string instr, AddressMode &mode, bool &success);
  uint8_t get_size(std::string instr, AddressMode mode);
}

#endif
