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
      try
      {
        m_opcode = get_byte(instr, mode, 1);
      }
      catch(InvalidInstructionException e)
      {
        m_opcode = get_byte(instr, mode, 2);
      }
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
    else
    {
      m_size = get_avg_size(instr, mode);
    }
  }

  Instruction& Instruction::add(std::string str)
  {
    m_parsed = false;
    m_params.push_back(str);

    return *this;
  }

  std::vector<uint8_t> Instruction::data()
  {
    if (m_parsed == false)
    {
      m_data.clear();

      auto labels = get_labels();

      math_parse_expr(m_params[0]);
      
      int result = mathparse(labels);

      if (result != 0)
      {
        throw InvalidInstructionException("Could not parse expression: " + m_params[0]);
      }

      int value = math_result();

      if (util::bytesize(value) != m_size - 1)
      {

      }

      m_opcode = get_byte(m_name, m_mode, m_size);

      m_data.push_back(m_opcode);

      if (m_params.size() == 1)
      {
        for (int i = 0; i < m_size - 1; i++)
        {
          //m_data.push_back((m_params[0] >> (i * 8)) & 0xFF);
        }
      }
      else
      {
        //m_data.push_back(m_params[0]);
        //m_data.push_back(m_params[1]);
      }
    }
    return m_data;
  }

  bool Instruction::parsed()
  {
    return m_parsed;
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