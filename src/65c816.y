%code requires {
  #include <string>
  #include <iostream>
  #include <iomanip>
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

  #include "math_externs.hpp"

  #define YYDEBUG 1
  extern int yylex();
  extern char * yytext;
  extern int yylineno;

  void yyerror(const char *s) {
    printf("ERROR: %s (line %d)\n", s, yylineno); 
  }

  struct Assembler
  {
    int snespos;
    int realpos;
    int max_addr;
    int org;

    std::vector<std::string> label_ids;
    std::map<std::string, int> labels;
    std::map<std::string, std::string> defines;

    std::map<int, std::vector<yasa::Instruction>> ast;

    std::string *add_sublabel_name(const char *text)
    {
      std::string sublabel = "";
      std::string id = std::string(text);
      int i = 0;

      while (id[i] == '.')
      {
        if (i > label_ids.size())
        {
          std::cout << "Error: sublabel goes deeper than expected. (line " << yylineno << ")" << std::endl;
          return nullptr;
        }

        sublabel += label_ids[i] + "_";
        i++;
      }

      id = id.substr(i);

      //  Sublabel was dedented
      if (i != label_ids.size())
      {
        //  Erase all sublabels deeper than this one
        label_ids.erase(label_ids.begin() + i, label_ids.end());
      }
      
      //  Push back the new sublabel
      label_ids.push_back(id);
      return new std::string(sublabel + id);
    }

    std::string get_sublabel_name(const char *text)
    {
      std::string sublabel = "";
      std::string id = std::string(text);
      int i = 0;

      while (id[i] == '.')
      {
        if (i > label_ids.size())
        {
          std::cout << "Error: sublabel goes deeper than expected. (line " << yylineno << ")" << std::endl;
          return nullptr;
        }

        sublabel += label_ids[i] + "_";
        i++;
      }

      return sublabel + id;
    }
  };

  Assembler assembler;
%}

//  Names / Labels
%token <string>   T_IDENT T_LABEL T_SUBLABEL

//  Symbols
%token <string>   T_COMMA T_SEPARATOR T_LINE T_LPAREN T_RPAREN T_LBRACKET T_RBRACKET T_HASH

//  Numbers
%token <string>   T_HEX T_BIN T_ORD

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

%right T_LPAREN T_RPAREN

%union {
    std::string *string;
    std::vector<uint8_t> *vector;
    int token;
    yasa::Instruction *instruction;
    std::vector<yasa::Instruction> *instrvec;
}

%type <instrvec>    input line
%type <instruction> expr implied immediate direct indexed indirect indirect_indexed stack_relative stack_relative_indirect accumulator indirect_long block 
%type <string>      instr index stack accum define label math param number
//%type <number> number

%start program

%%
program: input { } //instructions = new std::vector<yasa::Instruction>(*$1); }
      ;

input:  /* empty */ { $$ = new std::vector<yasa::Instruction>(); }
      | input line  {
          $$ = new std::vector<yasa::Instruction>(*$1);
          $$->insert($$->end(), $2->begin(), $2->end()); 
        }
      | input label { 
          std::cout << "Label: " << yytext << std::endl;
          $$ = $1;

          if (assembler.labels.count(*$2) == 1)
          {
            std::cout << "Error: label '" << *$2 << "' redefined on line " << yylineno << std::endl;
            YYERROR;
          }

          assembler.labels[*$2] = assembler.snespos;

          if (assembler.max_addr < assembler.snespos)
          {
            assembler.max_addr = assembler.snespos + 4;  //  Add 4 to make sure it can fit any instruction
          }

          std::cout << "SNES Addr: " << assembler.snespos << " Max Addr: " << assembler.max_addr << std::endl;
        }
      | input command { 
          $$ = $1; 
        }
      | input define T_EQUAL param { 
          $$ = $1;

          assembler.defines[*$2] = *$4;

          std::cout << "Define: " << *$2 << " = " << *$4 << std::endl;
        }
      ;

