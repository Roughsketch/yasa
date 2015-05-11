#ifndef YASA_INSTRUCTION
#define YASA_INSTRUCTION

#include <string>
#include <exception>
#include <stdexcept>

#include "mode.hpp"
#include "integer.hpp"
#include "assembler.hpp"
#include "externs.hpp"

namespace yasa
{
  class InvalidInstructionException : public std::runtime_error
  {
  public:
    InvalidInstructionException(std::string inst) : std::runtime_error("Invalid instruction found: " + inst) {};
  };

  struct Instruction
  {
    Instruction(std::string &instr, AddressMode mode, int snespos);

    Instruction& add(Integer *n);
    Instruction& add(int n, int size);
    Instruction& add(std::string str);
    Instruction& defer(std::string& expression);

    bool parsed();

    std::vector<uint8_t> data();
    int size();
    uint8_t opcode();
    int address();
    std::string name();
    AddressMode mode();
  private:
    std::vector<std::string> m_params;
    std::vector<uint8_t> m_data;

    int m_address;
    bool m_parsed;
    bool m_setsize;

    std::string m_name;
    AddressMode m_mode;
    int m_size;
    uint8_t m_opcode;
  };
}

#endif
