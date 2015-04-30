%code requires {
  #include <string>
  #include <iostream>
  #include <map>
  #include <vector>
}

%{
  #include <cstdio>
  #include <vector>
  #include "util.hpp"
  #include "assembler.hpp"

  #define YYDEBUG 1
  extern int yylex();
  extern char * yytext;
  extern int yylineno;

  std::vector<uint8_t> *output = new std::vector<uint8_t>();
  std::string sp = " ";
  std::string nl = "\n";

  void yyerror(const char *s) {
    printf("ERROR: %s\n", s); 
  }
%}

%token <string>  T_IDENT T_LABEL T_HEX T_BIN T_ORD T_HEXLIT T_BINLIT T_ORDLIT T_COMMA T_REG T_SEPARATOR T_LINE T_LPAREN T_RPAREN T_LBRACKET T_RBRACKET T_COMMENT

%token <string>  T_ADC T_AND T_ASL T_BCC T_BCS T_BEQ T_BIT T_BMI T_BNE T_BPL T_BRA T_BRK T_BRL T_BVC T_BVS T_CLC T_CLD T_CLI T_CLV T_CMP T_COP T_CPX T_CPY T_DEC T_DEX T_DEY T_EOR T_INC T_INX T_INY T_JMP T_JSR T_LDA T_LDX T_LDY T_LSR T_MVN T_NOP T_ORA T_PEA T_PEI T_PER T_PHA T_PHB T_PHD T_PHK T_PHP T_PHX T_PHY T_PLA T_PLB T_PLD T_PLP T_PLX T_PLY T_REP T_ROL T_ROR T_RTI T_RTL T_RTS T_SBC T_SEC T_SED T_SEI T_SEP T_STA T_STP T_STX T_STY T_STZ T_TAX T_TAY T_TCD T_TCS T_TDC T_TRB T_TSB T_TSC T_TSX T_TXA T_TXS T_TXY T_TYA T_TYX T_WAI T_WDM T_XBA T_XCE

%union {
    std::string *string;
    std::vector<uint8_t> *vector;
    int token;
    int number;
}

%type <vector> input line expr implied immediate direct indexed indirect
%type <string> instr
%type <number> number immnum
//%type <number> number

%start program

%%
program: input { output = new std::vector<uint8_t>(*$1); }
      ;

input:   /* empty */ { $$ = new std::vector<uint8_t>(); }
      |  input line  { $$ = new std::vector<uint8_t>(*$1); $$->insert($$->end(), $2->begin(), $2->end()); }
      ;

line:   expr                          { $$ = $1; }
      | expr T_SEPARATOR expr T_LINE  { $$ = $1; $$->insert($$->end(), *$3->begin(), *$3->end()); }
      | T_LINE                        { $$ = new std::vector<uint8_t>(); }
      ;

expr:   implied
      | immediate
      | direct
      | indirect
      | indexed
      ;

implied: 
      instr {
        $$ = new std::vector<uint8_t>();
        $$->push_back(yasa::get_byte(*$1, yasa::Implied));
      };

