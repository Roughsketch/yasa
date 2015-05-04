header
lorom

org $018778
JSR Mymain

org $01CD23
Mymain:
STZ $14C8,x
DEC $13C6
RTS