line:   expr {
          $$ = new std::vector<yasa::Instruction>();
          $$->push_back(*$1);

          assembler.ast[assembler.org].push_back(*$1);
          assembler.snespos += $1->size();
        }
      | expr T_SEPARATOR expr T_LINE {
          $$ = new std::vector<yasa::Instruction>();
          $$->push_back(*$1); 
          $$->push_back(*$3); 
          assembler.ast[assembler.org].push_back(*$1);
          assembler.ast[assembler.org].push_back(*$3);
          assembler.snespos += $1->size() + $3->size();
        }
      | T_LINE { 
          $$ = new std::vector<yasa::Instruction>();
        }
      ;

define: T_DEFINE { $$ = new std::string(yytext); }

command:
        T_ORIGIN param {
          std::cout << "Setting origin to " << *$2 << std::endl;

          int value = math_parse(*$2);

          assembler.snespos = value;
          assembler.org = value;
          std::cout << "Org is now " << assembler.org << std::endl;
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
      ;

implied: 
        instr T_LINE {
          //puts("Implied");
          //std::cout << "Line: " << yylineno << std::endl;
          $$ = new yasa::Instruction(*$1, yasa::Implied, assembler.snespos);
        }
      | instr T_SEPARATOR {
          //puts("Implied");
          //std::cout << "Line: " << yylineno << std::endl;
          $$ = new yasa::Instruction(*$1, yasa::Implied, assembler.snespos);
        }
      ;

immediate:
      instr T_HASH param { 
        //puts("Immediate");
        //std::cout << "Line: " << yylineno << std::endl;

        $$ = new yasa::Instruction(*$1, yasa::Immediate, assembler.snespos, *$3);
      };

direct:
      instr param { 
        //puts("Direct");
        //std::cout << "Line: " << yylineno << std::endl;
        // int value = $2->value();
        // int size = $2->size();

        // if ($2->size() > 3)
        // {
        //   std::cout << "Error: Numeric parameter too large (" << static_cast<int>(value) << ") line " << yylineno << std::endl;
        //   YYERROR;
        // }

        $$ = new yasa::Instruction(*$1, yasa::Direct, assembler.snespos, *$2); 
      };

indirect:
      instr T_LPAREN param T_RPAREN { 
        //puts("Indirect");
        //std::cout << "Line: " << yylineno << std::endl;
        // if ($3->value() > 0xFFFF)
        // {
        //   std::cout << "Error: Numeric parameter too large (" << static_cast<int>($3->value()) << ") line " << yylineno << std::endl;
        //   YYERROR;
        // }

        $$ = new yasa::Instruction(*$1, yasa::Indirect, assembler.snespos, *$3);
      };

indexed:
      instr param T_COMMA index {
        //puts("Indexed");
        //std::cout << "Line: " << yylineno << std::endl;
        // int value = $2->value();
        // int size = $2->size();

        // if (value > 0xFFFFFF) 
        // {
        //   std::cout << "Error: Numeric parameter too large (" << static_cast<int>(value) << ") line " << yylineno << std::endl;
        //   YYERROR;
        // }

        if (*$4 == "X")
        {
          
          $$ = new yasa::Instruction(*$1, yasa::Indexed_X, assembler.snespos, *$2); 
        }
        else if (*$4 == "Y")
        {
          $$ = new yasa::Instruction(*$1, yasa::Indexed_Y, assembler.snespos, *$2);
        }
      };

indirect_indexed:
        instr T_LPAREN param T_COMMA index T_RPAREN {
          //puts("Indirect Indexed X");
          //std::cout << "Line: " << yylineno << std::endl;
          $$ = new yasa::Instruction(*$1, yasa::Indirect_X, assembler.snespos, *$3);
        }
      | instr T_LPAREN param T_RPAREN T_COMMA index {
          //puts("Indirect Indexed Y");
          //std::cout << "Line: " << yylineno << std::endl;
          if (*$6 == "Y")
          {
            $$ = new yasa::Instruction(*$1, yasa::Indirect_Y, assembler.snespos, *$3);
          }
          else
          {
            std::cout << "Error: non-Y register used with indirect indexed mode. (line " << yylineno << ")" << std::endl;
            YYERROR;
          }
        }
      ;

stack_relative:
      instr param T_COMMA stack {
        //puts("Stack Relative");
        //std::cout << "Line: " << yylineno << std::endl;
        $$ = new yasa::Instruction(*$1, yasa::Stack, assembler.snespos, *$2);
      }
      ;

stack_relative_indirect:
      instr T_LPAREN param T_COMMA stack T_RPAREN T_COMMA index {
        //puts("Stack Relative Indirect");
        //std::cout << "Line: " << yylineno << std::endl;

        if (*$8 == "Y")
        {
          $$ = new yasa::Instruction(*$1, yasa::Stack_Y, assembler.snespos, *$3);
        }
        else
        {
          std::cout << "Error: non-Y register used with stack relative indirect indexed mode. (line " << yylineno << ")" << std::endl;
          YYERROR;
        }
      }
      ;

accumulator:
      instr accum {
        //puts("Accumulator");
        //std::cout << "Line: " << yylineno << std::endl;

        $$ = new yasa::Instruction(*$1, yasa::Implied, assembler.snespos);
      }
      ;

indirect_long:
        instr T_LBRACKET param T_RBRACKET {
          //puts("Indirect Long");
          //std::cout << "Line: " << yylineno << std::endl;

          $$ = new yasa::Instruction(*$1, yasa::Indirect_Long, assembler.snespos, *$3);
        }
      | instr T_LBRACKET param T_RBRACKET T_COMMA index {
          //puts("Indirect Long");
          //std::cout << "Line: " << yylineno << std::endl;

          if (*$6 == "Y")
          {
            $$ = new yasa::Instruction(*$1, yasa::Indirect_Long_Y, assembler.snespos, *$3);
          }
          else
          {
            std::cout << "Error: non-Y register used with indirect indexed mode. (line " << yylineno << ")" << std::endl;
            YYERROR;
          }
        }
      ;

block:
      instr param T_COMMA param {
        //puts("Block");
        //std::cout << "Line: " << yylineno << std::endl;

        $$ = new yasa::Instruction(*$1, yasa::Block, assembler.snespos, *$2, *$4);
      };

param:  param math param  { $$ = new std::string(*$1 + *$2 + *$3); }
      | number            { $$ = $1; }
      | T_IDENT           { $$ = new std::string(yytext); }
      | T_SUBLABEL        { $$ = new std::string(assembler.get_sublabel_name(yytext)); }
      | T_DEFINE          { 
          if (assembler.defines.count(std::string(yytext)) != 1)
          {
            std::cout << "Define used before being initialized: (" << yytext << " at line " << yylineno << ")" << std::endl;
            YYERROR;
          }

          $$ = new std::string(assembler.defines[std::string(yytext)]);
        }
      ;

math:   T_PLUS        { $$ = new std::string("+");  }
      | T_MINUS       { $$ = new std::string("-");  }
      | T_MULT        { $$ = new std::string("*");  }
      | T_DIV         { $$ = new std::string("/");  }
      | T_MOD         { $$ = new std::string("%");  }
      | T_LOGAND      { $$ = new std::string("&");  }
      | T_LOGOR       { $$ = new std::string("|");  }
      | T_LOGXOR      { $$ = new std::string("^");  }
      | T_RSHIFT      { $$ = new std::string(">>"); }
      | T_LSHIFT      { $$ = new std::string("<<"); }
      //| T_LPAREN math T_RPAREN  { $$ = $2; }      //  Can't do since it conflicts with indirect commands
      ;

number: T_HEX         { $$ = new std::string(yytext); }
      | T_ORD         { $$ = new std::string(yytext); }
      | T_BIN         { $$ = new std::string(yytext); }
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
            YYERROR;
          }
        }
      ;

