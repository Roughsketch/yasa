#include <iostream>
#include <iomanip>
#include <cstdio>
#include <vector>

#include "parser.hpp"
#include "test.hpp"
#include "externs.hpp"

int main(int argc, char *argv[])
{
  if (argc == 1)
  {
    test::run_tests(); 
  }
  else
  {
    std::cout << "Parsing " << argv[1] << std::endl;

    FILE *fp = fopen(argv[1], "r");

    if (fp == NULL)
    {
      std::cout << "Could not open file." << std::endl;
      return 1;
    }


    yyin = fp;
    std::cout << "Result: " << yyparse() << std::endl;

    fclose(fp);
  }

  return 0;
}