#include "assembler.hpp"

namespace yasa
{
  namespace detail 
  {
    std::map<std::string, std::map<AddressMode, uint8_t>> ByteTable = {
      {"ADC", {{Indirect_X, 0x61}, {Stack, 0x63}, {Direct, 0x65}, {Indirect_Long, 0x67},
               {Immediate, 0x69}, {Absolute, 0x6D}, {Absolute_Long, 0x6F}, {Indirect_Y, 0x71},
               {Indirect, 0x72}, {Stack_Y, 0x73}, {Direct_X, 0x75}, {Indirect_Long_Y, 0x77},
               {Absolute_Y, 0x79}, {Absolute_X, 0x7D}, {Absolute_Long_X, 0x7F}}},
      {"AND", {{Indirect_X, 0x21}, {Stack, 0x23}, {Direct, 0x25}, {Indirect_Long, 0x27},
               {Immediate, 0x29}, {Absolute, 0x2D}, {Absolute_Long, 0x2F}, {Indirect_Y, 0x31},
               {Indirect, 0x32}, {Stack_Y, 0x33}, {Direct_X, 0x35}, {Indirect_Long_Y, 0x37}, 
               {Absolute_Y, 0x39}, {Absolute_X, 0x3D}, {Absolute_Long_X, 0x3F}}},
      {"ASL", {{Direct, 0x06}, {Accumulator, 0x0A}, {Absolute, 0x0E}, {Direct_X, 0x16}, {Absolute_X, 0x1E}}},
      {"BCC", {{Label, 0x90}}}, // Near
      {"BCS", {{Label, 0xB0}}}, // Near
      {"BEQ", {{Label, 0xF0}}}, // Near
      {"BIT", {{Direct, 0x24}, {Absolute, 0x2C}, {Direct_X, 0x34}, {Absolute_X, 0x3C}, {Immediate, 0x89}}},
      {"BMI", {{Label, 0x30}}}, // Near
      {"BNE", {{Label, 0xD0}}}, // Near
      {"BPL", {{Label, 0x10}}}, // Near
      {"BRA", {{Label, 0x80}}}, // Near
      {"BRK", {{Implied, 0x00}, {Immediate, 0x00}}},
      {"BRL", {{Label, 0x82}}},
      {"BVC", {{Label, 0x50}}}, // Near
      {"BVS", {{Label, 0x70}}}, // Near
      {"CLC", {{Implied, 0x18}}},
      {"CLD", {{Implied, 0xD8}}},
      {"CLI", {{Implied, 0x58}}},
      {"CLV", {{Implied, 0xB8}}},
      {"CMP", {{Indirect_X, 0xC1}, {Stack, 0xC3}, {Direct, 0xC5}, {Indirect_Long, 0xC7},
               {Immediate, 0xC9}, {Absolute, 0xCD}, {Absolute_Long, 0xCF}, {Indirect_Y, 0xD1}, 
               {Indirect, 0xD2}, {Stack_Y, 0xD3}, {Direct_X, 0xD5}, {Indirect_Long_Y, 0xD7}, {Absolute_Y, 0xD9}, 
               {Absolute_X, 0xDD}, {Absolute_Long_X, 0xDF}}},
      {"COP", {{Implied, 0x02}, {Immediate, 0x02}}},
      {"CPX", {{Immediate, 0xE0}, {Direct, 0xE4}, {Absolute, 0xEC}}},
      {"CPY", {{Immediate, 0xC0}, {Direct, 0xC4}, {Absolute, 0xCC}}},
      {"DEC", {{Accumulator, 0x3A}, {Direct, 0xC6}, {Absolute, 0xCE}, {Direct_X, 0xD6}, {Absolute_X, 0xDE}}},
      {"DEX", {{Implied, 0xCA}}},
      {"DEY", {{Implied, 0x88}}},
      {"EOR", {{Indirect_X, 0x41}, {Stack, 0x43}, {Direct, 0x45}, {Indirect_Long, 0x47}, 
               {Immediate, 0x49}, {Absolute, 0x4D}, {Absolute_Long, 0x4F}, {Indirect_Y, 0x51}, 
               {Indirect, 0x52}, {Stack_Y, 0x53}, {Direct_X, 0x55}, {Indirect_Long_Y, 0x57}, 
               {Absolute_Y, 0x59}, {Absolute_X, 0x5D}, {Absolute_Long_X, 0x5F}}},
      {"INC", {{Accumulator, 0x1A}, {Direct, 0xE6}, {Absolute, 0xEE}, {Direct_X, 0xF6}, {Absolute_X, 0xFE}}},
      {"INX", {{Implied, 0xE8}}},
      {"INY", {{Implied, 0xC8}}},
      {"JMP", {{Absolute, 0x4C}, {Absolute_Long, 0x5C}, {Absolute_Indirect, 0x6C}, {Absolute_Indirect_X, 0x7C}, {Absolute_Indirect_Long, 0xDC}}},
      {"JSR", {{Absolute, 0x20}, {Absolute_Long, 0x22}, {Absolute_Indirect_X, 0xFC}}},
      {"LDA", {{Indirect_X, 0xA1}, {Stack, 0xA3}, {Direct, 0xA5}, {Indirect_Long, 0xA7},
               {Immediate, 0xA9}, {Absolute, 0xAD}, {Absolute_Long, 0xAF}, {Indirect_Y, 0xB1},
               {Indirect, 0xB2}, {Stack_Y, 0xB3}, {Direct_X, 0xB5}, {Indirect_Long_Y, 0xB7},
               {Absolute_Y, 0xB9}, {Absolute_X, 0xBD}, {Absolute_Long_X, 0xBF}}},
      {"LDX", {{Immediate, 0xA2}, {Direct, 0xA6}, {Absolute, 0xAE}, {Direct_Y, 0xB6}, {Absolute_Y, 0xBE}}},
      {"LDY", {{Immediate, 0xA0}, {Direct, 0xA4}, {Absolute, 0xAC}, {Direct_X, 0xB4}, {Absolute_X, 0xBC}}},
      {"LSR", {{Direct, 0x46}, {Accumulator, 0x4A}, {Absolute, 0x4E}, {Direct_X, 0x56}, {Absolute_X, 0x5E}}},
      {"MVN", {{Block, 0x54}}},
      {"MVP", {{Block, 0x44}}},
      {"NOP", {{Implied, 0xEA}}},
      {"ORA", {{Indirect_X, 0x01}, {Stack, 0x03}, {Direct, 0x05}, {Indirect_Long, 0x07},
               {Immediate, 0x09}, {Absolute, 0x0D}, {Absolute_Long, 0x0F}, {Indirect_Y, 0x11}, 
               {Indirect, 0x12}, {Stack_Y, 0x13}, {Direct_X, 0x15}, {Indirect_Long_Y, 0x17}, 
               {Absolute_Y, 0x19}, {Absolute_X, 0x1D}, {Absolute_Long_X, 0x1F}}},
      {"PEA", {{Absolute, 0xF4}}},
      {"PEI", {{Indirect, 0xD4}}},
      {"PER", {{Label, 0x62}, {Absolute, 0x62}}},
      {"PHA", {{Implied, 0x48}}},
      {"PHB", {{Implied, 0x8B}}},
      {"PHD", {{Implied, 0x0B}}},
      {"PHK", {{Implied, 0x4B}}},
      {"PHP", {{Implied, 0x08}}},
      {"PHX", {{Implied, 0xDA}}},
      {"PHY", {{Implied, 0x5A}}},
      {"PLA", {{Implied, 0x68}}},
      {"PLB", {{Implied, 0xAB}}},
      {"PLD", {{Implied, 0x2B}}},
      {"PLP", {{Implied, 0x28}}},
      {"PLX", {{Implied, 0xFA}}},
      {"PLY", {{Implied, 0x7A}}},
      {"REP", {{Immediate, 0xC2}}},
      {"ROL", {{Direct, 0x26}, {Accumulator, 0x2A}, {Absolute, 0x2E}, {Direct_X, 0x36}, {Absolute_X, 0x3E}}},
      {"ROR", {{Direct, 0x66}, {Accumulator, 0x6A}, {Absolute, 0x6E}, {Direct_X, 0x76}, {Absolute_X, 0x7E}}},
      {"RTI", {{Implied, 0x40}}},
      {"RTL", {{Implied, 0x6B}}},
      {"RTS", {{Implied, 0x60}}},
      {"SBC", {{Indirect_X, 0xE1}, {Stack, 0xE3}, {Direct, 0xE5}, {Indirect_Long, 0xE7},
               {Immediate, 0xE9}, {Absolute, 0xED}, {Absolute_Long, 0xEF}, {Indirect_Y, 0xF1}, 
               {Indirect, 0xF2}, {Stack_Y, 0xF3}, {Direct_X, 0xF5}, {Indirect_Long_Y, 0xF7}, 
               {Absolute_Y, 0xF9}, {Absolute_X, 0xFD}, {Absolute_Long_X, 0xFF}}},
      {"SEC", {{Implied, 0x38}}},
      {"SED", {{Implied, 0xF8}}},
      {"SEI", {{Implied, 0x78}}},
      {"SEP", {{Implied, 0xE2}, {Immediate, 0xE2}}},
      {"STA", {{Indirect_X, 0x81}, {Stack, 0x83}, {Direct, 0x85}, {Indirect_Long, 0x87},
               {Absolute, 0x8D}, {Absolute_Long, 0x8F}, {Indirect_Y, 0x91}, {Indirect, 0x92},
               {Stack_Y, 0x93}, {Direct_X, 0x95}, {Indirect_Long_Y, 0x97}, {Absolute_Y, 0x99},
               {Absolute_X, 0x9D}, {Absolute_Long_X, 0x9F}}},
      {"STP", {{Implied, 0xDB}}},
      {"STX", {{Direct, 0x86}, {Absolute, 0x8E}, {Direct_Y, 0x96}}},
      {"STY", {{Direct, 0x84}, {Absolute, 0x8C}, {Direct_X, 0x94}}},
      {"STZ", {{Direct, 0x64}, {Direct_X, 0x74}, {Absolute, 0x9C}, {Absolute_X, 0x9E}}},
      {"TAX", {{Implied, 0xAA}}},
      {"TAY", {{Implied, 0xA8}}},
      {"TCD", {{Implied, 0x5B}}},
      {"TCS", {{Implied, 0x1B}}},
      {"TDC", {{Implied, 0x7B}}},
      {"TRB", {{Direct, 0x14}, {Absolute, 0x1C}}},
      {"TSB", {{Direct, 0x04}, {Absolute, 0x0C}}},
      {"TSC", {{Implied, 0x3B}}},
      {"TSX", {{Implied, 0xBA}}},
      {"TXA", {{Implied, 0x8A}}},
      {"TXS", {{Implied, 0x9A}}},
      {"TXY", {{Implied, 0x9B}}},
      {"TYA", {{Implied, 0x98}}},
      {"TYX", {{Implied, 0xBB}}},
      {"WAI", {{Implied, 0xCB}}},
      {"WDM", {{Implied, 0x42}, {Immediate, 0x42}}},
      {"XBA", {{Implied, 0xEB}}},
      {"XCE", {{Implied, 0xFB}}}
    };
  }

