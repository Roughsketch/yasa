%code requires {
  #include <string>
  #include <iostream>
  #include <map>
  #include <vector>

  #include "assembler.hpp"
}

%{
  #include <cstdio>
  #include <vector>
  #include <map>
  #include <cstring>
  #include "util.hpp"

  #define YYDEBUG 1
  extern int yylex();
  extern char * yytext;
  extern int yylineno;

  std::vector<uint8_t> *output = new std::vector<uint8_t>();
  int snespos = 0;
  std::map<std::string, int> labels;

  std::string sp = " ";
  std::string nl = "\n";

  void yyerror(const char *s) {
    printf("ERROR: %s %d\n", s, yylineno); 
  }
%}

%token <string>  T_IDENT T_LABEL T_HEX T_BIN T_ORD T_HEXLIT T_BINLIT T_ORDLIT T_COMMA T_SEPARATOR T_LINE T_LPAREN T_RPAREN T_LBRACKET T_RBRACKET T_COMMENT

%token <string>  T_ADC T_AND T_ASL T_BCC T_BCS T_BEQ T_BIT T_BMI T_BNE T_BPL T_BRA T_BRK T_BRL T_BVC T_BVS T_CLC T_CLD T_CLI T_CLV T_CMP T_COP T_CPX T_CPY T_DEC T_DEX T_DEY T_EOR T_INC T_INX T_INY T_JML T_JMP T_JSR T_LDA T_LDX T_LDY T_LSR T_MVN T_MVP T_NOP T_ORA T_PEA T_PEI T_PER T_PHA T_PHB T_PHD T_PHK T_PHP T_PHX T_PHY T_PLA T_PLB T_PLD T_PLP T_PLX T_PLY T_REP T_ROL T_ROR T_RTI T_RTL T_RTS T_SBC T_SEC T_SED T_SEI T_SEP T_STA T_STP T_STX T_STY T_STZ T_TAX T_TAY T_TCD T_TCS T_TDC T_TRB T_TSB T_TSC T_TSX T_TXA T_TXS T_TXY T_TYA T_TYX T_WAI T_WDM T_XBA T_XCE

%token <string> T_ACC T_STACK T_INDEX

%union {
    std::string *string;
    std::vector<uint8_t> *vector;
    int token;
    yasa::Integer *number;
    yasa::Instruction *instruction;
}

%type <vector> input line expr implied immediate direct indexed indirect indirect_indexed stack_relative stack_relative_indirect accumulator indirect_long block temp_label 
%type <string> instr index stack accum
%type <number> number immnum
//%type <number> number

%start program

%%
program: input { output = new std::vector<uint8_t>(*$1); }
      ;

input:   /* empty */ { $$ = new std::vector<uint8_t>(); }
      |  input line  { $$ = new std::vector<uint8_t>(*$1); $$->insert($$->end(), $2->begin(), $2->end()); }
      ;

line:   expr                          { $$ = $1; snespos += $1->size(); }
      | expr T_SEPARATOR expr T_LINE  { $$ = $1; $$->insert($$->end(), *$3->begin(), *$3->end()); snespos += $$->size(); }
      | T_LINE                        { $$ = new std::vector<uint8_t>(); }
      | T_LABEL                       { $$ = new std::vector<uint8_t>(); labels[std::string(yytext)] = snespos; }
      ;

expr:   implied
      | immediate
      | direct
      | indirect
      | indexed
      | indirect_indexed
      | stack_relative
      | stack_relative_indirect
      | accumulator
      | indirect_long
      | block
      | temp_label
      ;

temp_label:
      instr T_IDENT {
        $$ = new std::vector<uint8_t>();
      }

implied: 
      instr {
        puts("Implied");
        $$ = new std::vector<uint8_t>();
        $$->push_back(yasa::get_byte(*$1, yasa::Implied));

        //  If op was an implied BRK or COP, then push back another 0
        if ((*$$)[0] == 0x00 || (*$$)[0] == 0x02 || (*$$)[0] == 0x42)
        {
          $$->push_back(0);
        }

        for (int i = 0; i < $$->size(); i++)
        {
          std::cout << static_cast<int>((*$$)[i]) << " ";
        }
        std::cout << std::endl;
      };

