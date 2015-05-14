#ifndef YASA_MATH_EXTERNS
#define YASA_MATH_EXTERNS

extern int mathparse(std::map<std::string, int>& identifiers);
extern int mathlex();

extern char *mathtext;
extern FILE *mathin;

extern void math_parse_expr(const std::string& str);
extern int math_parse(const std::string& str);
extern int math_result();
extern int math_get_size();

#endif