  uint8_t get_byte(std::string instr, AddressMode &mode, bool &success)
  {
    static std::vector<std::string> modes = {
          "Invalid",
          "Implied",
          "Immediate_Mem",
          "Immediate_Index",
          "Immediate_8bit",
          "Immediate",
          "Label",
          "Relative",
          "Relative_Long",
          "Direct",
          "Direct_X",
          "Direct_Y",
          "Indirect",
          "Indirect_X",
          "Indirect_Y",
          "Indirect_Long",
          "Indirect_Long_Y",
          "Absolute",
          "Absolute_X",
          "Absolute_Y",
          "Absolute_Long",
          "Absolute_Long_X",
          "Stack",
          "Stack_Y",
          "Absolute_Indirect",
          "Absolute_Indirect_Long",
          "Absolute_Indirect_X",
          "Accumulator",
          "Block"
    };

    uint8_t op = detail::ByteTable[instr][mode];
    success = detail::ByteTable[instr].count(mode) > 0;

    //  If Direct, promote to Absolute ($xx -> $xxxx)
    if (!success && mode == Direct)
    {
      mode = Absolute;
      op = get_byte(instr, mode, success);
    }

    //  If Absolute, promote to Absolute_Long ($xxxx -> $xxxxxx)
    if (!success && mode == Absolute)
    {
      mode = Absolute_Long;
      op = get_byte(instr, mode, success);
    }



    //  If Direct_X, promote to Absolute_X ($xx, x -> $xxxx, x)
    if (!success && mode == Direct_X)
    {
      mode = Absolute_X;
      op = get_byte(instr, mode, success);
    }

    //  If Absolute_X, promote to Absolute_Long_X ($xxxx, x -> $xxxxxx, x)
    if (!success && mode == Absolute_X)
    {
      mode = Absolute_Long_X;
      op = get_byte(instr, mode, success);
    }



    //  If Indirect, promote to Absolute_Indirect (JMP ($xx) -> JMP ($xxxx))
    if (!success && mode == Indirect)
    {
      mode = Absolute_Indirect;
      op = get_byte(instr, mode, success);
    }



    //  If Indirect_X, promote to Absolute_Indirect_X (JMP ($xx, x) -> JMP ($xxxx, x))
    if (!success && mode == Indirect_X)
    {
      mode = Absolute_Indirect_X;
      op = get_byte(instr, mode, success);
    }



    //  If Indirect_Long, promote to Absolute_Indirect_Long ([$xx] -> [$xxxxxx])
    if (!success && mode == Indirect_Long)
    {
      mode = Absolute_Indirect_Long;
      op = get_byte(instr, mode, success);
    }



    return detail::ByteTable[instr][mode];
  }

  uint8_t get_size(std::string instr, AddressMode mode)
  {
    return 1;
  }
}