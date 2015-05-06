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

  yasa::Integer *math_output;

  void matherror(std::map<std::string, int>& t, const char *s) {
    printf("ERROR: %s (line %d)\n", s, mathlineno); 
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
    yasa::Integer *number;
}

%type <number> bare imm label number math value

%start value

%%

value:  math T_END              { std::cout << "Value: " << *$1 << std::endl; math_output = $1; exit(0); }
      ;

bare:   T_HEX                   { $$ = new yasa::Integer(mathtext + 1, 16); }
      | T_ORD                   { $$ = new yasa::Integer(mathtext + 0, 10); }
      | T_BIN                   { $$ = new yasa::Integer(mathtext + 1, 2);  }
      ;

imm:    T_HEXLIT                { $$ = new yasa::Integer(mathtext + 2, 16);  }
      | T_ORDLIT                { $$ = new yasa::Integer(mathtext + 1, 10);  }
      | T_BINLIT                { $$ = new yasa::Integer(mathtext + 2, 2);   }
      ;

label:  T_IDENT                 { $$ = new yasa::Integer(identifiers[std::string(mathtext)]); }
      | T_SUBLABEL              { $$ = new yasa::Integer(identifiers[std::string(mathtext)]); }
      | T_IMMLABEL              { $$ = new yasa::Integer(identifiers[std::string(mathtext)]); }
      ;

number: bare                    { $$ = $1; }
      | imm                     { $$ = $1; }
      | label                   { $$ = $1; }
      ;

math:   math T_PLUS math        { $$ = new yasa::Integer(*$1 + *$3); }
      | math T_MINUS math       { $$ = new yasa::Integer(*$1 - *$3); }
      | math T_MULT math        { $$ = new yasa::Integer(*$1 * *$3); }
      | math T_DIV math         { $$ = new yasa::Integer(*$1 / *$3); }
      | math T_MOD math         { $$ = new yasa::Integer(*$1 % *$3); }
      | math T_LOGAND math      { $$ = new yasa::Integer(*$1 & *$3); }
      | math T_LOGOR math       { $$ = new yasa::Integer(*$1 | *$3); }
      | math T_LOGXOR math      { $$ = new yasa::Integer(*$1 ^ *$3); }
      | math T_RSHIFT math      { $$ = new yasa::Integer(*$1 >> *$3); }
      | math T_LSHIFT math      { $$ = new yasa::Integer(*$1 << *$3); }
      | T_LPAREN math T_RPAREN  { $$ = $2; }
      | number
      ;
%%