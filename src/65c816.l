%{
  #include <string>
  #include "parser.hpp"

  #define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
  #define TOKEN(t)    (yylval.token = t)

  extern "C" int yywrap() { };
%}

%option yylineno

%%

[ \t]*                      ;
\n                          return TOKEN(T_LINE);
<<EOF>>                     return TOKEN(T_LINE);
ADC                         return TOKEN(T_ADC);
AND                         return TOKEN(T_AND);
ASL                         return TOKEN(T_ASL);
BCC                         return TOKEN(T_BCC);
BCS                         return TOKEN(T_BCS);
BEQ                         return TOKEN(T_BEQ);
BIT                         return TOKEN(T_BIT);
BMI                         return TOKEN(T_BMI);
BNE                         return TOKEN(T_BNE);
BPL                         return TOKEN(T_BPL);
BRA                         return TOKEN(T_BRA);
BRK                         return TOKEN(T_BRK);
BRL                         return TOKEN(T_BRL);
BVC                         return TOKEN(T_BVC);
BVS                         return TOKEN(T_BVS);
CLC                         return TOKEN(T_CLC);
CLD                         return TOKEN(T_CLD);
CLI                         return TOKEN(T_CLI);
CLV                         return TOKEN(T_CLV);
CMP                         return TOKEN(T_CMP);
COP                         return TOKEN(T_COP);
CPX                         return TOKEN(T_CPX);
CPY                         return TOKEN(T_CPY);
DEC                         return TOKEN(T_DEC);
DEX                         return TOKEN(T_DEX);
DEY                         return TOKEN(T_DEY);
EOR                         return TOKEN(T_EOR);
INC                         return TOKEN(T_INC);
INX                         return TOKEN(T_INX);
INY                         return TOKEN(T_INY);
JMP                         return TOKEN(T_JMP);
JSR                         return TOKEN(T_JSR);
LDA                         return TOKEN(T_LDA);
LDX                         return TOKEN(T_LDX);
LDY                         return TOKEN(T_LDY);
LSR                         return TOKEN(T_LSR);
MVN                         return TOKEN(T_MVN);
NOP                         return TOKEN(T_NOP);
ORA                         return TOKEN(T_ORA);
PEA                         return TOKEN(T_PEA);
PEI                         return TOKEN(T_PEI);
PER                         return TOKEN(T_PER);
PHA                         return TOKEN(T_PHA);
PHB                         return TOKEN(T_PHB);
PHD                         return TOKEN(T_PHD);
PHK                         return TOKEN(T_PHK);
PHP                         return TOKEN(T_PHP);
PHX                         return TOKEN(T_PHX);
PHY                         return TOKEN(T_PHY);
PLA                         return TOKEN(T_PLA);
PLB                         return TOKEN(T_PLB);
PLD                         return TOKEN(T_PLD);
PLP                         return TOKEN(T_PLP);
PLX                         return TOKEN(T_PLX);
PLY                         return TOKEN(T_PLY);
REP                         return TOKEN(T_REP);
ROL                         return TOKEN(T_ROL);
ROR                         return TOKEN(T_ROR);
RTI                         return TOKEN(T_RTI);
RTL                         return TOKEN(T_RTL);
RTS                         return TOKEN(T_RTS);
SBC                         return TOKEN(T_SBC);
SEC                         return TOKEN(T_SEC);
SED                         return TOKEN(T_SED);
SEI                         return TOKEN(T_SEI);
SEP                         return TOKEN(T_SEP);
STA                         return TOKEN(T_STA);
STP                         return TOKEN(T_STP);
STX                         return TOKEN(T_STX);
STY                         return TOKEN(T_STY);
STZ                         return TOKEN(T_STZ);
TAX                         return TOKEN(T_TAX);
TAY                         return TOKEN(T_TAY);
TCD                         return TOKEN(T_TCD);
TCS                         return TOKEN(T_TCS);
TDC                         return TOKEN(T_TDC);
TRB                         return TOKEN(T_TRB);
TSB                         return TOKEN(T_TSB);
TSC                         return TOKEN(T_TSC);
TSX                         return TOKEN(T_TSX);
TXA                         return TOKEN(T_TXA);
TXS                         return TOKEN(T_TXS);
TXY                         return TOKEN(T_TXY);
TYA                         return TOKEN(T_TYA);
TYX                         return TOKEN(T_TYX);
WAI                         return TOKEN(T_WAI);
WDM                         return TOKEN(T_WDM);
XBA                         return TOKEN(T_XBA);
XCE                         return TOKEN(T_XCE);
[a-zA-Z_][a-zA-Z0-9_]*:     SAVE_TOKEN; puts("T_LABEL"); return TOKEN(T_LABEL);
[asxyASXY]                  SAVE_TOKEN; puts("T_REG");  return TOKEN(T_REG);
[a-zA-Z_][a-zA-Z0-9_]*      SAVE_TOKEN; puts("T_IDENT"); return TOKEN(T_IDENT);
$[0-9a-fA-F]+               SAVE_TOKEN; puts("T_HEX"); return TOKEN(T_HEX);
#$[0-9a-fA-F]+              SAVE_TOKEN; puts("T_HEXLIT"); return TOKEN(T_HEXLIT);
%[01]+                      SAVE_TOKEN; puts("T_BIN"); return TOKEN(T_BIN);
#%[01]+                     SAVE_TOKEN; puts("T_BINLIT"); return TOKEN(T_BINLIT);
[1-9]\d*                    SAVE_TOKEN; puts("T_ORD"); return TOKEN(T_ORD);
#[1-9]\d*                   SAVE_TOKEN; puts("T_ORDLIT"); return TOKEN(T_ORDLIT);
,                           return TOKEN(T_COMMA);
:                           return TOKEN(T_SEPARATOR);
\(                          return TOKEN(T_LPAREN);
\)                          return TOKEN(T_RPAREN);
\[                          return TOKEN(T_LBRACKET);
\]                          return TOKEN(T_RBRACKET);
;.*                         return TOKEN(T_COMMENT);
.                           printf("Unknown token! %s\n", yytext); yyterminate();
%%
