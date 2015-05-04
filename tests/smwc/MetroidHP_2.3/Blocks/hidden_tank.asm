;Hidden Reserve Tank
;by ICB, based on code by smkdan
;This is a block that turns into a reserve tank for the Metroid Health Patch when shot with a fireball
;Make it act like 130, and disquise it as a wall to hide it as is done in Metroid games.
;BE SURE TO SET THE !SPRITENUMBER below for each tank you wish to hide. Save a new block for each.


JMP MarioBelow : JMP MarioAbove : JMP MarioSide : JMP SpriteV : JMP SpriteH : JMP MarioCape : JMP MarioFireBall
;don't touch those

!SPRITENUMBER = $00	;sprite # to generate. CHANGE THIS to a reserve tank
!INITSTAT = $01		;Set to normal status

!XDISP = $0000		;value added to block position on generation
!YDISP = $0000


Return_l:
	RTL
MarioFireBall:
	PHY		;preserve Y
	JSL $02A9DE	;grab sprite slot
	BMI Return_l	;return if none avaliable
	TYX		;into X

	LDA #!INITSTAT	;set to initial status
	STA $14C8,x	;status
LDA $1662,x
ORA #$27
STA $1662,x
LDA #$02
STA $15F6,x

	LDA #!SPRITENUMBER
	STA $7FAB9E,x	;custom sprite type table
	JSL $07F7D2	;clear
	JSL $0187A7	;load tables
        LDA #$88		;set as custom sprite
        STA $7FAB10,X
		
LDA #$00
STA $E4,x
	REP #$20	;apply xdisp
	LDA $9A
	CLC
	ADC #!XDISP
	SEP #$20
	STA $E4,x
	XBA
	STA $14E0,x

	REP #$20	;apply ydisp
	LDA $98
	CLC
	ADC #!YDISP
	SEP #$20
	STA $D8,x
	XBA
	STA $14D4,x


	LDA #$02	;erase self
	STA $9C
	JSL $00BEB0	;generate blank block
	PLY		;restore Y
SpriteV: 
SpriteH:
MarioCape: 

MarioAbove: 
MarioSide: 
MarioBelow:

	RTL