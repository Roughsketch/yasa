#include "instruction.hpp"

namespace yasa
{
  Instruction::Instruction(std::string& key, AddressMode mode, int snespos, std::string param1, std::string param2)
  {
    m_address.real = util::convaddr(snespos);
    m_address.snes = snespos;
    m_keyword = std::string(key.substr(0, 3));
    m_mode = mode;
    m_static = false;
    m_setsize = false;

    if (param1 != "")
    {
      m_params.push_back(detail::Parameter(param1));
    }

    //  Don't allow param1 to be empty if param2 is being used
    if (param1 != "" && param2 != "")
    {
      m_params.push_back(detail::Parameter(param2));
    }

    //  Special case since BRK, COP, and WDM are implied but take an immediate parameter
    if (m_mode == Implied)
    {
      try
      {
        m_opcode = get_byte(key, mode, 1);
      }
      catch(InvalidInstructionException e)
      {
        m_opcode = get_byte(key, mode, 2);
      }
    }

    if (key.size() > 3)
    {
      m_setsize = true;
      switch (tolower(key[4]))
      {
        case 'b':
          m_size = 2;
          break;
        case 'w':
          m_size = 3;
          std::cout << "Set size to 3" << std::endl;
          break;
        case 'l':
          m_size = 4;
          break;
        default:
          throw InvalidInstructionException("Invalid size modifier: " + key);
      }
    }
    else
    {
      m_size = get_avg_size(key, mode);
      std::cout << "Average size: " << m_size << std::endl;
    }

    std::map<std::string, int> temp;

    if (m_params.size() == 0)
    {
      m_static = true;
    }
    else if (m_params.size() == 1)
    {
      int result = math_parse(m_params[0].string);

      if (result <= INT24_MAX)
      {
        m_static = true;

        if (m_setsize == false)
        {
          int result = math_result();
          m_params[0].value = result;
          m_params[0].size = math_get_size();
          m_size = math_get_size() + 1;
          std::cout << "One param size: " << math_get_size() << std::endl;
        }
      }
    }
    else if (m_params.size() == 2)
    {
      int result = math_parse(m_params[0].string);
      
      if (result <= INT24_MAX)
      {
        m_params[0].value = result;
        m_params[0].size = math_get_size();

        result = math_parse(m_params[1].string);
        
        if (result <= INT24_MAX)
        {
          m_static = true;

          m_params[1].value = result;
          m_params[1].size = math_get_size();

          if (m_setsize == false)
          {
            m_size = m_params[0].size + m_params[1].size + 1;
          }
        }
      }
    }

    std::cout << key << " + " << param1 << " + " << param2 << " " << m_size << std::endl;

    if (m_static)
    {
      this->compile();
    }
  }

  void Instruction::compile()
  {
    m_opcode = get_byte(m_keyword, m_mode, m_size);

    m_data.clear();
    m_data.push_back(m_opcode);

    for (auto param : m_params)
    {
      for (int i = 0; i < param.size; i++)
      {
        m_data.push_back((param.value) & (0xFF << (i * 8))); 
      }
    }

    while (m_data.size() < m_size)
    {
      m_data.push_back(0);
    }
  }

  /*
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
  */
}