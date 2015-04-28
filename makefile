CC=g++
CFLAGS=-Wall -c
SRCS=src/parser.cpp src/tokens.cpp src/main.cpp
OBJS=$(SRCS:.cpp=.o)
EXE=bin/yasa

all: $(SRCS) $(EXE)

$(EXE): $(OBJS)
	$(CC) $(OBJS) -o $@

.c.o:
	$(CC) $(CFLAGS) $< -o $@

rebuild: clean all

clean:
	del *.o
