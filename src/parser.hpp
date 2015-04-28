/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SRC_PARSER_HPP_INCLUDED
# define YY_YY_SRC_PARSER_HPP_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
/* Line 2058 of yacc.c  */
#line 1 "src/65c816.y"

  #include <string>
  #include <iostream>
  #include <map>
  #include <vector>


/* Line 2058 of yacc.c  */
#line 54 "src/parser.hpp"

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_IDENT = 258,
     T_LABEL = 259,
     T_HEX = 260,
     T_BIN = 261,
     T_ORD = 262,
     T_HEXLIT = 263,
     T_BINLIT = 264,
     T_ORDLIT = 265,
     T_COMMA = 266,
     T_REG = 267,
     T_SEPARATOR = 268,
     T_LINE = 269,
     T_LPAREN = 270,
     T_RPAREN = 271,
     T_LBRACKET = 272,
     T_RBRACKET = 273,
     T_COMMENT = 274,
     T_ADC = 275,
     T_AND = 276,
     T_ASL = 277,
     T_BCC = 278,
     T_BCS = 279,
     T_BEQ = 280,
     T_BIT = 281,
     T_BMI = 282,
     T_BNE = 283,
     T_BPL = 284,
     T_BRA = 285,
     T_BRK = 286,
     T_BRL = 287,
     T_BVC = 288,
     T_BVS = 289,
     T_CLC = 290,
     T_CLD = 291,
     T_CLI = 292,
     T_CLV = 293,
     T_CMP = 294,
     T_COP = 295,
     T_CPX = 296,
     T_CPY = 297,
     T_DEC = 298,
     T_DEX = 299,
     T_DEY = 300,
     T_EOR = 301,
     T_INC = 302,
     T_INX = 303,
     T_INY = 304,
     T_JMP = 305,
     T_JSR = 306,
     T_LDA = 307,
     T_LDX = 308,
     T_LDY = 309,
     T_LSR = 310,
     T_MVN = 311,
     T_NOP = 312,
     T_ORA = 313,
     T_PEA = 314,
     T_PEI = 315,
     T_PER = 316,
     T_PHA = 317,
     T_PHB = 318,
     T_PHD = 319,
     T_PHK = 320,
     T_PHP = 321,
     T_PHX = 322,
     T_PHY = 323,
     T_PLA = 324,
     T_PLB = 325,
     T_PLD = 326,
     T_PLP = 327,
     T_PLX = 328,
     T_PLY = 329,
     T_REP = 330,
     T_ROL = 331,
     T_ROR = 332,
     T_RTI = 333,
     T_RTL = 334,
     T_RTS = 335,
     T_SBC = 336,
     T_SEC = 337,
     T_SED = 338,
     T_SEI = 339,
     T_SEP = 340,
     T_STA = 341,
     T_STP = 342,
     T_STX = 343,
     T_STY = 344,
     T_STZ = 345,
     T_TAX = 346,
     T_TAY = 347,
     T_TCD = 348,
     T_TCS = 349,
     T_TDC = 350,
     T_TRB = 351,
     T_TSB = 352,
     T_TSC = 353,
     T_TSX = 354,
     T_TXA = 355,
     T_TXS = 356,
     T_TXY = 357,
     T_TYA = 358,
     T_TYX = 359,
     T_WAI = 360,
     T_WDM = 361,
     T_XBA = 362,
     T_XCE = 363
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2058 of yacc.c  */
#line 32 "src/65c816.y"

    std::string *string;
    std::vector<uint8_t> *vector;
    int token;
    int number;


/* Line 2058 of yacc.c  */
#line 185 "src/parser.hpp"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_SRC_PARSER_HPP_INCLUDED  */
