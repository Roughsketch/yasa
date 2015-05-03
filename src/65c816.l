%{
  #include <string>
  #include <iostream>
  #include <stack>
  #include <cstdio>

  #include "parser.hpp"

  #define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
  #define TOKEN(t)    (yylval.token = t)

  namespace include
  {
    std::stack<YY_BUFFER_STATE> stack;
    int max_depth = 10;
    int depth = 0;
  }

  std::string base_path;
%}

%option yylineno
%option noyywrap

%x incsrc

%%

[ \t]*                          ;                     //  Ignore Whitespace
;.*                             ;                     //  And comments
\n                              return TOKEN(T_LINE);

LOROM                           ;
(?i:incsrc)[ \t]*+              BEGIN(incsrc);

<incsrc>.*+                     {
                                  if (include::stack.size() >= include::max_depth)
                                  {
                                    std::cout << "Error: include depth too deep." << std::endl;
                                    exit(0);
                                  }

                                  include::depth++;
                                  include::stack.push(YY_CURRENT_BUFFER);

                                  std::cout << "Including " << yytext << std::endl;

                                  std::string full_path = base_path + "/" + yytext;
                                  yyin = fopen(full_path.c_str(), "r");

                                  if (yyin == NULL)
                                  {
                                    std::cout << "Could not open file \"" << yytext << "\"" << std::endl;
                                    exit(0);
                                  }

                                  yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));

                                  BEGIN(INITIAL);
                                }

<<EOF>>                         {
                                  std::cout << "Include depth: " << include::depth << std::endl;
                                  if (!include::depth || --(include::depth) == 0)
                                  {
                                    yyterminate();
                                  }
                                  else
                                  {
                                    yy_delete_buffer(YY_CURRENT_BUFFER);
                                    yy_switch_to_buffer(include::stack.top());
                                    include::stack.pop();
                                  }
                                }

