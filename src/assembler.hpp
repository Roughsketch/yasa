#ifndef ASSEMBLER_H
#define ASSEMBLER_H

#include <map>
#include <string>
#include <iostream>
#include <vector>

#include "instruction.hpp"
#include "integer.hpp"
#include "util.hpp"

namespace yasa
{
  namespace detail
  {
    // struct opcode_info
    // {
    //   uint8_t opcode;
    //   uint8_t size;
    //   uint8_t min_size;
    // };

    // class Opcode
    // {
    // public:
    //   Opcode(std::string &name);

    //   Opcode &add(AddressMode mode, opcode_info info);
    // private:
    //   std::string m_name;
    //   std::map<AddressMode, opcode_info> m_info;
    // };


    struct opcode
    {
      uint8_t opcode;
      uint8_t size;
    };

    extern std::map<std::string, std::map<AddressMode, std::map<int, int>>> ByteTable;
  }

  uint8_t get_byte(std::string instr, AddressMode &mode, int size, bool &success);
}

#endif