accum:  T_ACC         { $$ = new std::string("A"); }
      ;

stack:  T_STACK       { $$ = new std::string("S"); }
      ;


      //   T_PLUS        { $$ = new std::string("CODE_" + util::to_string(assembler.snespos)); }
      // | T_MINUS       { $$ = new std::string("CODE_" + util::to_string(assembler.snespos)); }
      // | 
label:  T_SUBLABEL  {
          $$ = assembler.add_sublabel_name(yytext);
        }
      | T_LABEL     {
          //  Get rid of trailing :
          std::string temp = std::string(yytext);

          //  Remove trailing :
          $$ = new std::string(temp.substr(0, temp.size() - 1));

          assembler.label_ids.clear();
          assembler.label_ids.push_back(*$$);
        }
      ;

instr:  T_ADC         { $$ = new std::string(yytext); }
      | T_AND         { $$ = new std::string(yytext); }
      | T_ASL         { $$ = new std::string(yytext); }
      | T_BCC         { $$ = new std::string(yytext); }
      | T_BCS         { $$ = new std::string(yytext); }
      | T_BEQ         { $$ = new std::string(yytext); }
      | T_BIT         { $$ = new std::string(yytext); }
      | T_BMI         { $$ = new std::string(yytext); }
      | T_BNE         { $$ = new std::string(yytext); }
      | T_BPL         { $$ = new std::string(yytext); }
      | T_BRA         { $$ = new std::string(yytext); }
      | T_BRK         { $$ = new std::string(yytext); }
      | T_BRL         { $$ = new std::string(yytext); }
      | T_BVC         { $$ = new std::string(yytext); }
      | T_BVS         { $$ = new std::string(yytext); }
      | T_CLC         { $$ = new std::string(yytext); }
      | T_CLD         { $$ = new std::string(yytext); }
      | T_CLI         { $$ = new std::string(yytext); }
      | T_CLV         { $$ = new std::string(yytext); }
      | T_CMP         { $$ = new std::string(yytext); }
      | T_COP         { $$ = new std::string(yytext); }
      | T_CPX         { $$ = new std::string(yytext); }
      | T_CPY         { $$ = new std::string(yytext); }
      | T_DEC         { $$ = new std::string(yytext); }
      | T_DEX         { $$ = new std::string(yytext); }
      | T_DEY         { $$ = new std::string(yytext); }
      | T_EOR         { $$ = new std::string(yytext); }
      | T_INC         { $$ = new std::string(yytext); }
      | T_INX         { $$ = new std::string(yytext); }
      | T_INY         { $$ = new std::string(yytext); }
      | T_JML         { $$ = new std::string(yytext); }
      | T_JMP         { $$ = new std::string(yytext); }
      | T_JSR         { $$ = new std::string(yytext); }
      | T_LDA         { $$ = new std::string(yytext); }
      | T_LDX         { $$ = new std::string(yytext); }
      | T_LDY         { $$ = new std::string(yytext); }
      | T_LSR         { $$ = new std::string(yytext); }
      | T_MVN         { $$ = new std::string(yytext); }
      | T_MVP         { $$ = new std::string(yytext); }
      | T_NOP         { $$ = new std::string(yytext); }
      | T_ORA         { $$ = new std::string(yytext); }
      | T_PEA         { $$ = new std::string(yytext); }
      | T_PEI         { $$ = new std::string(yytext); }
      | T_PER         { $$ = new std::string(yytext); }
      | T_PHA         { $$ = new std::string(yytext); }
      | T_PHB         { $$ = new std::string(yytext); }
      | T_PHD         { $$ = new std::string(yytext); }
      | T_PHK         { $$ = new std::string(yytext); }
      | T_PHP         { $$ = new std::string(yytext); }
      | T_PHX         { $$ = new std::string(yytext); }
      | T_PHY         { $$ = new std::string(yytext); }
      | T_PLA         { $$ = new std::string(yytext); }
      | T_PLB         { $$ = new std::string(yytext); }
      | T_PLD         { $$ = new std::string(yytext); }
      | T_PLP         { $$ = new std::string(yytext); }
      | T_PLX         { $$ = new std::string(yytext); }
      | T_PLY         { $$ = new std::string(yytext); }
      | T_REP         { $$ = new std::string(yytext); }
      | T_ROL         { $$ = new std::string(yytext); }
      | T_ROR         { $$ = new std::string(yytext); }
      | T_RTI         { $$ = new std::string(yytext); }
      | T_RTL         { $$ = new std::string(yytext); }
      | T_RTS         { $$ = new std::string(yytext); }
      | T_SBC         { $$ = new std::string(yytext); }
      | T_SEC         { $$ = new std::string(yytext); }
      | T_SED         { $$ = new std::string(yytext); }
      | T_SEI         { $$ = new std::string(yytext); }
      | T_SEP         { $$ = new std::string(yytext); }
      | T_STA         { $$ = new std::string(yytext); }
      | T_STP         { $$ = new std::string(yytext); }
      | T_STX         { $$ = new std::string(yytext); }
      | T_STY         { $$ = new std::string(yytext); }
      | T_STZ         { $$ = new std::string(yytext); }
      | T_TAX         { $$ = new std::string(yytext); }
      | T_TAY         { $$ = new std::string(yytext); }
      | T_TCD         { $$ = new std::string(yytext); }
      | T_TCS         { $$ = new std::string(yytext); }
      | T_TDC         { $$ = new std::string(yytext); }
      | T_TRB         { $$ = new std::string(yytext); }
      | T_TSB         { $$ = new std::string(yytext); }
      | T_TSC         { $$ = new std::string(yytext); }
      | T_TSX         { $$ = new std::string(yytext); }
      | T_TXA         { $$ = new std::string(yytext); }
      | T_TXS         { $$ = new std::string(yytext); }
      | T_TXY         { $$ = new std::string(yytext); }
      | T_TYA         { $$ = new std::string(yytext); }
      | T_TYX         { $$ = new std::string(yytext); }
      | T_WAI         { $$ = new std::string(yytext); }
      | T_WDM         { $$ = new std::string(yytext); }
      | T_XBA         { $$ = new std::string(yytext); }
      | T_XCE         { $$ = new std::string(yytext); }
      ;
