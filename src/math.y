%code requires {
  #include <string>
  #include <map>
  #include <cstdint>

  #include "integer.hpp"
}

%{
  #include <iostream>
  #include <map>

  #include "assembler.hpp"

  extern int mathlex();
  extern char * mathtext;
  extern int mathlineno;

  int math_output;

  void matherror(std::map<std::string, int>& t, const char *s) {
    std::cout << "ERROR: " << s << " (line " << mathlineno << ")" << std::endl;
  }

  #define MATHFPRINTF (stderr, format, args) puts(format)
%}
%error-verbose
%define api.prefix math

%parse-param {std::map<std::string, int>& identifiers}

//  Names / Labels
%token <string> T_IDENT T_SUBLABEL T_IMMLABEL T_END

//  Numbers
%token <string> T_HEX T_BIN T_ORD T_HEXLIT T_BINLIT T_ORDLIT

//  Math
%token <string> T_RSHIFT T_LSHIFT T_PLUS T_MINUS T_MULT T_DIV T_MOD T_LOGAND T_LOGOR T_LOGXOR T_LOGNOT T_EQUAL T_LPAREN T_RPAREN

//  Math precedence
%left T_LOGOR
%left T_LOGXOR
%left T_LOGAND
%left T_RSHIFT T_LSHIFT
%left T_PLUS T_MINUS
%left T_MULT T_DIV T_MOD
%left T_LOGNOT

%union {
    std::string *string;
    int token;
    int number;
    yasa::Integer *yasa_integer;
}

%type <yasa_integer>  value
%type <number>  bare imm label number math

%start value

%%

value:  math T_END              { math_output = $1; }
      ;

bare:   T_HEX                   { $$ = strtol(mathtext + 1, NULL, 16); }
      | T_ORD                   { $$ = strtol(mathtext + 0, NULL, 10); }
      | T_BIN                   { $$ = strtol(mathtext + 1, NULL, 2);  }
      ;

imm:    T_HEXLIT                { $$ = strtol(mathtext + 2, NULL, 16);  }
      | T_ORDLIT                { $$ = strtol(mathtext + 1, NULL, 10);  }
      | T_BINLIT                { $$ = strtol(mathtext + 2, NULL, 2);   }
      ;

label:  T_IDENT                 { $$ = identifiers[std::string(mathtext)]; }
      | T_SUBLABEL              { $$ = identifiers[std::string(mathtext)]; }
      | T_IMMLABEL              { $$ = identifiers[std::string(mathtext)]; }
      ;

number: bare                    { $$ = $1; }
      | imm                     { $$ = $1; }
      | label                   { $$ = $1; }
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
      | T_LPAREN math T_RPAREN  { $$ = $2; }
      | number
      ;
%%

int math_result()
{
  return math_output;
}
