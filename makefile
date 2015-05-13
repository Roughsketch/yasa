CXX=g++
CXXFLAGS+=-std=c++11 -U__STRICT_ANSI__
LDFLAGS+=
FLEX=win_flex.exe
BISON=win_bison.exe
FLEXBISONSRCS=src/parser.cpp src/tokens.cpp src/math_parser.cpp src/math_tokens.cpp
SRCS=$(FLEXBISONSRCS) src/main.cpp src/assembler.cpp src/instruction.cpp src/util.cpp
OBJS=$(SRCS:.cpp=.o)
EXE=bin/yasa
DEBUG_EXE=bin/yasad

DEBUGOBJS = $(SRCS:.cpp=.o) src/test.o

all: $(SRCS) $(EXE)

debug: DEBUGFLAGS+=-DDEBUG_TEST
debug: DEBUGFLAGS+=-DTEST_DIRECTORY='"$(subst /makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))/tests"'
debug: $(SRCS) $(DEBUG_EXE)

$(DEBUG_EXE): $(DEBUGOBJS)
	$(CXX) $(LDFLAGS) $(DEBUGOBJS) -o $@

$(EXE): $(OBJS)
	$(CXX) $(LDFLAGS) $(OBJS) -o $@

.cpp.o:
	$(CXX) $(CXXFLAGS) $(DEBUGFLAGS) $< -c -o $@

src/tokens.cpp: src/65c816.l
	$(FLEX) -o $@ $^

src/math_tokens.cpp: src/math.l
	$(FLEX) -o $@ $^

src/parser.cpp: src/65c816.y
	$(BISON) -d -o $@ $^

src/math_parser.cpp: src/math.y
	$(BISON) -d -o $@ $^

rebuild: clean all

clean:
	rm src/*.o