immediate:
      instr immnum { 
        if ($2 > 0xFF)
        {
          std::cout << "Error: Immediate parameter too large (" << static_cast<int>($2) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();
        $$->push_back(yasa::get_byte(*$1, yasa::Immediate));
        $$->push_back($2);

        std::cout << "Bytes: " << static_cast<int>((*$$)[0]) << " " << static_cast<int>((*$$)[1]) << std::endl;
      };

direct:
      instr number { 
        if ($2 > 0xFFFFFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($2) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();

        int bytes = ($2 >> 16) == 0 ? ($2 >> 8) == 0 ? 1 : 2 : 3;

        switch (bytes)
        {
          case 1:
            $$->push_back(yasa::get_byte(*$1, yasa::Direct));
            $$->push_back($2);
            break;
          case 2:
            $$->push_back(yasa::get_byte(*$1, yasa::Absolute));
            $$->push_back($2 & 0xFF);
            $$->push_back($2 >> 8);
            break;
          case 3:
            $$->push_back(yasa::get_byte(*$1, yasa::Absolute_Long));
            $$->push_back($2 & 0xFF);
            $$->push_back(($2 >> 8) & 0xFF);
            $$->push_back($2 >> 16);
            break;
          default:
            std::cout << "Error: Invalid number of bytes (" << bytes << " for max of 3)" << std::endl;
            exit(0);
        }

        std::cout << "Total bytes: " << $$->size() << std::endl;
      };

indirect:
      instr T_LPAREN number T_RPAREN { 
        if ($3 > 0xFFFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();
        $$->push_back(yasa::get_byte(*$1, yasa::Indirect));
        $$->push_back($3);
      };

indexed:
      instr number T_COMMA T_REG {
        if ($2 > 0xFFFFFF) 
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($2) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();
        yasa::AddressMode mode = yasa::Invalid;

        if (*$4 == "X")
        {
          $$->push_back(yasa::get_byte(*$1, yasa::Immediate));
        }
        else if (*$4 == "Y")
        {
          $$->push_back(yasa::get_byte(*$1, yasa::Immediate));
        }
      };

number: T_HEX         { $$ = strtol(yytext + 1, NULL, 16);  }
      | T_ORD         { $$ = strtol(yytext + 0, NULL, 10);  }
      | T_BIN         { $$ = strtol(yytext + 1, NULL, 2);   }
      ;

immnum: T_HEXLIT      { $$ = strtol(yytext + 2, NULL, 16);  }
      | T_ORDLIT      { $$ = strtol(yytext + 1, NULL, 10);  }
      | T_BINLIT      { $$ = strtol(yytext + 2, NULL, 2);   }
      ;

instr:  T_ADC         { $$ = new std::string("ADC"); }
      | T_AND         { $$ = new std::string("AND"); }
      | T_ASL         { $$ = new std::string("ASL"); }
      | T_BCC         { $$ = new std::string("BCC"); }
      | T_BCS         { $$ = new std::string("BCS"); }
      | T_BEQ         { $$ = new std::string("BEQ"); }
      | T_BIT         { $$ = new std::string("BIT"); }
      | T_BMI         { $$ = new std::string("BMI"); }
      | T_BNE         { $$ = new std::string("BNE"); }
      | T_BPL         { $$ = new std::string("BPL"); }
      | T_BRA         { $$ = new std::string("BRA"); }
      | T_BRK         { $$ = new std::string("BRK"); }
      | T_BRL         { $$ = new std::string("BRL"); }
      | T_BVC         { $$ = new std::string("BVC"); }
      | T_BVS         { $$ = new std::string("BVS"); }
      | T_CLC         { $$ = new std::string("CLC"); }
      | T_CLD         { $$ = new std::string("CLD"); }
      | T_CLI         { $$ = new std::string("CLI"); }
      | T_CLV         { $$ = new std::string("CLV"); }
      | T_CMP         { $$ = new std::string("CMP"); }
      | T_COP         { $$ = new std::string("COP"); }
      | T_CPX         { $$ = new std::string("CPX"); }
      | T_CPY         { $$ = new std::string("CPY"); }
      | T_DEC         { $$ = new std::string("DEC"); }
      | T_DEX         { $$ = new std::string("DEX"); }
      | T_DEY         { $$ = new std::string("DEY"); }
      | T_EOR         { $$ = new std::string("EOR"); }
      | T_INC         { $$ = new std::string("INC"); }
      | T_INX         { $$ = new std::string("INX"); }
      | T_INY         { $$ = new std::string("INY"); }
      | T_JMP         { $$ = new std::string("JMP"); }
      | T_JSR         { $$ = new std::string("JSR"); }
      | T_LDA         { $$ = new std::string("LDA"); }
      | T_LDX         { $$ = new std::string("LDX"); }
      | T_LDY         { $$ = new std::string("LDY"); }
      | T_LSR         { $$ = new std::string("LSR"); }
      | T_MVN         { $$ = new std::string("MVN"); }
      | T_NOP         { $$ = new std::string("NOP"); }
      | T_ORA         { $$ = new std::string("ORA"); }
      | T_PEA         { $$ = new std::string("PEA"); }
      | T_PEI         { $$ = new std::string("PEI"); }
      | T_PER         { $$ = new std::string("PER"); }
      | T_PHA         { $$ = new std::string("PHA"); }
      | T_PHB         { $$ = new std::string("PHB"); }
      | T_PHD         { $$ = new std::string("PHD"); }
      | T_PHK         { $$ = new std::string("PHK"); }
      | T_PHP         { $$ = new std::string("PHP"); }
      | T_PHX         { $$ = new std::string("PHX"); }
      | T_PHY         { $$ = new std::string("PHY"); }
      | T_PLA         { $$ = new std::string("PLA"); }
      | T_PLB         { $$ = new std::string("PLB"); }
      | T_PLD         { $$ = new std::string("PLD"); }
      | T_PLP         { $$ = new std::string("PLP"); }
      | T_PLX         { $$ = new std::string("PLX"); }
      | T_PLY         { $$ = new std::string("PLY"); }
      | T_REP         { $$ = new std::string("REP"); }
      | T_ROL         { $$ = new std::string("ROL"); }
      | T_ROR         { $$ = new std::string("ROR"); }
      | T_RTI         { $$ = new std::string("RTI"); }
      | T_RTL         { $$ = new std::string("RTL"); }
      | T_RTS         { $$ = new std::string("RTS"); }
      | T_SBC         { $$ = new std::string("SBC"); }
      | T_SEC         { $$ = new std::string("SEC"); }
      | T_SED         { $$ = new std::string("SED"); }
      | T_SEI         { $$ = new std::string("SEI"); }
      | T_SEP         { $$ = new std::string("SEP"); }
      | T_STA         { $$ = new std::string("STA"); }
      | T_STP         { $$ = new std::string("STP"); }
      | T_STX         { $$ = new std::string("STX"); }
      | T_STY         { $$ = new std::string("STY"); }
      | T_STZ         { $$ = new std::string("STZ"); }
      | T_TAX         { $$ = new std::string("TAX"); }
      | T_TAY         { $$ = new std::string("TAY"); }
      | T_TCD         { $$ = new std::string("TCD"); }
      | T_TCS         { $$ = new std::string("TCS"); }
      | T_TDC         { $$ = new std::string("TDC"); }
      | T_TRB         { $$ = new std::string("TRB"); }
      | T_TSB         { $$ = new std::string("TSB"); }
      | T_TSC         { $$ = new std::string("TSC"); }
      | T_TSX         { $$ = new std::string("TSX"); }
      | T_TXA         { $$ = new std::string("TXA"); }
      | T_TXS         { $$ = new std::string("TXS"); }
      | T_TXY         { $$ = new std::string("TXY"); }
      | T_TYA         { $$ = new std::string("TYA"); }
      | T_TYX         { $$ = new std::string("TYX"); }
      | T_WAI         { $$ = new std::string("WAI"); }
      | T_WDM         { $$ = new std::string("WDM"); }
      | T_XBA         { $$ = new std::string("XBA"); }
      | T_XCE         { $$ = new std::string("XCE"); }
      ;
%%
