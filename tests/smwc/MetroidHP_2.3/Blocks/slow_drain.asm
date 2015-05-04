!Damage_flag = $58

;;Slow Energy Drain Block - for Metroid Health Patch - By ICB
;GHB's note: will not remove the player's powerup

db $42
JMP MarioBelow : JMP MarioAbove : JMP MarioSide : JMP SpriteV : JMP SpriteH : JMP MarioCape
JMP MarioFireBall : JMP TopCorner : JMP BodyInside : JMP HeadInside


TopCorner:
MarioAbove:
MarioSide:
HeadInside:
BodyInside:
MarioBelow:

LDA #$02		;set hurt flag to custom
STA !Damage_flag
LDA $14			;Play Sound
AND #$07		;Every few
BNE stop			;Frames
LDA #$06		;to know
STA $1DFC		;you're in hot water!
LDA #$01		;set inc/dec RAM to 1 while touching
STA $1900

stop:
SpriteV:
SpriteH:
MarioCape:
MarioFireBall:
	RTL