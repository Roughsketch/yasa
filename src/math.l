%{
  #include <string>
  #include <iostream>
  #include <stack>
  #include <cstdio>

  #include "math_parser.hpp"

  #define SAVE_TOKEN  mathlval.string = new std::string(mathtext, mathleng)
  #define TOKEN(t)    (mathlval.token = t)
%}

%option prefix="math"

%option yylineno
%option noyywrap

%%
[ \t\r]+                      ; //  Ignore Whitespace
^\s*\.+[a-zA-Z_][a-zA-Z0-9_]*   puts("T_SUBLABEL"); SAVE_TOKEN; return TOKEN(T_SUBLABEL);
#[a-zA-Z_][a-zA-Z0-9_]*         puts("T_IMMLABEL"); SAVE_TOKEN; return TOKEN(T_IMMLABEL);
(\.+)?[a-zA-Z_][a-zA-Z0-9_]*    puts("T_IDENT"); SAVE_TOKEN; return TOKEN(T_IDENT);
$[0-9a-fA-F]+                   puts("T_HEX"); SAVE_TOKEN; return TOKEN(T_HEX);
#$[0-9a-fA-F]+                  puts("T_HEXLIT"); SAVE_TOKEN; return TOKEN(T_HEXLIT);
%[01]+                          puts("T_BIN"); SAVE_TOKEN; return TOKEN(T_BIN);
#%[01]+                         puts("T_BINLIT"); SAVE_TOKEN; return TOKEN(T_BINLIT);
[1-9][0-9]*                     puts("T_ORD"); SAVE_TOKEN; return TOKEN(T_ORD);
#[1-9][0-9]*                    puts("T_ORDLIT"); SAVE_TOKEN; return TOKEN(T_ORDLIT);
\(                              puts("T_LPAREN"); return TOKEN(T_LPAREN);
\)                              puts("T_RPAREN"); return TOKEN(T_RPAREN);
\>\>                            puts("T_RSHIFT"); return TOKEN(T_RSHIFT);
\<\<                            puts("T_LSHIFT"); return TOKEN(T_LSHIFT);
\+                              puts("T_PLUS"); return TOKEN(T_PLUS);
\-                              puts("T_MINUS"); return TOKEN(T_MINUS);
\*                              puts("T_MULT"); return TOKEN(T_MULT);
\/                              puts("T_DIV"); return TOKEN(T_DIV);
%                               puts("T_MOD"); return TOKEN(T_MOD);
&                               puts("T_LOGAND"); return TOKEN(T_LOGAND);
\|                              puts("T_LOGOR"); return TOKEN(T_LOGOR);
\^                              puts("T_LOGXOR"); return TOKEN(T_LOGXOR);
!                               puts("T_LOGNOT"); return TOKEN(T_LOGNOT);
=                               puts("T_EQUAL"); return TOKEN(T_EQUAL);
;                               puts("T_END"); return TOKEN(T_END);
.                               printf("Unknown token! %s %d\n", mathtext, mathlineno); yyterminate();
%%

void math_parse_expr(const std::string& str)
{
  std::string scan = str + ";";

  math_switch_to_buffer(math_scan_string(scan.c_str()));
  mathlineno = 1;
}