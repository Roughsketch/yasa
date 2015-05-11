CXX=g++
CXXFLAGS+=-std=c++11 -U__STRICT_ANSI__
LDFLAGS+=
FLEX=win_flex.exe
BISON=win_bison.exe
FLEXBISONSRCS=src/parser.cpp src/tokens.cpp src/math_parser.cpp src/math_tokens.cpp
SRCS=$(FLEXBISONSRCS) src/main.cpp src/assembler.cpp src/instruction.cpp src/util.cpp
OBJS=$(SRCS:.cpp=.o)
EXE=bin/yasa

all: flex bison $(SRCS) $(EXE)

debug: CXXFLAGS+=-DDEBUG_TEST
debug: CXXFLAGS+=-DTEST_DIRECTORY='"$(subst /makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))/tests"'
debug: SRCS+=src/test.cpp
debug: flex bison $(SRCS) $(EXE)

$(EXE): $(OBJS)
	$(CXX) $(LDFLAGS) $(OBJS) -o $@

.c.o:
	$(CXX) $(CXXFLAGS) $< -o $@

flex:
	$(FLEX) -o src/tokens.cpp src/65c816.l
	$(FLEX) -o src/math_tokens.cpp src/math.l

bison:
	$(BISON) -d -r states -o src/parser.cpp src/65c816.y
	$(BISON) -d -o src/math_parser.cpp src/math.y

rebuild: clean all

clean:
	rm src/*.o

