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
(\.+)?[a-zA-Z_][a-zA-Z0-9_]*    SAVE_TOKEN; return TOKEN(T_IDENT);
$[0-9a-fA-F]+                   SAVE_TOKEN; return TOKEN(T_HEX);
%[01]+                          SAVE_TOKEN; return TOKEN(T_BIN);
[0-9]*                          SAVE_TOKEN; return TOKEN(T_ORD);
\(                              return TOKEN(T_LPAREN);
\)                              return TOKEN(T_RPAREN);
\>\>                            return TOKEN(T_RSHIFT);
\<\<                            return TOKEN(T_LSHIFT);
\+                              return TOKEN(T_PLUS);
\-                              return TOKEN(T_MINUS);
\*                              return TOKEN(T_MULT);
\/                              return TOKEN(T_DIV);
%                               return TOKEN(T_MOD);
&                               return TOKEN(T_LOGAND);
\|                              return TOKEN(T_LOGOR);
\^                              return TOKEN(T_LOGXOR);
!                               return TOKEN(T_LOGNOT);
=                               return TOKEN(T_EQUAL);
;                               return TOKEN(T_END);
.                               printf("Unknown token! %s %d\n", mathtext, mathlineno); yyterminate();
%%

void math_parse_expr(const std::string& str)
{
  std::string scan = str + ";";

  math_switch_to_buffer(math_scan_string(scan.c_str()));
  mathlineno = 1;
}