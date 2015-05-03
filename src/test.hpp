#ifndef YASA_TEST
#define YASA_TEST

#include <iostream>
#include <vector>

#include "parser.hpp"

extern int yyparse();
extern int yylex();
extern void scan_string(const std::string& str);
extern void set_base_path(const std::string& path);
extern char *yytext;
extern std::vector<yasa::Instruction> *output;
extern std::map<std::string, int> labels;

namespace test
{
  bool run_tests();
  bool arch_65816();
  bool super_mario_world();
}

#endif
