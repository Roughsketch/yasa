!Damage_flag = $58

;;Energy heal Block - for Metroid Health Patch - By ICB

db $42
JMP MarioBelow : JMP MarioAbove : JMP MarioSide : JMP SpriteV : JMP SpriteH : JMP MarioCape
JMP MarioFireBall : JMP TopCorner : JMP BodyInside : JMP HeadInside

TopCorner:
MarioAbove:
MarioSide:
HeadInside:
BodyInside:
MarioBelow:

LDA $0F48
CMP #$63
BEQ stop
LDA $14			;Play Sound
AND #$01		;Every
BNE stop			;Frame
LDA #$50		;to know 
STA $1DFC		;you're healing
stop:
STZ !Damage_flag	;Zero hurt flag
LDA #$01		;set inc/dec RAM to 1 while touching
STA $1900

SpriteV:
SpriteH:
MarioCape:
MarioFireBall:
	RTL