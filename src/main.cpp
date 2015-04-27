#include <iostream>
#include <cstdio>
#include "parser.hpp"

extern int yyparse();
extern int yylex();
extern char *yytext;
extern std::string *output;

int main(int argc, char *argv[])
{
  int yydebug = 1;
  // int token;
  // while ((token = yylex()) != 0)
  //   printf("Token: %d (%s)\n", token, yytext);

  puts("Parsing:");
  std::cout << "yyparse: " << yyparse() << std::endl;
  std::cout << "output : " << *output << std::endl;
  return 0;
}