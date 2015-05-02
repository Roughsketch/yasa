#include "instruction.hpp"

namespace yasa
{
  Instruction::Instruction(std::string &instr, AddressMode mode, int snespos)
  {
    bool success = false;
    uint8_t op = get_byte(instr, mode, success);

    if (!success)
    {
      std::cout << "No opcode for " << instr << std::endl;
      exit(0);
    }

    m_data.push_back(op); 
    m_address = snespos;
    m_name = std::string(instr);
    m_mode = mode;
    m_label = "";
  }

  Instruction& Instruction::add(Integer *n)
  {
    for (int i = 0; i < n->size(); i++)
    {
      m_data.push_back((n->value() >> (i * 8)) & 0xFF);
    }

    return *this;
  }

  Instruction& Instruction::add(int n, int size = 1)
  {
    for (int i = 0; i < size; i++)
    {
      m_data.push_back((n >> (i * 8)) & 0xFF);
    }

    return *this;
  }

  Instruction& Instruction::set_label(std::string label)
  {
    m_label = label;
    return *this;
  }

  bool Instruction::has_label()
  {
    return m_label != "";
  }

  void Instruction::parse_label(int label_addr)
  {
    int relative = label_addr - m_address - 1;

    for (int i = 0; i < 1; i++)
    {
      m_data.push_back((relative >> (i * 8)) & 0xFF);
    }
  }

  std::string Instruction::label()
  {
    return m_label;
  }

  std::vector<uint8_t> Instruction::data()
  {
    return m_data;
  }

  int Instruction::size()
  {
    return m_data.size();
  }

  uint8_t Instruction::opcode()
  {
    return m_data[0];
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