#include "assembler.hpp"

namespace yasa
{
  namespace detail 
  {
    //  Todo: Make this not a massive cluster of embedded maps
    std::map<std::string, std::map<AddressMode, std::map<int, int>>> ByteTable = {
      {"ADC", {{Indirect_X, {{2, 0x61}}},
               {Stack, {{2, 0x63}}},
               {Direct, {{2, 0x65}, {3, 0x6D}, {4, 0x6F}}},
               {Indirect_Long, {{2, 0x67}}},
               {Immediate, {{2, 0x69}, {3, 0x69}}},
               {Indirect_Y, {{2, 0x71}}},
               {Indirect, {{2, 0x72}}},
               {Stack_Y, {{2, 0x73}}},
               {Indexed_X, {{2, 0x75}, {3, 0x7D}, {4, 0x7F}}},
               {Indirect_Long_Y, {{2, 0x77}}},
               {Indexed_Y, {{3, 0x79}}}}},
      {"AND", {{Indirect_X, {{2, 0x21}}},
               {Stack, {{2, 0x23}}},
               {Direct, {{2, 0x25}, {3, 0x2D}, {4, 0x2F}}},
               {Indirect_Long, {{2, 0x27}}},
               {Immediate, {{2, 0x29}, {3, 0x29}}},
               {Indirect_Y, {{2, 0x31}}},
               {Indirect, {{2, 0x32}}},
               {Stack_Y, {{2, 0x33}}},
               {Indexed_X, {{2, 0x35}, {3, 0x3D}, {4, 0x3F}}},
               {Indirect_Long_Y, {{2, 0x37}}},
               {Indexed_Y, {{3, 0x39}}}}},
      {"ASL", {{Direct, {{2, 0x06}, {3, 0x0E}}},
               {Implied, {{1, 0x0A}}},
               {Indexed_X, {{2, 0x16}, {3, 0x1E}}}}},
      {"BCC", {{Label, {{2, 0x90}}}}},
      {"BCS", {{Label, {{2, 0xB0}}}}},
      {"BEQ", {{Label, {{2, 0xF0}}}}},
      {"BIT", {{Direct, {{2, 0x24}, {3, 0x2C}}},
               {Indexed_X, {{2, 0x34}, {3, 0x3C}}},
               {Immediate, {{2, 0x89}, {3, 0x89}}}}},
      {"BMI", {{Label, {{2, 0x30}}}}},
      {"BNE", {{Label, {{2, 0xD0}}}}},
      {"BPL", {{Label, {{2, 0x10}}}}},
      {"BRA", {{Label, {{2, 0x80}}}}},
      {"BRK", {{Implied, {{2, 0x00}}}, {Immediate, {{2, 0x00}}}}},
      {"BRL", {{Label, {{3, 0x82}}}}},
      {"BVC", {{Label, {{2, 0x50}}}}},
      {"BVS", {{Label, {{2, 0x70}}}}},
      {"CLC", {{Implied, {{1, 0x18}}}}},
      {"CLD", {{Implied, {{1, 0xD8}}}}},
      {"CLI", {{Implied, {{1, 0x58}}}}},
      {"CLV", {{Implied, {{1, 0xB8}}}}},
      {"CMP", {{Indirect_X, {{2, 0xC1}}},
               {Stack, {{2, 0xC3}}},
               {Direct, {{2, 0xC5}, {3, 0xCD}, {4, 0xCF}}},
               {Indirect_Long, {{2, 0xC7}}},
               {Immediate, {{2, 0xC9}, {3, 0xC9}}},
               {Indirect_Y, {{2, 0xD1}}},
               {Indirect, {{2, 0xD2}}},
               {Stack_Y, {{2, 0xD3}}},
               {Indexed_X, {{2, 0xD5}, {3, 0xDD}, {4, 0xDF}}},
               {Indirect_Long_Y, {{2, 0xD7}}},
               {Indexed_Y, {{3, 0xD9}}}}},
      {"COP", {{Implied, {{2, 0x02}}}, {Immediate, {{2, 0x02}}}}},
      {"CPX", {{Immediate, {{2, 0xE0}, {3, 0xE0}}},
               {Direct, {{2, 0xE4}, {3, 0xEC}}}}},
      {"CPY", {{Immediate, {{2, 0xC0}, {3, 0xC0}}},
               {Direct, {{2, 0xC4}, {3, 0xCC}}}}},
      {"DEC", {{Implied, {{1, 0x3A}}},
               {Direct, {{2, 0xC6}, {3, 0xCE}}},
               {Indexed_X, {{2, 0xD6}, {3, 0xDE}}}}},
      {"DEX", {{Implied, {{1, 0xCA}}}}},
      {"DEY", {{Implied, {{1, 0x88}}}}},
      {"EOR", {{Indirect_X, {{2, 0x41}}},
               {Stack, {{2, 0x43}}},
               {Direct, {{2, 0x45}, {3, 0x4D}, {4, 0x4F}}},
               {Indirect_Long, {{2, 0x47}}},
               {Immediate, {{2, 0x49}, {3, 0x49}}},
               {Indirect_Y, {{2, 0x51}}},
               {Indirect, {{2, 0x52}}},
               {Stack_Y, {{2, 0x53}}},
               {Indexed_X, {{2, 0x55}, {3, 0x5D}, {4, 0x5F}}},
               {Indirect_Long_Y, {{2, 0x57}}},
               {Indexed_Y, {{3, 0x59}}}}},
      {"INC", {{Implied, {{1, 0x1A}}},
               {Direct, {{2, 0xE6}, {3, 0xEE}}},
               {Indexed_X, {{2, 0xF6}, {3, 0xFE}}}}},
      {"INX", {{Implied, {{1, 0xE8}}}}},
      {"INY", {{Implied, {{1, 0xC8}}}}},
      {"JMP", {{Direct, {{3, 0x4C}, {4, 0x5C}}},
               {Indirect, {{3, 0x6C}}},
               {Indirect_X, {{3, 0x7C}}},
               {Indirect_Long, {{3, 0xDC}}}}},
      {"JML", {{Direct, {{4, 0x5C}}}, {Indirect_Long, {{3, 0xDC}}}}},
      {"JSR", {{Direct, {{3, 0x20}, {4, 0x22}}},
               {Indirect_X, {{3, 0xFC}}}}},
      {"JSL", {{Direct, {{4, 0x22}}}}},
      {"LDA", {{Indirect_X, {{2, 0xA1}}},
               {Stack, {{2, 0xA3}}},
               {Direct, {{2, 0xA5}, {3, 0xAD}, {4, 0xAF}}},
               {Indirect_Long, {{2, 0xA7}}},
               {Immediate, {{2, 0xA9}, {3, 0xA9}}},
               {Indirect_Y, {{2, 0xB1}}},
               {Indirect, {{2, 0xB2}}},
               {Stack_Y, {{2, 0xB3}}},
               {Indexed_X, {{2, 0xB5}, {3, 0xBD}, {4, 0xBF}}},
               {Indirect_Long_Y, {{2, 0xB7}}},
               {Indexed_Y, {{3, 0xB9}}}}},
      {"LDX", {{Immediate, {{2, 0xA2}, {3, 0xA2}}},
               {Direct, {{2, 0xA6}, {3, 0xAE}}},
               {Indexed_Y, {{2, 0xB6}, {3, 0xBE}}}}},
      {"LDY", {{Immediate, {{2, 0xA0}, {3, 0xA0}}},
               {Direct, {{2, 0xA4}, {3, 0xAC}}},
               {Indexed_X, {{2, 0xB4}, {3, 0xBC}}}}},
      {"LSR", {{Direct, {{2, 0x46}, {3, 0x4E}}},
               {Implied, {{1, 0x4A}}},
               {Indexed_X, {{2, 0x56}, {3, 0x5E}}}}},
      {"MVN", {{Block, {{3, 0x54}}}}},
      {"MVP", {{Block, {{3, 0x44}}}}},
      {"NOP", {{Implied, {{1, 0xEA}}}}},
      {"ORA", {{Indirect_X, {{2, 0x01}}},
               {Stack, {{2, 0x03}}},
               {Direct, {{2, 0x05}, {3, 0x0D}, {4, 0x0F}}},
               {Indirect_Long, {{2, 0x07}}},
               {Immediate, {{2, 0x09}, {3, 0x09}}},
               {Indirect_Y, {{2, 0x11}}},
               {Indirect, {{2, 0x12}}},
               {Stack_Y, {{2, 0x13}}},
               {Indexed_X, {{2, 0x15}, {3, 0x1D}, {4, 0x1F}}},
               {Indirect_Long_Y, {{2, 0x17}}},
               {Indexed_Y, {{3, 0x19}}}}},
      {"PEA", {{Direct, {{3, 0xF4}}}}},
      {"PEI", {{Indirect, {{2, 0xD4}}}}},
      {"PER", {{Label, {{3, 0x62}}}}},
      {"PHA", {{Implied, {{1, 0x48}}}}},
      {"PHB", {{Implied, {{1, 0x8B}}}}},
      {"PHD", {{Implied, {{1, 0x0B}}}}},
      {"PHK", {{Implied, {{1, 0x4B}}}}},
      {"PHP", {{Implied, {{1, 0x08}}}}},
      {"PHX", {{Implied, {{1, 0xDA}}}}},
      {"PHY", {{Implied, {{1, 0x5A}}}}},
      {"PLA", {{Implied, {{1, 0x68}}}}},
      {"PLB", {{Implied, {{1, 0xAB}}}}},
      {"PLD", {{Implied, {{1, 0x2B}}}}},
      {"PLP", {{Implied, {{1, 0x28}}}}},
      {"PLX", {{Implied, {{1, 0xFA}}}}},
      {"PLY", {{Implied, {{1, 0x7A}}}}},
      {"REP", {{Immediate, {{2, 0xC2}}}}},
      {"ROL", {{Direct, {{2, 0x26}, {3, 0x2E}}},
               {Implied, {{1, 0x2A}}},
               {Indexed_X, {{2, 0x36}, {3, 0x3E}}}}},
      {"ROR", {{Direct, {{2, 0x66}, {3, 0x6E}}},
               {Implied, {{1, 0x6A}}},
               {Indexed_X, {{2, 0x76}, {3, 0x7E}}}}},
      {"RTI", {{Implied, {{1, 0x40}}}}},
      {"RTL", {{Implied, {{1, 0x6B}}}}},
      {"RTS", {{Implied, {{1, 0x60}}}}},
      {"SBC", {{Indirect_X, {{2, 0xE1}}},
               {Stack, {{2, 0xE3}}},
               {Direct, {{2, 0xE5}, {3, 0xED}, {4, 0xEF}}},
               {Indirect_Long, {{2, 0xE7}}},
               {Immediate, {{2, 0xE9}, {3, 0xE9}}},
               {Indirect_Y, {{2, 0xF1}}},
               {Indirect, {{2, 0xF2}}},
               {Stack_Y, {{2, 0xF3}}},
               {Indexed_X, {{2, 0xF5}, {3, 0xFD}, {4, 0xFF}}},
               {Indirect_Long_Y, {{2, 0xF7}}},
               {Indexed_Y, {{3, 0xF9}}}}},
      {"SEC", {{Implied, {{1, 0x38}}}}},
      {"SED", {{Implied, {{1, 0xF8}}}}},
      {"SEI", {{Implied, {{1, 0x78}}}}},
      {"SEP", {{Immediate, {{2, 0xE2}}}}},
      {"STA", {{Indirect_X, {{2, 0x81}}},
               {Stack, {{2, 0x83}}},
               {Direct, {{2, 0x85}, {3, 0x8D}, {4, 0x8F}}},
               {Indirect_Long, {{2, 0x87}}},
               {Indirect_Y, {{2, 0x91}}},
               {Indirect, {{2, 0x92}}},
               {Stack_Y, {{2, 0x93}}},
               {Indexed_X, {{2, 0x95}, {3, 0x9D}, {4, 0x9F}}},
               {Indirect_Long_Y, {{2, 0x97}}},
               {Indexed_Y, {{3, 0x99}}}}},
      {"STP", {{Implied, {{1, 0xDB}}}}},
      {"STX", {{Direct, {{2, 0x86}, {3, 0x8E}}},
               {Indexed_Y, {{2, 0x96}}}}},
      {"STY", {{Direct, {{2, 0x84}, {3, 0x8C}}},
               {Indexed_X, {{2, 0x94}}}}},
      {"STZ", {{Direct, {{2, 0x64}, {3, 0x9C}}},
               {Indexed_X, {{2, 0x74}, {3, 0x9E}}}}},
      {"TAX", {{Implied, {{1, 0xAA}}}}},
      {"TAY", {{Implied, {{1, 0xA8}}}}},
      {"TCD", {{Implied, {{1, 0x5B}}}}},
      {"TCS", {{Implied, {{1, 0x1B}}}}},
      {"TDC", {{Implied, {{1, 0x7B}}}}},
      {"TRB", {{Direct, {{2, 0x14}, {3, 0x1C}}}}},
      {"TSB", {{Direct, {{2, 0x04}, {3, 0x0C}}}}},
      {"TSC", {{Implied, {{1, 0x3B}}}}},
      {"TSX", {{Implied, {{1, 0xBA}}}}},
      {"TXA", {{Implied, {{1, 0x8A}}}}},
      {"TXS", {{Implied, {{1, 0x9A}}}}},
      {"TXY", {{Implied, {{1, 0x9B}}}}},
      {"TYA", {{Implied, {{1, 0x98}}}}},
      {"TYX", {{Implied, {{1, 0xBB}}}}},
      {"WAI", {{Implied, {{1, 0xCB}}}}},
      {"WDM", {{Implied, {{2, 0x42}}}, {Immediate, {{2, 0x42}}}}},
      {"XBA", {{Implied, {{1, 0xEB}}}}},
      {"XCE", {{Implied, {{1, 0xFB}}}}}
    };
  }

