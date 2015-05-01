%{
  #include <string>
  #include "parser.hpp"

  #define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
  #define TOKEN(t)    (yylval.token = t)
%}

%option yylineno
%option noyywrap

%%

[ \t]*                      ;
\n                          return TOKEN(T_LINE);
(?i:ADC)                    return TOKEN(T_ADC);
(?i:AND)                    return TOKEN(T_AND);
(?i:ASL)                    return TOKEN(T_ASL);
(?i:BCC)                    return TOKEN(T_BCC);
(?i:BCS)                    return TOKEN(T_BCS);
(?i:BEQ)                    return TOKEN(T_BEQ);
(?i:BIT)                    return TOKEN(T_BIT);
(?i:BMI)                    return TOKEN(T_BMI);
(?i:BNE)                    return TOKEN(T_BNE);
(?i:BPL)                    return TOKEN(T_BPL);
(?i:BRA)                    return TOKEN(T_BRA);
(?i:BRK)                    return TOKEN(T_BRK);
(?i:BRL)                    return TOKEN(T_BRL);
(?i:BVC)                    return TOKEN(T_BVC);
(?i:BVS)                    return TOKEN(T_BVS);
(?i:CLC)                    return TOKEN(T_CLC);
(?i:CLD)                    return TOKEN(T_CLD);
(?i:CLI)                    return TOKEN(T_CLI);
(?i:CLV)                    return TOKEN(T_CLV);
(?i:CMP)                    return TOKEN(T_CMP);
(?i:COP)                    return TOKEN(T_COP);
(?i:CPX)                    return TOKEN(T_CPX);
(?i:CPY)                    return TOKEN(T_CPY);
(?i:DEC)                    return TOKEN(T_DEC);
(?i:DEX)                    return TOKEN(T_DEX);
(?i:DEY)                    return TOKEN(T_DEY);
(?i:EOR)                    return TOKEN(T_EOR);
(?i:INC)                    return TOKEN(T_INC);
(?i:INX)                    return TOKEN(T_INX);
(?i:INY)                    return TOKEN(T_INY);
(?i:JML)                    return TOKEN(T_JML);  //  Special case of JMP
(?i:JMP)                    return TOKEN(T_JMP);
(?i:JSL)                    return TOKEN(T_JSR);  //  Special case of JSR
(?i:JSR)                    return TOKEN(T_JSR);
(?i:LDA)                    return TOKEN(T_LDA);
(?i:LDX)                    return TOKEN(T_LDX);
(?i:LDY)                    return TOKEN(T_LDY);
(?i:LSR)                    return TOKEN(T_LSR);
(?i:MVN)                    return TOKEN(T_MVN);
(?i:MVP)                    return TOKEN(T_MVP);  //  Special case of MVN
(?i:NOP)                    return TOKEN(T_NOP);
(?i:ORA)                    return TOKEN(T_ORA);
(?i:PEA)                    return TOKEN(T_PEA);
(?i:PEI)                    return TOKEN(T_PEI);
(?i:PER)                    return TOKEN(T_PER);
(?i:PHA)                    return TOKEN(T_PHA);
(?i:PHB)                    return TOKEN(T_PHB);
(?i:PHD)                    return TOKEN(T_PHD);
(?i:PHK)                    return TOKEN(T_PHK);
(?i:PHP)                    return TOKEN(T_PHP);
(?i:PHX)                    return TOKEN(T_PHX);
(?i:PHY)                    return TOKEN(T_PHY);
(?i:PLA)                    return TOKEN(T_PLA);
(?i:PLB)                    return TOKEN(T_PLB);
(?i:PLD)                    return TOKEN(T_PLD);
(?i:PLP)                    return TOKEN(T_PLP);
(?i:PLX)                    return TOKEN(T_PLX);
(?i:PLY)                    return TOKEN(T_PLY);
(?i:REP)                    return TOKEN(T_REP);
(?i:ROL)                    return TOKEN(T_ROL);
(?i:ROR)                    return TOKEN(T_ROR);
(?i:RTI)                    return TOKEN(T_RTI);
(?i:RTL)                    return TOKEN(T_RTL);
(?i:RTS)                    return TOKEN(T_RTS);
(?i:SBC)                    return TOKEN(T_SBC);
(?i:SEC)                    return TOKEN(T_SEC);
(?i:SED)                    return TOKEN(T_SED);
(?i:SEI)                    return TOKEN(T_SEI);
(?i:SEP)                    return TOKEN(T_SEP);
(?i:STA)                    return TOKEN(T_STA);
(?i:STP)                    return TOKEN(T_STP);
(?i:STX)                    return TOKEN(T_STX);
(?i:STY)                    return TOKEN(T_STY);
(?i:STZ)                    return TOKEN(T_STZ);
(?i:TAX)                    return TOKEN(T_TAX);
(?i:TAY)                    return TOKEN(T_TAY);
(?i:TCD)                    return TOKEN(T_TCD);
(?i:TCS)                    return TOKEN(T_TCS);
(?i:TDC)                    return TOKEN(T_TDC);
(?i:TRB)                    return TOKEN(T_TRB);
(?i:TSB)                    return TOKEN(T_TSB);
(?i:TSC)                    return TOKEN(T_TSC);
(?i:TSX)                    return TOKEN(T_TSX);
(?i:TXA)                    return TOKEN(T_TXA);
(?i:TXS)                    return TOKEN(T_TXS);
(?i:TXY)                    return TOKEN(T_TXY);
(?i:TYA)                    return TOKEN(T_TYA);
(?i:TYX)                    return TOKEN(T_TYX);
(?i:WAI)                    return TOKEN(T_WAI);
(?i:WDM)                    return TOKEN(T_WDM);
(?i:XBA)                    return TOKEN(T_XBA);
(?i:XCE)                    return TOKEN(T_XCE);
[a-zA-Z_][a-zA-Z0-9_]*:     SAVE_TOKEN; puts("T_LABEL"); return TOKEN(T_LABEL);
[xyXY]                      SAVE_TOKEN; puts("T_INDEX");  return TOKEN(T_INDEX);
(?i:a)                      SAVE_TOKEN; puts("T_ACC"); return TOKEN(T_ACC);
(?i:s)                      SAVE_TOKEN; puts("T_STACK"); return TOKEN(T_STACK);
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
;.*                         ;
.                           printf("Unknown token! %s\n", yytext); yyterminate();
%%

void scan_string(const std::string& str)
{
  yy_switch_to_buffer(yy_scan_string(str.c_str()));
}