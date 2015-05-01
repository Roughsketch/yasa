#include <iostream>
#include <cstdio>
#include <vector>
#include "parser.hpp"

extern int yyparse();
extern int yylex();
extern void scan_string(const std::string& str);
extern char *yytext;
extern std::vector<uint8_t> *output;

int main(int argc, char *argv[])
{


  puts("Parsing:");

  // scan_string("LDA $0230");
  // yyparse();

  std::cout << "yyparse: " << yyparse() << std::endl;
  std::cout << "output : " << std::endl;

  for (auto byte : *output)
  {
    std::cout << std::hex << static_cast<int>(byte) << " ";
  }
  return 0;
}