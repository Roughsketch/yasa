#include "instruction.hpp"

namespace yasa
{
  Instruction::Instruction(std::string &instr, AddressMode mode, int snespos)
  {
    m_address = snespos;
    m_name = std::string(instr.substr(0, 3));
    m_mode = mode;
    m_parsed = true;
    m_size = 1;

    if (m_mode == Implied)
    {
      m_opcode = get_byte(instr, mode, 1);
    }


    if (instr.size() > 3)
    {
      m_setsize = true;
      switch (tolower(instr[4]))
      {
        case 'b':
          m_size = 2;
          break;
        case 'w':
          m_size = 3;
          break;
        case 'l':
          m_size = 4;
          break;
        default:
          throw InvalidInstructionException("Invalid size modifier: " + instr);
      }
    }
  }

  Instruction& Instruction::add(Integer *n)
  {
    m_parsed = false;
    m_params.push_back(n->value());
    m_size += n->size();

    return *this;
  }

  Instruction& Instruction::add(std::string str)
  {
    m_parsed = false;
    int n = strtol(str.c_str(), NULL, 10);
    m_params.push_back(n);
    m_size += n == 0 ? 1 : (std::log2(n) / 8) + 1;

    return *this;
  }

  Instruction& Instruction::add(int n, int size = 1)
  {
    m_parsed = false;
    m_params.push_back(n);
    m_size += size;

    return *this;
  }

  Instruction& Instruction::defer(std::string& expression)
  {
    m_parsed = false;
    m_expr = expression;
  }

  bool Instruction::parsed()
  {
    return m_parsed;
  }

  std::vector<uint8_t> Instruction::data()
  {
    if (m_parsed == false)
    {
      bool success;
      m_data.clear();

      m_opcode = get_byte(m_name, m_mode, m_size, success);

      m_data.push_back(m_opcode);

      if (m_params.size() == 1)
      {
        for (int i = 0; i < m_size - 1; i++)
        {
          m_data.push_back((m_params[0] >> (i * 8)) & 0xFF);
        }
      }
      else
      {
        m_data.push_back(m_params[0]);
        m_data.push_back(m_params[1]);
      }
    }
    return m_data;
  }

  int Instruction::size()
  {
    return m_size;
  }

  uint8_t Instruction::opcode()
  {
    return m_opcode;
  }

  int Instruction::address()
  {
    return m_address;
  }

  std::string Instruction::name()
  {
    return m_name;
  }

  AddressMode Instruction::mode()
  {
    return m_mode;
  }
}