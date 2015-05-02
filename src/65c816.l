%{
  #include <string>
  #include "parser.hpp"

  #define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
  #define TOKEN(t)    (yylval.token = t)
%}

%option yylineno
%option noyywrap

%%

[ \t]*                          ;
\n                              return TOKEN(T_LINE);
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
[a-zA-Z_][a-zA-Z0-9_]*:         SAVE_TOKEN; return TOKEN(T_LABEL);
\.+[a-zA-Z_][a-zA-Z0-9_]*       SAVE_TOKEN; return TOKEN(T_SUBLABEL);
[xyXY]                          SAVE_TOKEN; return TOKEN(T_INDEX);
(?i:a)                          SAVE_TOKEN; return TOKEN(T_ACC);
(?i:s)                          SAVE_TOKEN; return TOKEN(T_STACK);
[a-zA-Z_][a-zA-Z0-9_]*          SAVE_TOKEN; return TOKEN(T_IDENT);
$[0-9a-fA-F]+                   SAVE_TOKEN; return TOKEN(T_HEX);
#$[0-9a-fA-F]+                  SAVE_TOKEN; return TOKEN(T_HEXLIT);
%[01]+                          SAVE_TOKEN; return TOKEN(T_BIN);
#%[01]+                         SAVE_TOKEN; return TOKEN(T_BINLIT);
[1-9]\d*                        SAVE_TOKEN; return TOKEN(T_ORD);
#[1-9]\d*                       SAVE_TOKEN; return TOKEN(T_ORDLIT);
,                               return TOKEN(T_COMMA);
:                               return TOKEN(T_SEPARATOR);
\(                              return TOKEN(T_LPAREN);
\)                              return TOKEN(T_RPAREN);
\[                              return TOKEN(T_LBRACKET);
\]                              return TOKEN(T_RBRACKET);
;.*                             ;
.                               printf("Unknown token! %s\n", yytext); yyterminate();
%%

void scan_string(const std::string& str)
{
  yy_switch_to_buffer(yy_scan_string(str.c_str()));
  yylineno = 1;
}