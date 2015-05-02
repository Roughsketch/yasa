#include "assembler.hpp"

namespace yasa
{
  namespace detail 
  {
    std::map<std::string, std::map<AddressMode, opcode>> ByteTable = {
      {"ADC", {{Indirect_X, {0x61, 2}}, {Stack, {0x63, 2}}, {Direct, {0x65, 2}}, {Indirect_Long, {0x67, 22}},
               {Immediate, {0x69, 2}}, {Absolute, {0x6D, 3}}, {Absolute_Long, {0x6F, 4}}, {Indirect_Y, {0x71, 2}},
               {Indirect, {0x72, 2}}, {Stack_Y, {0x73, 22}}, {Direct_X, {0x75, 2}}, {Indirect_Long_Y, {0x77, 2}},
               {Absolute_Y, {0x79, 3}}, {Absolute_X, {0x7D, 3}}, {Absolute_Long_X, {0x7F, 4}}}},
      {"AND", {{Indirect_X, {0x21, 2}}, {Stack, {0x23, 2}}, {Direct, {0x25, 2}}, {Indirect_Long, {0x27, 2}},
               {Immediate, {0x29, 2}}, {Absolute, {0x2D, 3}}, {Absolute_Long, {0x2F, 4}}, {Indirect_Y, {0x31, 2}},
               {Indirect, {0x32, 2}}, {Stack_Y, {0x33, 2}}, {Direct_X, {0x35, 2}}, {Indirect_Long_Y, {0x37, 2}}, 
               {Absolute_Y, {0x39, 3}}, {Absolute_X, {0x3D, 3}}, {Absolute_Long_X, {0x3F, 4}}}},
      {"ASL", {{Direct, {0x06, 2}}, {Accumulator, {0x0A, 1}}, {Absolute, {0x0E, 3}}, {Direct_X, {0x16, 2}}, {Absolute_X, {0x1E, 3}}}},
      {"BCC", {{Label, {0x90, 2}}}}, // Near
      {"BCS", {{Label, {0xB0, 2}}}}, // Near
      {"BEQ", {{Label, {0xF0, 2}}}}, // Near
      {"BIT", {{Direct, {0x24, 2}}, {Absolute, {0x2C, 3}}, {Direct_X, {0x34, 2}}, {Absolute_X, {0x3C, 3}}, {Immediate, {0x89, 2}}}},
      {"BMI", {{Label, {0x30, 2}}}}, // Near
      {"BNE", {{Label, {0xD0, 2}}}}, // Near
      {"BPL", {{Label, {0x10, 2}}}}, // Near
      {"BRA", {{Label, {0x80, 2}}}}, // Near
      {"BRK", {{Implied, {0x00, 2}}, {Immediate, {0x00, 2}}}},
      {"BRL", {{Label, {0x82, 3}}}},
      {"BVC", {{Label, {0x50, 2}}}}, // Near
      {"BVS", {{Label, {0x70, 2}}}}, // Near
      {"CLC", {{Implied, {0x18, 1}}}},
      {"CLD", {{Implied, {0xD8, 1}}}},
      {"CLI", {{Implied, {0x58, 1}}}},
      {"CLV", {{Implied, {0xB8, 1}}}},
      {"CMP", {{Indirect_X, {0xC1, 2}}, {Stack, {0xC3, 2}}, {Direct, {0xC5, 2}}, {Indirect_Long, {0xC7, 2}},
               {Immediate, {0xC9, 2}}, {Absolute, {0xCD, 3}}, {Absolute_Long, {0xCF, 4}}, {Indirect_Y, {0xD1, 2}}, 
               {Indirect, {0xD2, 2}}, {Stack_Y, {0xD3, 2}}, {Direct_X, {0xD5, 23}}, {Indirect_Long_Y, {0xD7, 2}}, {Absolute_Y, {0xD9, 3}}, 
               {Absolute_X, {0xDD, 3}}, {Absolute_Long_X, {0xDF, 4}}}},
      {"COP", {{Implied, {0x02, 2}}, {Immediate, {0x02, 2}}}},
      {"CPX", {{Immediate, {0xE0, 2}}, {Direct, {0xE4, 2}}, {Absolute, {0xEC, 3}}}},
      {"CPY", {{Immediate, {0xC0, 2}}, {Direct, {0xC4, 2}}, {Absolute, {0xCC, 3}}}},
      {"DEC", {{Accumulator, {0x3A, 1}}, {Direct, {0xC6, 2}}, {Absolute, {0xCE, 3}}, {Direct_X, {0xD6, 2}}, {Absolute_X, {0xDE, 3}}}},
      {"DEX", {{Implied, {0xCA, 1}}}},
      {"DEY", {{Implied, {0x88, 1}}}},
      {"EOR", {{Indirect_X, {0x41, 2}}, {Stack, {0x43, 2}}, {Direct, {0x45, 2}}, {Indirect_Long, {0x47, 2}}, 
               {Immediate, {0x49, 2}}, {Absolute, {0x4D, 3}}, {Absolute_Long, {0x4F, 4}}, {Indirect_Y, {0x51, 2}}, 
               {Indirect, {0x52, 2}}, {Stack_Y, {0x53, 2}}, {Direct_X, {0x55, 2}}, {Indirect_Long_Y, {0x57, 2}}, 
               {Absolute_Y, {0x59, 3}}, {Absolute_X, {0x5D, 3}}, {Absolute_Long_X, {0x5F, 4}}}},
      {"INC", {{Accumulator, {0x1A, 1}}, {Direct, {0xE6, 2}}, {Absolute, {0xEE, 3}}, {Direct_X, {0xF6, 2}}, {Absolute_X, {0xFE, 3}}}},
      {"INX", {{Implied, {0xE8, 1}}}},
      {"INY", {{Implied, {0xC8, 1}}}},
      {"JMP", {{Absolute, {0x4C, 3}}, {Absolute_Long, {0x5C, 4}}, {Absolute_Indirect, {0x6C, 3}}, {Absolute_Indirect_X, {0x7C, 3}}, {Absolute_Indirect_Long, {0xDC, 2}}}},
      {"JSR", {{Absolute, {0x20, 3}}, {Absolute_Long, {0x22, 4}}, {Absolute_Indirect_X, {0xFC, 3}}}},
      {"LDA", {{Indirect_X, {0xA1, 2}}, {Stack, {0xA3, 2}}, {Direct, {0xA5, 2}}, {Indirect_Long, {0xA7, 2}},
               {Immediate, {0xA9, 2}}, {Absolute, {0xAD, 3}}, {Absolute_Long, {0xAF, 4}}, {Indirect_Y, {0xB1, 2}},
               {Indirect, {0xB2, 2}}, {Stack_Y, {0xB3, 2}}, {Direct_X, {0xB5, 2}}, {Indirect_Long_Y, {0xB7, 2}},
               {Absolute_Y, {0xB9, 3}}, {Absolute_X, {0xBD, 3}}, {Absolute_Long_X, {0xBF, 4}}}},
      {"LDX", {{Immediate, {0xA2, 2}}, {Direct, {0xA6, 2}}, {Absolute, {0xAE, 3}}, {Direct_Y, {0xB6, 2}}, {Absolute_Y, {0xBE, 3}}}},
      {"LDY", {{Immediate, {0xA0, 2}}, {Direct, {0xA4, 2}}, {Absolute, {0xAC, 3}}, {Direct_X, {0xB4, 2}}, {Absolute_X, {0xBC, 3}}}},
      {"LSR", {{Direct, {0x46, 2}}, {Accumulator, {0x4A, 1}}, {Absolute, {0x4E, 3}}, {Direct_X, {0x56, 2}}, {Absolute_X, {0x5E, 3}}}},
      {"MVN", {{Block, {0x54, 3}}}},
      {"MVP", {{Block, {0x44, 3}}}},
      {"NOP", {{Implied, {0xEA, 1}}}},
      {"ORA", {{Indirect_X, {0x01, 2}}, {Stack, {0x03, 2}}, {Direct, {0x05, 2}}, {Indirect_Long, {0x07, 2}},
               {Immediate, {0x09, 2}}, {Absolute, {0x0D, 3}}, {Absolute_Long, {0x0F, 4}}, {Indirect_Y, {0x11, 2}}, 
               {Indirect, {0x12, 2}}, {Stack_Y, {0x13, 2}}, {Direct_X, {0x15, 2}}, {Indirect_Long_Y, {0x17, 2}}, 
               {Absolute_Y, {0x19, 3}}, {Absolute_X, {0x1D, 3}}, {Absolute_Long_X, {0x1F, 4}}}},
      {"PEA", {{Absolute, {0xF4, 3}}}},
      {"PEI", {{Indirect, {0xD4, 2}}}},
      {"PER", {{Label, {0x62, 3}}, {Absolute, {0x62, 3}}}},
      {"PHA", {{Implied, {0x48, 1}}}},
      {"PHB", {{Implied, {0x8B, 1}}}},
      {"PHD", {{Implied, {0x0B, 1}}}},
      {"PHK", {{Implied, {0x4B, 1}}}},
      {"PHP", {{Implied, {0x08, 1}}}},
      {"PHX", {{Implied, {0xDA, 1}}}},
      {"PHY", {{Implied, {0x5A, 1}}}},
      {"PLA", {{Implied, {0x68, 1}}}},
      {"PLB", {{Implied, {0xAB, 1}}}},
      {"PLD", {{Implied, {0x2B, 1}}}},
      {"PLP", {{Implied, {0x28, 1}}}},
      {"PLX", {{Implied, {0xFA, 1}}}},
      {"PLY", {{Implied, {0x7A, 1}}}},
      {"REP", {{Immediate, {0xC2, 2}}}},
      {"ROL", {{Direct, {0x26, 2}}, {Accumulator, {0x2A, 1}}, {Absolute, {0x2E, 3}}, {Direct_X, {0x36, 2}}, {Absolute_X, {0x3E, 3}}}},
      {"ROR", {{Direct, {0x66, 2}}, {Accumulator, {0x6A, 1}}, {Absolute, {0x6E, 3}}, {Direct_X, {0x76, 2}}, {Absolute_X, {0x7E, 3}}}},
      {"RTI", {{Implied, {0x40, 1}}}},
      {"RTL", {{Implied, {0x6B, 1}}}},
      {"RTS", {{Implied, {0x60, 1}}}},
      {"SBC", {{Indirect_X, {0xE1, 2}}, {Stack, {0xE3, 2}}, {Direct, {0xE5, 2}}, {Indirect_Long, {0xE7, 2}},
               {Immediate, {0xE9, 2}}, {Absolute, {0xED, 3}}, {Absolute_Long, {0xEF, 4}}, {Indirect_Y, {0xF1, 2}}, 
               {Indirect, {0xF2, 2}}, {Stack_Y, {0xF3, 2}}, {Direct_X, {0xF5, 2}}, {Indirect_Long_Y, {0xF7, 2}}, 
               {Absolute_Y, {0xF9, 3}}, {Absolute_X, {0xFD, 3}}, {Absolute_Long_X, {0xFF, 4}}}},
      {"SEC", {{Implied, {0x38, 1}}}},
      {"SED", {{Implied, {0xF8, 1}}}},
      {"SEI", {{Implied, {0x78, 1}}}},
      {"SEP", {{Implied, {0xE2, 1}}, {Immediate, {0xE2, 2}}}},
      {"STA", {{Indirect_X, {0x81, 2}}, {Stack, {0x83, 2}}, {Direct, {0x85, 2}}, {Indirect_Long, {0x87, 2}},
               {Absolute, {0x8D, 3}}, {Absolute_Long, {0x8F, 4}}, {Indirect_Y, {0x91, 2}}, {Indirect, {0x92, 2}},
               {Stack_Y, {0x93, 2}}, {Direct_X, {0x95, 2}}, {Indirect_Long_Y, {0x97, 2}}, {Absolute_Y, {0x99, 3}},
               {Absolute_X, {0x9D, 3}}, {Absolute_Long_X, {0x9F, 4}}}},
      {"STP", {{Implied, {0xDB, 1}}}},
      {"STX", {{Direct, {0x86, 2}}, {Absolute, {0x8E, 3}}, {Direct_Y, {0x96, 2}}}},
      {"STY", {{Direct, {0x84, 2}}, {Absolute, {0x8C, 3}}, {Direct_X, {0x94, 2}}}},
      {"STZ", {{Direct, {0x64, 2}}, {Direct_X, {0x74, 2}}, {Absolute, {0x9C, 3}}, {Absolute_X, {0x9E, 3}}}},
      {"TAX", {{Implied, {0xAA, 1}}}},
      {"TAY", {{Implied, {0xA8, 1}}}},
      {"TCD", {{Implied, {0x5B, 1}}}},
      {"TCS", {{Implied, {0x1B, 1}}}},
      {"TDC", {{Implied, {0x7B, 1}}}},
      {"TRB", {{Direct, {0x14, 2}}, {Absolute, {0x1C, 3}}}},
      {"TSB", {{Direct, {0x04, 2}}, {Absolute, {0x0C, 3}}}},
      {"TSC", {{Implied, {0x3B, 1}}}},
      {"TSX", {{Implied, {0xBA, 1}}}},
      {"TXA", {{Implied, {0x8A, 1}}}},
      {"TXS", {{Implied, {0x9A, 1}}}},
      {"TXY", {{Implied, {0x9B, 1}}}},
      {"TYA", {{Implied, {0x98, 1}}}},
      {"TYX", {{Implied, {0xBB, 1}}}},
      {"WAI", {{Implied, {0xCB, 1}}}},
      {"WDM", {{Implied, {0x42, 2}}, {Immediate, {0x42, 2}}}},
      {"XBA", {{Implied, {0xEB, 1}}}},
      {"XCE", {{Implied, {0xFB, 1}}}}
    };
  }

