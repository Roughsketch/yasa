#ifndef YASA_INSTRUCTION
#define YASA_INSTRUCTION

#include <string>
#include <exception>
#include <stdexcept>

#include "mode.hpp"
#include "integer.hpp"
#include "assembler.hpp"

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
    Instruction& set_label(std::string label);

    bool has_label();
    void parse_label(int label_addr);
    std::string label();

    std::vector<uint8_t> data();
    int size();
    uint8_t opcode();
    int address();
    std::string name();
    AddressMode mode();
  private:
    std::vector<uint8_t> m_data;
    int m_address;
    std::string m_label;
    std::string m_name;
    AddressMode m_mode;
  };
}

#endif
