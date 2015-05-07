CC=g++
CXXFLAGS+=-c -std=c++11 -U__STRICT_ANSI__
CXXFLAGS+=-DDEBUG_TEST
CXXFLAGS+=-DTEST_DIRECTORY='"$(subst /makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))/tests"'
FLEXBISONSRCS=src/parser.cpp src/tokens.cpp src/math_parser.cpp src/math_tokens.cpp
SRCS=$(FLEXBISONSRCS) src/main.cpp src/assembler.cpp src/instruction.cpp src/util.cpp src/test.cpp
OBJS=$(SRCS:.cpp=.o)
EXE=bin/yasa

all: flex bison $(SRCS) $(EXE)

$(EXE): $(OBJS)
	$(CC) $(OBJS) -o $@

.c.o:
	$(CC) $(CXXFLAGS) $< -o $@

flex:
	win_flex.exe -o src/tokens.cpp src/65c816.l
	win_flex.exe -o src/math_tokens.cpp src/math.l

bison:
	win_bison.exe -d -v -o src/parser.cpp src/65c816.y
	win_bison.exe -d -o src/math_parser.cpp src/math.y

rebuild: clean all

clean:
	rm src/*.o

