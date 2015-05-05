R"(!Freespace = $198908

header
lorom

org $D600
  JSL Ducker
org !Freespace

!CodeSize = Ending-Routine  
db "STAR"     
dw !CodeSize-$01
dw !CodeSize-$01^$FFFF
Routine:
Ducker:
  LDA $19
  BNE +
  LDA $15
  AND #$04
  RTL
+ LDY #$00  ; Just load something to it never branches
  RTL

Ending:)"