#include <iostream>
#include <cstdio>
#include <vector>
#include "parser.hpp"

extern int yyparse();
extern int yylex();
extern char *yytext;
extern std::vector<uint8_t> *output;

int main(int argc, char *argv[])
{
  int yydebug = 1;
  // int token;
  // while ((token = yylex()) != 0)
  //   printf("Token: %d (%s)\n", token, yytext);

  puts("Parsing:");
  std::cout << "yyparse: " << yyparse() << std::endl;
  std::cout << "output : " << std::endl;

  for (auto byte : *output)
  {
    std::cout << std::hex << static_cast<int>(byte) << " ";
  }
  return 0;
}