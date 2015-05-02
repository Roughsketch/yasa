CC=g++
CXXFLAGS=-c -std=c++11 -U__STRICT_ANSI__
SRCS=src/parser.cpp src/tokens.cpp src/main.cpp src/assembler.cpp src/instruction.cpp src/test.cpp
OBJS=$(SRCS:.cpp=.o)
EXE=bin/yasa

all: flex bison $(SRCS) $(EXE)

$(EXE): $(OBJS)
	$(CC) $(OBJS) -o $@

.c.o:
	$(CC) $(CXXFLAGS) $< -o $@

flex:
	win_flex.exe -o src/tokens.cpp src/65c816.l

bison:
	win_bison.exe -d -o src/parser.cpp src/65c816.y

rebuild: clean all

clean:
	rm *.o