immediate:
      instr immnum { 
        puts("Immediate");
        std::cout << "Size: " << $2->size() << std::endl;
        int value = $2->value();
        if (value > 0xFFFF)
        {
          std::cout << "Error: Immediate parameter too large (" << static_cast<int>(value) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();
        $$->push_back(yasa::get_byte(*$1, yasa::Immediate));

        switch ($2->size())
        {
          case 1:
            $$->push_back(value);
            break;
          case 2:
            $$->push_back(value & 0xFF);
            $$->push_back(value >> 8);
            break;
          default:
            std::cout << "Error: Invalid number of bytes (" << $2->size() << " for max of 3)" << std::endl;
            exit(0);
        }

        for (int i = 0; i < $$->size(); i++)
        {
          std::cout << static_cast<int>((*$$)[i]) << " ";
        }
        std::cout << std::endl;
      };

direct:
      instr number { 
        puts("Direct");
        int value = $2->value();

        if (value > 0xFFFFFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>(value) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();


        switch ($2->size())
        {
          case 1:
            $$->push_back(yasa::get_byte(*$1, yasa::Direct));
            $$->push_back(value);
            break;
          case 2:
            $$->push_back(yasa::get_byte(*$1, yasa::Absolute));
            $$->push_back(value & 0xFF);
            $$->push_back(value >> 8);
            break;
          case 3:
            $$->push_back(yasa::get_byte(*$1, yasa::Absolute_Long));
            $$->push_back(value & 0xFF);
            $$->push_back((value >> 8) & 0xFF);
            $$->push_back(value >> 16);
            break;
          default:
            std::cout << "Error: Invalid number of bytes (" << $2->size() << " for max of 3)" << std::endl;
            exit(0);
        }

        for (int i = 0; i < $$->size(); i++)
        {
          std::cout << static_cast<int>((*$$)[i]) << " ";
        }
        std::cout << std::endl;
      };

indirect:
      instr T_LPAREN number T_RPAREN { 
        puts("Indirect");
        if ($3->value() > 0xFFFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();
        $$->push_back(yasa::get_byte(*$1, yasa::Indirect));
        $$->push_back($3->value());

        for (int i = 0; i < $$->size(); i++)
        {
          std::cout << static_cast<int>((*$$)[i]) << " ";
        }
        std::cout << std::endl;
      };

indexed:
      instr number T_COMMA index {
        puts("Indexed");
        int value = $2->value();
        int size = $2->size();

        if (value > 0xFFFFFF) 
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>(value) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();
        yasa::AddressMode mode = yasa::Invalid;

        if (*$4 == "X")
        {
          if (size == 1)
          {
            $$->push_back(yasa::get_byte(*$1, yasa::Direct_X)); 
          }
          else if (size == 2)
          {
            $$->push_back(yasa::get_byte(*$1, yasa::Absolute_X)); 
          }
          else if (size == 3)
          {
            $$->push_back(yasa::get_byte(*$1, yasa::Absolute_Long_X));
          }
          else
          {
            std::cout << "Error: byte size too big for X indexed call (line " << yylineno << ")" << std::endl;
          }
        }
        else if (*$4 == "Y")
        {
          if (size == 1)
          {
            $$->push_back(yasa::get_byte(*$1, yasa::Direct_Y)); 
          }
          else if (size == 2)
          {
            $$->push_back(yasa::get_byte(*$1, yasa::Absolute_Y)); 
          }
          else
          {
            std::cout << "Error: byte size too big for Y indexed call (line " << yylineno << ")" << std::endl;
          }
        }
        
        for (int i = 0; i < size; i++)
        {
          $$->push_back((value >> (i * 8)) & 0xFF);
        }

        for (int i = 0; i < $$->size(); i++)
        {
          std::cout << static_cast<int>((*$$)[i]) << " ";
        }
        std::cout << std::endl;
      };

indirect_indexed:
        instr T_LPAREN number T_COMMA index T_RPAREN {
          puts("Indirect Indexed");
          if ($3->value() > 0xFF)
          {
            std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
            exit(0);
          }

          $$ = new std::vector<uint8_t>();
          yasa::AddressMode mode = yasa::Invalid;


          if (*$5 == "X")
          {
            std::cout << "Indirect Indexed X: " << static_cast<int>(yasa::get_byte(*$1, yasa::Indirect_X)) << std::endl;
            $$->push_back(yasa::get_byte(*$1, yasa::Indirect_X));
          }
          else if (*$5 == "Y")
          {
            std::cout << "Indirect Indexed Y: " << static_cast<int>(yasa::get_byte(*$1, yasa::Indirect_Y)) << std::endl;
            $$->push_back(yasa::get_byte(*$1, yasa::Indirect_Y));
          }

          $$->push_back($3->value());
          
          for (int i = 0; i < $$->size(); i++)
          {
            std::cout << static_cast<int>((*$$)[i]) << " ";
          }
          std::cout << std::endl;
        }
      | instr T_LPAREN number T_RPAREN T_COMMA index {
          puts("Indirect Indexed");
          if ($3->value() > 0xFF)
          {
            std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
            exit(0);
          }

          $$ = new std::vector<uint8_t>();
          yasa::AddressMode mode = yasa::Invalid;

          if (*$6 == "Y")
          {
            std::cout << "Indirect Indexed Y: " << static_cast<int>(yasa::get_byte(*$1, yasa::Indirect_Y)) << std::endl;
            $$->push_back(yasa::get_byte(*$1, yasa::Indirect_Y));
          }
          else
          {
            std::cout << "Error: non-Y register used with indirect indexed mode. (line " << yylineno << ")" << std::endl;
            exit(0);
          }

          $$->push_back($3->value());
          
          for (int i = 0; i < $$->size(); i++)
          {
            std::cout << static_cast<int>((*$$)[i]) << " ";
          }
          std::cout << std::endl;
        }
      ;

stack_relative:
      instr number T_COMMA stack {
        puts("Stack Relative");
        if ($2->value() > 0xFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($2->value()) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();

        $$->push_back(yasa::get_byte(*$1, yasa::Stack));
        $$->push_back($2->value());
      }
      ;

stack_relative_indirect:
      instr T_LPAREN number T_COMMA stack T_RPAREN T_COMMA index {
        puts("Stack Relative Indirect");
        if ($3->value() > 0xFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();

        if (*$8 == "Y")
        {
          $$->push_back(yasa::get_byte(*$1, yasa::Stack_Y));
          $$->push_back($3->value());
        }
        else
        {
          std::cout << "Error: non-Y register used with stack relative indirect indexed mode. (line " << yylineno << ")" << std::endl;
          exit(0);
        }
      }
      ;

accumulator:
      instr accum {
        puts("Accumulator");
        $$ = new std::vector<uint8_t>();

        $$->push_back(yasa::get_byte(*$1, yasa::Accumulator));
      }
      ;

indirect_long:
        instr T_LBRACKET number T_RBRACKET {
          puts("Indirect Long");
          if ($3->value() > 0xFF)
          {
            std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
            exit(0);
          }

          $$ = new std::vector<uint8_t>();

          $$->push_back(yasa::get_byte(*$1, yasa::Indirect_Long));
          $$->push_back($3->value());
        }
      | instr T_LBRACKET number T_RBRACKET T_COMMA index {
          puts("Indirect Long");
          if ($3->value() > 0xFF)
          {
            std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
            exit(0);
          }

          $$ = new std::vector<uint8_t>();

          if (*$6 == "Y")
          {
            $$->push_back(yasa::get_byte(*$1, yasa::Indirect_Long_Y));
            $$->push_back($3->value());
          }
          else
          {
            std::cout << "Error: non-Y register used with indirect indexed mode. (line " << yylineno << ")" << std::endl;
            exit(0);
          }

        }
      ;

block:
      instr number T_COMMA number {
        puts("Block");
        if ($2->value() > 0xFF || $4->value() > 0xFF)
        {
          std::cout << "Error: parameter for block bigger than allowed size of 1 byte. (line " << yylineno << ")" << std::endl;
          exit(0);
        }

        $$ = new std::vector<uint8_t>();

        $$->push_back(yasa::get_byte(*$1, yasa::Block));
        $$->push_back($2->value());
        $$->push_back($4->value());
      };

number: T_HEX         { $$ = new yasa::Integer(yytext + 1, 16); }
      | T_ORD         { $$ = new yasa::Integer(yytext + 0, 10); }
      | T_BIN         { $$ = new yasa::Integer(yytext + 1, 2);  }
      ;

immnum: T_HEXLIT      { $$ = new yasa::Integer(yytext + 2, 16);  }
      | T_ORDLIT      { $$ = new yasa::Integer(yytext + 1, 10);  }
      | T_BINLIT      { $$ = new yasa::Integer(yytext + 2, 2);   }
      ;

index:  T_INDEX       {
          if (yytext[0] == 'X' || yytext[0] == 'x')
          {
            $$ = new std::string("X");
          }
          else if (yytext[0] == 'Y' || yytext[0] == 'y')
          {
            $$ = new std::string("Y");
          }
          else
          {
            std::cout << "Error: Invalid index register " << yytext << " (line " << yylineno << ")" << std::endl;
          }
        }
      ;

accum:  T_ACC         { $$ = new std::string("A"); }
      ;

stack:  T_STACK       { $$ = new std::string("S"); }
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
      | T_JML         { $$ = new std::string("JMP"); }
      | T_JMP         { $$ = new std::string("JMP"); }
      | T_JSR         { $$ = new std::string("JSR"); }
      | T_LDA         { $$ = new std::string("LDA"); }
      | T_LDX         { $$ = new std::string("LDX"); }
      | T_LDY         { $$ = new std::string("LDY"); }
      | T_LSR         { $$ = new std::string("LSR"); }
      | T_MVN         { $$ = new std::string("MVN"); }
      | T_MVP         { $$ = new std::string("MVP"); }
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
