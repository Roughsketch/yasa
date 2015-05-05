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
  #include <stack>
  #include <string>

  #include "util.hpp"
  #include "assembler.hpp"

  #define YYDEBUG 1
  extern int yylex();
  extern char * yytext;
  extern int yylineno;

  int snespos = 0;
  auto *output = new std::vector<yasa::Instruction>();
  std::vector<std::string> label_ids;
  std::map<std::string, int> labels;

  int minus_label = 0;  //  Address of last - label

  void yyerror(const char *s) {
    printf("ERROR: %s (line %d)\n", s, yylineno); 
  }
%}

//  Names / Labels
%token <string>   T_IDENT T_LABEL T_SUBLABEL T_IMMLABEL

//  Symbols
%token <string>   T_COMMA T_SEPARATOR T_LINE T_LPAREN T_RPAREN T_LBRACKET T_RBRACKET

//  Numbers
%token <string>   T_HEX T_BIN T_ORD T_HEXLIT T_BINLIT T_ORDLIT

//  Instructions
%token <string>   T_ADC T_AND T_ASL T_BCC T_BCS T_BEQ T_BIT T_BMI
%token <string>   T_BNE T_BPL T_BRA T_BRK T_BRL T_BVC T_BVS T_CLC
%token <string>   T_CLD T_CLI T_CLV T_CMP T_COP T_CPX T_CPY T_DEC 
%token <string>   T_DEX T_DEY T_EOR T_INC T_INX T_INY T_JML T_JMP 
%token <string>   T_JSR T_LDA T_LDX T_LDY T_LSR T_MVN T_MVP T_NOP 
%token <string>   T_ORA T_PEA T_PEI T_PER T_PHA T_PHB T_PHD T_PHK 
%token <string>   T_PHP T_PHX T_PHY T_PLA T_PLB T_PLD T_PLP T_PLX 
%token <string>   T_PLY T_REP T_ROL T_ROR T_RTI T_RTL T_RTS T_SBC 
%token <string>   T_SEC T_SED T_SEI T_SEP T_STA T_STP T_STX T_STY 
%token <string>   T_STZ T_TAX T_TAY T_TCD T_TCS T_TDC T_TRB T_TSB 
%token <string>   T_TSC T_TSX T_TXA T_TXS T_TXY T_TYA T_TYX T_WAI 
%token <string>   T_WDM T_XBA T_XCE

//  Registers
%token <string>   T_ACC T_STACK T_INDEX 

//  Assembler commands
%token <string>   T_ORIGIN T_DEFINE

//  Math
%token <string>   T_RSHIFT T_LSHIFT T_PLUS T_MINUS T_MULT T_DIV T_MOD T_LOGAND T_LOGOR T_LOGXOR T_LOGNOT T_EQUAL

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
    std::vector<uint8_t> *vector;
    int token;
    yasa::Integer *number;
    yasa::Instruction *instruction;
    std::vector<yasa::Instruction> *instrvec;
}

%type <instrvec>    input line
%type <instruction> expr implied immediate direct indexed indirect indirect_indexed stack_relative stack_relative_indirect accumulator indirect_long block temp_label 
%type <string>      instr index stack accum define label
%type <number>      number immnum
//%type <number> number

%start program

%%
program: input { output = new std::vector<yasa::Instruction>(*$1); }
      ;

input:  /* empty */ { $$ = new std::vector<yasa::Instruction>(); }
      | input line  {
          $$ = new std::vector<yasa::Instruction>(*$1);
          $$->insert($$->end(), $2->begin(), $2->end()); 
        }
      | input label { 
          $$ = $1;

          labels[*$2] = snespos;
        }
      | input command { 
          $$ = $1; 
        }
      | input define T_EQUAL number { 
          $$ = $1;

          std::cout << "Got here" << std::endl;
          std::cout << *$2 << " = " << *$4 << std::endl;
        }
      ;

line:   expr {
          $$ = new std::vector<yasa::Instruction>();
          $$->push_back(*$1); snespos += $1->size(); 
        }
      | expr T_SEPARATOR expr T_LINE {
          $$ = new std::vector<yasa::Instruction>();
          $$->push_back(*$1); 
          $$->push_back(*$3); 
          snespos += $1->size() + $3->size();
        }
      | T_LINE { 
          $$ = new std::vector<yasa::Instruction>();
        }
      ;

define: T_DEFINE { $$ = new std::string(yytext); }

command:
        T_ORIGIN number {
          std::cout << "Setting origin to " << *$2 << std::endl;
          snespos = *$2;
        }
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
        $$ = new yasa::Instruction(*$1, yasa::Label, snespos);
        $$->set_label(yytext);
      }
      ;

