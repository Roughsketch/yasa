#include <iostream>
#include <iomanip>
#include <cstdio>
#include <vector>

#include "parser.hpp"
#include "externs.hpp"

#ifdef DEBUG_TEST
  #include "test.hpp"
#endif

void usage();

int main(int argc, char *argv[])
{
  if (argc == 1)
  {
    #ifdef DEBUG_TEST
      test::run_tests();
    #else
      yyparse();
      //usage();
    #endif
  }
  else if (std::string(argv[1]) == "-m")
  {
    std::map<std::string, int> temp;

    while (true)
    {
      int result = mathparse(temp); 

      if (result == 0)
      {
        std::cout << "Value: " << math_result() << std::endl; 
      }
    }
  }
  else if (std::string(argv[1]) == "-n")
  {
    yyparse();
  }
  else
  {
    for (int i = 1; i < argc; i++)
    {
      FILE *fp = fopen(argv[i], "r");

      if (fp == NULL)
      {
        std::cout << "Could not open file." << std::endl;
        return 1;
      }

      std::cout << "Parsing " << argv[1] << std::endl;

      yyin = fp;
      std::cout << "Result: " << yyparse() << std::endl;

      fclose(fp);
    }
  }

  return 0;
}

void usage()
{
  std::cout << R"(
    Usage: yasa <file>.asm
    )" << std::endl;
}