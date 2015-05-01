#include <iostream>
#include <cstdio>
#include <vector>
#include "parser.hpp"

extern int yyparse();
extern int yylex();
extern void scan_string(const std::string& str);
extern char *yytext;
extern std::vector<yasa::Instruction> *output;
extern std::map<std::string, int> labels;

int main(int argc, char *argv[])
{


  puts("Parsing:");

  // scan_string("LDA $0230");
  // yyparse();

  std::cout << "yyparse: " << yyparse() << std::endl;
  std::cout << "output : " << std::endl;

  for (auto instr : *output)
  {
    if (instr.has_label())
    {
      instr.add(labels[instr.label()] - instr.address(), yasa::get_size(instr.name(), instr.mode()));
    }
  }

  for (auto instr : *output)
  {
    for (auto byte : instr.data())
    {
      std::cout << std::hex << static_cast<int>(byte) << " ";
    }
  }

  std::cout << std::endl;

  for (auto label : labels)
  {
    std::cout << "Label: " << label.first << " at address " << std::hex << label.second << std::dec << std::endl;
  }
  return 0;
}