implied: 
      instr {
        // puts("Implied");
        $$ = new yasa::Instruction(*$1, yasa::Implied, snespos);

        //  If op was an implied BRK or COP, then push back another 0
        switch ($$->opcode())
        {
          case 0x00:  // BRK
          case 0x02:  // COP
          case 0x42:  // WDM
            $$->add(new yasa::Integer("0"));
            break;
        }
      };

immediate:
      instr immnum { 
        // puts("Immediate");
        int value = $2->value();

        if ($2->size() > 2)
        {
          std::cout << "Error: Immediate parameter too large (" << static_cast<int>(value) << ") line " << yylineno << std::endl;
          YYABORT;
        }

        $$ = new yasa::Instruction(*$1, yasa::Immediate, snespos);
        $$->add($2);
      };

direct:
      instr number { 
        // puts("Direct");
        int value = $2->value();
        int size = $2->size();

        if ($2->size() > 3)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>(value) << ") line " << yylineno << std::endl;
          YYABORT;
        }

        auto mode = size == 1 ? yasa::Direct : size == 2 ? yasa::Absolute : yasa::Absolute_Long;

        $$ = new yasa::Instruction(*$1, mode, snespos);
        $$->add($2);
      };

indirect:
      instr T_LPAREN number T_RPAREN { 
        // puts("Indirect");
        if ($3->value() > 0xFFFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
          YYABORT;
        }

        $$ = new yasa::Instruction(*$1, yasa::Indirect, snespos);
        $$->add($3);
      };

indexed:
      instr number T_COMMA index {
        // puts("Indexed");
        int value = $2->value();
        int size = $2->size();

        if (value > 0xFFFFFF) 
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>(value) << ") line " << yylineno << std::endl;
          YYABORT;
        }

        if (*$4 == "X")
        {
          
          auto mode = size == 1 ? yasa::Direct_X : size == 2 ? yasa::Absolute_X : yasa::Absolute_Long_X;
          $$ = new yasa::Instruction(*$1, mode, snespos);
          $$->add($2);
        }
        else if (*$4 == "Y")
        {
          if (size > 2)
          {
            std::cout << "Error: byte size too big for Y indexed call (line " << yylineno << ")" << std::endl;
          }

          auto mode = size == 1 ? yasa::Direct_Y : yasa::Absolute_Y;
          $$ = new yasa::Instruction(*$1, mode, snespos);
          $$->add($2);
        }
      };

indirect_indexed:
        instr T_LPAREN number T_COMMA index T_RPAREN {
          // puts("Indirect Indexed");
          if ($3->value() > 0xFF)
          {
            std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
            YYABORT;
          }

          $$ = new yasa::Instruction(*$1, *$5 == "X" ? yasa::Indirect_X : yasa::Indirect_Y, snespos);
          $$->add($3);
        }
      | instr T_LPAREN number T_RPAREN T_COMMA index {
          // puts("Indirect Indexed");
          if ($3->value() > 0xFF)
          {
            std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
            YYABORT;
          }


          if (*$6 == "Y")
          {
            $$ = new yasa::Instruction(*$1, yasa::Indirect_Y, snespos);
            $$->add($3);
          }
          else
          {
            std::cout << "Error: non-Y register used with indirect indexed mode. (line " << yylineno << ")" << std::endl;
            YYABORT;
          }
        }
      ;

stack_relative:
      instr number T_COMMA stack {
        // puts("Stack Relative");
        if ($2->value() > 0xFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($2->value()) << ") line " << yylineno << std::endl;
          YYABORT;
        }

        $$ = new yasa::Instruction(*$1, yasa::Stack, snespos);
        $$->add($2);
      }
      ;

stack_relative_indirect:
      instr T_LPAREN number T_COMMA stack T_RPAREN T_COMMA index {
        // puts("Stack Relative Indirect");
        if ($3->value() > 0xFF)
        {
          std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
          YYABORT;
        }

        if (*$8 == "Y")
        {
          $$ = new yasa::Instruction(*$1, yasa::Stack_Y, snespos);
          $$->add($3);
        }
        else
        {
          std::cout << "Error: non-Y register used with stack relative indirect indexed mode. (line " << yylineno << ")" << std::endl;
          YYABORT;
        }
      }
      ;

accumulator:
      instr accum {
        // puts("Accumulator");

        $$ = new yasa::Instruction(*$1, yasa::Accumulator, snespos);
      }
      ;

