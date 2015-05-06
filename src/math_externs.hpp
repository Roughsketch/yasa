#ifndef YASA_MATH_EXTERNS
#define YASA_MATH_EXTERNS

extern int mathparse(std::map<std::string, int>& identifiers);
extern int mathlex();

extern char *mathtext;
extern FILE *mathin;

extern yasa::Integer *math_output;

#endif
