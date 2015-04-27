win_bison.exe -d -o src/parser.cpp src/65c816.y
win_flex.exe -o src/tokens.cpp src/65c816.l
g++ -o bin/yasa src/parser.cpp src/tokens.cpp src/main.cpp -O3