  bool has_byte(std::string instr, AddressMode mode, int size)
  {
    return (detail::ByteTable[instr].count(mode) == 1) && (detail::ByteTable[instr][mode].count(size) == 1);
  }

  uint8_t get_byte(std::string instr, AddressMode &mode, int size)
  {
    if (has_byte(instr, mode, size))
    {
      return detail::ByteTable[instr][mode][size];
    }

    throw InvalidInstructionException("Invalid instruction: " + instr +
            " with size " + util::to_string(size) +
            " and mode " + AddressModeString[mode] +
            " does not exist.");
  }

  uint8_t get_avg_size(std::string instr, AddressMode& mode)
  {
    auto sizes = detail::ByteTable[instr][mode];
    int sum = 0;

    for (auto map : sizes)
    {
      sum += map.first; // Add size
    }

    if (sizes.size() == 0)
    {
      throw InvalidInstructionException("Invalid instruction: " + instr +
            " does not have any opcodes for mode " + AddressModeString[mode]);
    }

    return sum / sizes.size();
  }

  uint8_t get_opcode(std::string instr, AddressMode& mode, int size)
  {
    uint8_t opcode;

    if (instr == "ADC")
    {
      opcode = 0x60 + mode;

      if (mode == Direct  || mode == Indirect)
      {
        if (size == 2)
        {
          opcode += 0x08;
        }
        else if (size == 3)
        {
          opcode += 0x0A;
        }
      }
    }

    return opcode;
  }

  //  Returns true if the instruction with the given mode can only have one size
  bool has_set_size(std::string instr, AddressMode& mode)
  {
    auto sizes = detail::ByteTable[instr][mode];

    //  Return false if invalid instruction
    if (sizes.size() == 0)
    {
      return false;
    }

    //  Return true if there is only one size
    if (sizes.size() == 1)
    {
      return true;
    }
    else
    {
      int first = 0;

      //  Go through each size and if there is a difference, then return false
      for (auto& size : sizes)
      {
        if (first == 0)
        {
          first = size.first;
        }
        else if (first != size.first)
        {
          return false;
        }
      }
    }

    //  All sizes match, return true
    return true;
  }
}