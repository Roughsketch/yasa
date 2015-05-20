%code requires {
  #include <string>
  #include <map>
  #include <cstdint>
}

%{
  #include <iostream>
  #include <map>
  #include <cstring>

  #include "math_externs.hpp"

  extern int mathlex();
  extern char * mathtext;
  extern int mathlineno;

  int math_output = 0;
  int math_size = 0;

  void matherror(std::map<std::string, int>& t, const char *s) {
    std::cout << "ERROR: " << s << " (line " << mathlineno << ")" << std::endl;
  }

  void math_set_size(const char *str, int base)
  {
    int size = 0;
    int length = strlen(str);

    if (base == 2)
    {
      size = length / 4 + ((length % 4 > 0) ? 1 : 0);
    }
    else if (base == 16)
    {
      size = length / 2 + length % 2;
    }

    if (size > math_size)
    {
      math_size = size;
    }
  }
%}
%error-verbose
%define api.prefix math

%parse-param {std::map<std::string, int>& identifiers}

//  Names / Labels
%token <string> T_IDENT T_END

//  Numbers
%token <string> T_HEX T_BIN T_ORD

//  Math
%token <string> T_RSHIFT T_LSHIFT T_PLUS T_MINUS T_MULT T_DIV T_MOD T_LOGAND T_LOGOR T_LOGXOR T_LOGCOMPL T_EQUAL T_LPAREN T_RPAREN

//  Math precedence
%left T_LOGOR
%left T_LOGXOR
%left T_LOGAND
%left T_RSHIFT T_LSHIFT
%left T_PLUS T_MINUS
%left T_MULT T_DIV T_MOD
%left T_LOGCOMPL

%union {
    std::string *string;
    int token;
    int number;
}

%type <number>  label number math

%start value

%%

value:  math T_END {
          math_output = $1;

          //  If the output is larger than the max provided size, then correct it.
          if (math_output > 0xFFFFFF)
          {
            std::cout << "Error: Expression evaluated is greater than max integer size." << std::endl;
            YYERROR;
          }
          else if (math_output > 0xFFFF && math_size < 3)
          {
            math_size = 3;
          }
          else if (math_output > 0xFF && math_size < 2)
          {
            math_size = 2;
          }

          YYACCEPT; 
        }
      ;

label:  T_IDENT { 
          if (identifiers.count(std::string(mathtext)) != 1)
          {
            YYABORT;
          }

          $$ = identifiers[std::string(mathtext)]; 
        }
      ;

number: T_HEX      { $$ = strtol(mathtext + 1, NULL, 16); math_set_size(mathtext + 1, 16); }
      | T_ORD      { $$ = strtol(mathtext + 0, NULL, 10); math_set_size(mathtext + 0, 10); }
      | T_BIN      { $$ = strtol(mathtext + 1, NULL,  2); math_set_size(mathtext + 1,  2); }
      | label      { $$ = $1; }
      ;

math:   math T_PLUS math        { $$ = $1 + $3; }
      | math T_MINUS math       { $$ = $1 - $3; }
      | math T_MULT math        { $$ = $1 * $3; }
      | math T_DIV math         { $$ = $1 / $3; }
      | math T_MOD math         { $$ = $1 % $3; }
      | math T_LOGAND math      { $$ = $1 & $3; }
      | math T_LOGOR math       { $$ = $1 | $3; }
      | math T_LOGXOR math      { $$ = $1 ^ $3; }
      | math T_RSHIFT math      { $$ = $1 >> $3; }
      | math T_LSHIFT math      { $$ = $1 << $3; }
      | T_LOGCOMPL math         { $$ = ~$2; }
      | T_LPAREN math T_RPAREN  { $$ = $2; }
      | number
      ;
%%

int math_result()
{
  return math_output;
}

int math_get_size()
{
  return math_size;
}

int math_parse(const std::string& expr)
{
  std::map<std::string, int> temp;

  math_output = 0;
  math_size = 0;
  math_parse_expr(expr);

  int result = mathparse(temp);

  if (result == 0)
  {
    return math_result();
  }

  return 1 << 24;
}