  bool has_byte(std::string instr, AddressMode mode)
  {
    return (detail::ByteTable[instr].count(mode) == 1);
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

    uint8_t op = 0;

    success = has_byte(instr, mode);

    if (success)
    {
      op = detail::ByteTable[instr].at(mode).opcode; 
    }
    else
    {
      //  If Direct, promote to Absolute or Absolute_Long ($xx -> $xxxx | $xxxxxx)
      if (!success && mode == Direct)
      {
        if (has_byte(instr, Absolute))
        {
          success = true;
          mode = Absolute;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
        else if (has_byte(instr, Absolute_Long))
        {
          success = true;
          mode = Absolute_Long;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
      }
      //  If Absolute, promote to Absolute_Long ($xxxx -> $xxxxxx)
      else if (!success && mode == Absolute)
      {
        if (has_byte(instr, Absolute_Long))
        {
          success = true;
          mode = Absolute_Long;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
      }
      //  If Direct_X, promote to Absolute_X or Absolute_Long_X ($xx, x -> $xxxx, x | $xxxxxx, x)
      else if (!success && mode == Direct_X)
      {
        if (has_byte(instr, Absolute_X))
        {
          success = true;
          mode = Absolute_X;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
        else if (has_byte(instr, Absolute_Long_X))
        {
          success = true;
          mode = Absolute_Long_X;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
      }
      //  If Absolute_X, promote to Absolute_Long_X ($xxxx, x -> $xxxxxx, x)
      else if (!success && mode == Absolute_X)
      {
        if (has_byte(instr, Absolute_Long_X))
        {
          success = true;
          mode = Absolute_Long_X;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
      }
      //  If Indirect, promote to Absolute_Indirect (JMP ($xx) -> JMP ($xxxx))
      else if (!success && mode == Indirect)
      {
        if (has_byte(instr, Absolute_Indirect))
        {
          success = true;
          mode = Absolute_Indirect;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
      }
      //  If Indirect_X, promote to Absolute_Indirect_X (JMP ($xx, x) -> JMP ($xxxx, x))
      else if (!success && mode == Indirect_X)
      {
        if (has_byte(instr, Absolute_Indirect_X))
        {
          success = true;
          mode = Absolute_Indirect_X;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
      }
      //  If Indirect_Long, promote to Absolute_Indirect_Long ([$xx] -> [$xxxxxx])
      else if (!success && mode == Indirect_Long)
      {
        if (has_byte(instr, Absolute_Indirect_Long))
        {
          success = true;
          mode = Absolute_Indirect_Long;
          op = detail::ByteTable[instr].at(mode).opcode;
        }
      }
    }

    return op;
  }

  uint8_t get_size(std::string instr, AddressMode mode)
  {
    return detail::ByteTable[instr][mode].size - 1;
  }
}