indirect_long:
        instr T_LBRACKET number T_RBRACKET {
          // puts("Indirect Long");

          if ($3->value() > 0xFF)
          {
            std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
            YYABORT;
          }

          $$ = new yasa::Instruction(*$1, yasa::Indirect_Long, snespos);
          $$->add($3);
        }
      | instr T_LBRACKET number T_RBRACKET T_COMMA index {
          // puts("Indirect Long");
          if ($3->value() > 0xFF)
          {
            std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
            YYABORT;
          }

          if (*$6 == "Y")
          {
            $$ = new yasa::Instruction(*$1, yasa::Indirect_Long_Y, snespos);
            $$->add($3);
          }
          else
          {
            std::cout << "Error: non-Y register used with indirect indexed mode. (line " << yylineno << ")" << std::endl;
            YYABORT;
          }

        }
      ;

block:
      instr number T_COMMA number {
        // puts("Block");

        if ($2->value() > 0xFF || $4->value() > 0xFF)
        {
          std::cout << "Error: parameter for block bigger than allowed size of 1 byte. (line " << yylineno << ")" << std::endl;
          YYABORT;
        }

        $$ = new yasa::Instruction(*$1, yasa::Block, snespos);
        $$->add($2);
        $$->add($4);
      };

number: number T_PLUS number    { $$ = new yasa::Integer(*$1 + *$3); }
      | number T_MINUS number   { $$ = new yasa::Integer(*$1 - *$3); }
      | number T_MULT number    { $$ = new yasa::Integer(*$1 * *$3); }
      | number T_DIV number     { $$ = new yasa::Integer(*$1 / *$3); }
      | number T_MOD number     { $$ = new yasa::Integer(*$1 % *$3); }
      | number T_LOGAND number  { $$ = new yasa::Integer(*$1 & *$3); }
      | number T_LOGOR number   { $$ = new yasa::Integer(*$1 | *$3); }
      | number T_LOGXOR number  { $$ = new yasa::Integer(*$1 ^ *$3); }
      | number T_RSHIFT number  { $$ = new yasa::Integer(*$1 >> *$3); }
      | number T_LSHIFT number  { $$ = new yasa::Integer(*$1 << *$3); }
      // | label T_PLUS number     { $$ = new yasa::Integer(*$1 + *$3); }
      // | label T_MINUS number    { $$ = new yasa::Integer(*$1 - *$3); }
      // | label T_MULT number     { $$ = new yasa::Integer(*$1 * *$3); }
      // | label T_DIV number      { $$ = new yasa::Integer(*$1 / *$3); }
      // | label T_MOD number      { $$ = new yasa::Integer(*$1 % *$3); }
      // | label T_LOGAND number   { $$ = new yasa::Integer(*$1 & *$3); }
      // | label T_LOGOR number    { $$ = new yasa::Integer(*$1 | *$3); }
      // | label T_LOGXOR number   { $$ = new yasa::Integer(*$1 ^ *$3); }
      // | label T_RSHIFT number   { $$ = new yasa::Integer(*$1 >> *$3); }
      // | label T_LSHIFT number   { $$ = new yasa::Integer(*$1 << *$3); }
      | T_HEX                   { $$ = new yasa::Integer(yytext + 1, 16); }
      | T_ORD                   { $$ = new yasa::Integer(yytext + 0, 10); }
      | T_BIN                   { $$ = new yasa::Integer(yytext + 1, 2);  }
      ;

immnum: T_HEXLIT                { $$ = new yasa::Integer(yytext + 2, 16);  }
      | T_ORDLIT                { $$ = new yasa::Integer(yytext + 1, 10);  }
      | T_BINLIT                { $$ = new yasa::Integer(yytext + 2, 2);   }
      ;

index:  T_INDEX {
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
            YYABORT;
          }
        }
      ;

accum:  T_ACC         { $$ = new std::string("A"); }
      ;

stack:  T_STACK       { $$ = new std::string("S"); }
      ;


      //   T_PLUS        { $$ = new std::string("CODE_" + util::to_string(snespos)); }
      // | T_MINUS       { $$ = new std::string("CODE_" + util::to_string(snespos)); }
      // | 
label:  T_SUBLABEL  {
          std::string sublabel = "";
          std::string id = std::string(yytext);
          int i;

          while (id[i] == '.')
          {
            if (i > label_ids.size())
            {
              std::cout << "Error: sublabel goes deeper than expected. (line " << yylineno << ")" << std::endl;
              YYABORT;
            }

            sublabel += label_ids[i] + "_";
            i++;
          }

          id = id.substr(i);

          //  Sublabel was dedented
          if (i != label_ids.size())
          {
            label_ids.erase(label_ids.begin() + i, label_ids.end());
            label_ids.push_back(id);
          }

          $$ = new std::string(sublabel + id);
          label_ids.push_back(id);
        }
      | T_LABEL     {
          //  Get rid of trailing :
          std::string temp = std::string(yytext);

          $$ = new std::string(temp.substr(0, temp.size() - 1));

          label_ids.clear();
          label_ids.push_back(*$$);
        }
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
