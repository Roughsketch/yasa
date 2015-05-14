#ifndef YASA_INSTRUCTION
#define YASA_INSTRUCTION

#include <string>
#include <exception>
#include <stdexcept>

#include "mode.hpp"
#include "assembler.hpp"
#include "externs.hpp"

#define INT24_MAX 0xFFFFFF

namespace yasa
{
  namespace detail
  {
    struct Parameter
    {
      Parameter(std::string str, int value = 0, int size = 0)
      {
        string = str;
        value = value;
        size = size;
      }

      std::string string;
      int value;
      int size;
    };
  }

  struct Address
  {
    int real;
    int snes;
  };

  class InvalidInstructionException : public std::runtime_error
  {
  public:
    InvalidInstructionException(std::string inst) : std::runtime_error("Invalid instruction found: " + inst) {};
  };

  struct Instruction
  {
    Instruction(std::string& key, AddressMode mode, int snespos, std::string param1 = "", std::string param2 = "");

    inline std::string key()
    {
      return m_keyword;
    }

    inline std::string type()
    {
      return AddressModeString[m_mode];
    }

    inline int size()
    {
      return m_size;
    }

    inline int pc_addr()
    {
      return m_address.real;
    }

    inline int snes_addr()
    {
      return m_address.snes;
    }

    inline std::string get_param(int param)
    {
      if (m_params.size() > param)
      {
        return m_params[param - 1].string;
      }

      return "";
    }

    inline bool is_static()
    {
      return m_static;
    }

    inline std::vector<uint8_t> data()
    {
      return m_data;
    }

  private:
    std::string m_keyword;
    AddressMode m_mode;
    Address m_address;
    int m_size;
    std::vector<detail::Parameter> m_params;
    std::vector<uint8_t> m_data;

    bool m_setsize;
    bool m_static;  //  Param has no labels and doesn't need to be reparsed
    uint8_t m_opcode;

    void compile();
  };
}

#endif
