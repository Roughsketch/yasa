#ifndef YASA_EXTERNS
#define YASA_EXTERNS

#include "math_externs.hpp"

extern int yyparse();
extern int yylex();

extern char *yytext;
extern FILE *yyin;

extern void scan_string(const std::string& str);
extern void set_base_path(const std::string& path);

extern std::vector<yasa::Instruction> *output;
extern std::map<std::string, int> labels;

#endif