(?i:ADC(\.(b|w|l))?)            return TOKEN(T_ADC);
(?i:AND(\.(b|w|l))?)            return TOKEN(T_AND);
(?i:ASL(\.(b|w|l))?)            return TOKEN(T_ASL);
(?i:BCC(\.(b|w|l))?)            return TOKEN(T_BCC);
(?i:BCS(\.(b|w|l))?)            return TOKEN(T_BCS);
(?i:BEQ(\.(b|w|l))?)            return TOKEN(T_BEQ);
(?i:BIT(\.(b|w|l))?)            return TOKEN(T_BIT);
(?i:BMI(\.(b|w|l))?)            return TOKEN(T_BMI);
(?i:BNE(\.(b|w|l))?)            return TOKEN(T_BNE);
(?i:BPL(\.(b|w|l))?)            return TOKEN(T_BPL);
(?i:BRA(\.(b|w|l))?)            return TOKEN(T_BRA);
(?i:BRK(\.(b|w|l))?)            return TOKEN(T_BRK);
(?i:BRL(\.(b|w|l))?)            return TOKEN(T_BRL);
(?i:BVC(\.(b|w|l))?)            return TOKEN(T_BVC);
(?i:BVS(\.(b|w|l))?)            return TOKEN(T_BVS);
(?i:CLC(\.(b|w|l))?)            return TOKEN(T_CLC);
(?i:CLD(\.(b|w|l))?)            return TOKEN(T_CLD);
(?i:CLI(\.(b|w|l))?)            return TOKEN(T_CLI);
(?i:CLV(\.(b|w|l))?)            return TOKEN(T_CLV);
(?i:CMP(\.(b|w|l))?)            return TOKEN(T_CMP);
(?i:COP(\.(b|w|l))?)            return TOKEN(T_COP);
(?i:CPX(\.(b|w|l))?)            return TOKEN(T_CPX);
(?i:CPY(\.(b|w|l))?)            return TOKEN(T_CPY);
(?i:DEC(\.(b|w|l))?)            return TOKEN(T_DEC);
(?i:DEX(\.(b|w|l))?)            return TOKEN(T_DEX);
(?i:DEY(\.(b|w|l))?)            return TOKEN(T_DEY);
(?i:EOR(\.(b|w|l))?)            return TOKEN(T_EOR);
(?i:INC(\.(b|w|l))?)            return TOKEN(T_INC);
(?i:INX(\.(b|w|l))?)            return TOKEN(T_INX);
(?i:INY(\.(b|w|l))?)            return TOKEN(T_INY);
(?i:JML(\.(b|w|l))?)            return TOKEN(T_JML);  //  Special case of JMP
(?i:JMP(\.(b|w|l))?)            return TOKEN(T_JMP);
(?i:JSL(\.(b|w|l))?)            return TOKEN(T_JSR);  //  Special case of JSR
(?i:JSR(\.(b|w|l))?)            return TOKEN(T_JSR);
(?i:LDA(\.(b|w|l))?)            return TOKEN(T_LDA);
(?i:LDX(\.(b|w|l))?)            return TOKEN(T_LDX);
(?i:LDY(\.(b|w|l))?)            return TOKEN(T_LDY);
(?i:LSR(\.(b|w|l))?)            return TOKEN(T_LSR);
(?i:MVN(\.(b|w|l))?)            return TOKEN(T_MVN);
(?i:MVP(\.(b|w|l))?)            return TOKEN(T_MVP);  //  Special case of MVN
(?i:NOP(\.(b|w|l))?)            return TOKEN(T_NOP);
(?i:ORA(\.(b|w|l))?)            return TOKEN(T_ORA);
(?i:PEA(\.(b|w|l))?)            return TOKEN(T_PEA);
(?i:PEI(\.(b|w|l))?)            return TOKEN(T_PEI);
(?i:PER(\.(b|w|l))?)            return TOKEN(T_PER);
(?i:PHA(\.(b|w|l))?)            return TOKEN(T_PHA);
(?i:PHB(\.(b|w|l))?)            return TOKEN(T_PHB);
(?i:PHD(\.(b|w|l))?)            return TOKEN(T_PHD);
(?i:PHK(\.(b|w|l))?)            return TOKEN(T_PHK);
(?i:PHP(\.(b|w|l))?)            return TOKEN(T_PHP);
(?i:PHX(\.(b|w|l))?)            return TOKEN(T_PHX);
(?i:PHY(\.(b|w|l))?)            return TOKEN(T_PHY);
(?i:PLA(\.(b|w|l))?)            return TOKEN(T_PLA);
(?i:PLB(\.(b|w|l))?)            return TOKEN(T_PLB);
(?i:PLD(\.(b|w|l))?)            return TOKEN(T_PLD);
(?i:PLP(\.(b|w|l))?)            return TOKEN(T_PLP);
(?i:PLX(\.(b|w|l))?)            return TOKEN(T_PLX);
(?i:PLY(\.(b|w|l))?)            return TOKEN(T_PLY);
(?i:REP(\.(b|w|l))?)            return TOKEN(T_REP);
(?i:ROL(\.(b|w|l))?)            return TOKEN(T_ROL);
(?i:ROR(\.(b|w|l))?)            return TOKEN(T_ROR);
(?i:RTI(\.(b|w|l))?)            return TOKEN(T_RTI);
(?i:RTL(\.(b|w|l))?)            return TOKEN(T_RTL);
(?i:RTS(\.(b|w|l))?)            return TOKEN(T_RTS);
(?i:SBC(\.(b|w|l))?)            return TOKEN(T_SBC);
(?i:SEC(\.(b|w|l))?)            return TOKEN(T_SEC);
(?i:SED(\.(b|w|l))?)            return TOKEN(T_SED);
(?i:SEI(\.(b|w|l))?)            return TOKEN(T_SEI);
(?i:SEP(\.(b|w|l))?)            return TOKEN(T_SEP);
(?i:STA(\.(b|w|l))?)            return TOKEN(T_STA);
(?i:STP(\.(b|w|l))?)            return TOKEN(T_STP);
(?i:STX(\.(b|w|l))?)            return TOKEN(T_STX);
(?i:STY(\.(b|w|l))?)            return TOKEN(T_STY);
(?i:STZ(\.(b|w|l))?)            return TOKEN(T_STZ);
(?i:TAX(\.(b|w|l))?)            return TOKEN(T_TAX);
(?i:TAY(\.(b|w|l))?)            return TOKEN(T_TAY);
(?i:TCD(\.(b|w|l))?)            return TOKEN(T_TCD);
(?i:TCS(\.(b|w|l))?)            return TOKEN(T_TCS);
(?i:TDC(\.(b|w|l))?)            return TOKEN(T_TDC);
(?i:TRB(\.(b|w|l))?)            return TOKEN(T_TRB);
(?i:TSB(\.(b|w|l))?)            return TOKEN(T_TSB);
(?i:TSC(\.(b|w|l))?)            return TOKEN(T_TSC);
(?i:TSX(\.(b|w|l))?)            return TOKEN(T_TSX);
(?i:TXA(\.(b|w|l))?)            return TOKEN(T_TXA);
(?i:TXS(\.(b|w|l))?)            return TOKEN(T_TXS);
(?i:TXY(\.(b|w|l))?)            return TOKEN(T_TXY);
(?i:TYA(\.(b|w|l))?)            return TOKEN(T_TYA);
(?i:TYX(\.(b|w|l))?)            return TOKEN(T_TYX);
(?i:WAI(\.(b|w|l))?)            return TOKEN(T_WAI);
(?i:WDM(\.(b|w|l))?)            return TOKEN(T_WDM);
(?i:XBA(\.(b|w|l))?)            return TOKEN(T_XBA);
(?i:XCE(\.(b|w|l))?)            return TOKEN(T_XCE);
(?i:ORG)                        return TOKEN(T_ORIGIN);
[xyXY]                          SAVE_TOKEN; return TOKEN(T_INDEX);
(?i:a)                          SAVE_TOKEN; return TOKEN(T_ACC);
(?i:s)                          SAVE_TOKEN; return TOKEN(T_STACK);
[a-zA-Z_][a-zA-Z0-9_]*:         SAVE_TOKEN; return TOKEN(T_LABEL);
\.+[a-zA-Z_][a-zA-Z0-9_]*       SAVE_TOKEN; return TOKEN(T_SUBLABEL);
#[a-zA-Z_][a-zA-Z0-9_]*         SAVE_TOKEN; return TOKEN(T_IMMLABEL);
[a-zA-Z_][a-zA-Z0-9_]*          SAVE_TOKEN; return TOKEN(T_IDENT);
$[0-9a-fA-F]+                   SAVE_TOKEN; return TOKEN(T_HEX);
#$[0-9a-fA-F]+                  SAVE_TOKEN; return TOKEN(T_HEXLIT);
%[01]+                          SAVE_TOKEN; return TOKEN(T_BIN);
#%[01]+                         SAVE_TOKEN; return TOKEN(T_BINLIT);
[1-9][0-9]*                     SAVE_TOKEN; return TOKEN(T_ORD);
#[1-9][0-9]*                    SAVE_TOKEN; return TOKEN(T_ORDLIT);
,                               return TOKEN(T_COMMA);
:                               return TOKEN(T_SEPARATOR);
\(                              return TOKEN(T_LPAREN);
\)                              return TOKEN(T_RPAREN);
\[                              return TOKEN(T_LBRACKET);
\]                              return TOKEN(T_RBRACKET);
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
.                               printf("Unknown token! %s %d\n", yytext, yylineno); yyterminate();
%%

void scan_string(const std::string& str)
{
  yy_switch_to_buffer(yy_scan_string(str.c_str()));
  yylineno = 1;
}

void set_base_path(const std::string& path)
{
  base_path = path;
}