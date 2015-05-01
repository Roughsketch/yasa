#ifndef ASSEMBLER_H
#define ASSEMBLER_H

#include <map>
#include <string>
#include <iostream>
#include <cstdlib>
#include <vector>

namespace yasa
{
  enum AddressMode {
    Invalid,
    Implied = 1,
    Immediate_Mem,
    Immediate_Index,
    Immediate_8bit,
    Immediate,
    Label,
    Near_Label,
    Relative,
    Relative_Long,
    Direct,
    Direct_X,
    Direct_Y,
    Indirect,
    Indirect_X,
    Indirect_Y,
    Indirect_Long,
    Indirect_Long_Y,
    Absolute,
    Absolute_X,
    Absolute_Y,
    Absolute_Long,
    Absolute_Long_X,
    Stack,
    Stack_Y,
    Absolute_Indirect,
    Absolute_Indirect_Long,
    Absolute_Indirect_X,
    Accumulator,
    Block
  };

  namespace detail
  {
    extern std::map<std::string, std::map<AddressMode, uint8_t> > ByteTable;
  }

  uint8_t get_byte(std::string instr, AddressMode mode);

  struct Integer 
  {
    Integer(const char *str, int base)
    {
      m_value = strtol(str, NULL, base);
      m_bytes = strlen(str) / 2 + strlen(str) % 2;
    }

    int value()
    {
      return m_value;
    }

    int size()
    {
      return m_bytes;
    }
  private:
    int m_value;
    int m_bytes;
  };

  struct Instruction
  {
    Instruction(const char *instr, AddressMode mode)
    {
      m_data.push_back(get_byte(instr, mode));
    }

    Instruction& add(Integer *n)
    {
      for (int i = 0; i < n->size(); i++)
      {
        m_data.push_back((n->value() >> (i * 8)) & 0xFF);
      }
    }

    std::vector<uint8_t> data()
    {
      return m_data;
    }

    int address()
    {
      return m_address;
    }
  private:
    std::vector<uint8_t> m_data;
    int m_address;
  };
}

#endif