%%

std::vector<uint8_t> get_result()
{
  std::vector<uint8_t> data;
  std::cout << "Total origins: " << assembler.ast.size() << std::endl;

  for (auto org : assembler.ast)
  {
    std::cout << "Total instructions for org $" << std::hex << org.first << std::dec << ": " << org.second.size() << std::endl;
    for (auto instr : org.second)
    {
      std::cout << "Key: " << instr.key() << std::endl
                << "Type: " << instr.type() << std::endl
                << "Size: " << instr.size() << std::endl
                << "Address: " << std::endl
                << "\tReal: " << instr.pc_addr() << std::endl
                << "\tSNES: " << instr.snes_addr() << std::endl
                << "Static: " << std::boolalpha << instr.is_static() << std::endl
                << "Params: " << std::endl;

      if (instr.get_param(1) != "")
      {
        std::cout << "\t1: " << instr.get_param(1) << std::endl;
      }

      if (instr.get_param(2) != "")
      {
        std::cout << "\t2: " << instr.get_param(2) << std::endl;
      }

      std::cout << std::endl;

      if (instr.is_static())
      {
        auto temp = instr.data();

        data.insert(data.end(), temp.begin(), temp.end());
      }
    }
  }

  int i = 0;
  for (auto byte : data)
  {
    if (++i % 16 == 0)
    {
      std::cout << std::endl;
    }

    std::cout << std::setfill('0') << std::setw(2) << std::hex << static_cast<int>(byte) << " ";
  }
  /*
  std::vector<uint8_t> output;

  std::cout << " Max address: " << assembler.max_addr << std::endl;

  output.resize(assembler.max_addr);

  int total = instructions->size();
  int offset = 0;

  for (int i = 0; i < total; i++)
  {
    auto data = (*instructions)[i].data();
    int addr = (*instructions)[i].address() - offset;

    for (int i = 0; i < data.size(); i++)
    {
      output[addr + i] = data[i];
    }
  }
  */
  return data;
}

std::map<std::string, int> get_labels()
{
  return assembler.labels;
}