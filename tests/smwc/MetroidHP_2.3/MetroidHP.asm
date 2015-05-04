;;Metroid Health Patch
;;By ICB - Based off of the Doki Doki Panic Health Patch by Killozapit. Credit both, please.
;;
;;What this patch does: Uses bonus stars for HP. You can collect Reserve Energy Tank sprites to increase the 
;;number of health bars, which will give you +100 max HP (another 00-99HP). 
;;
;;With this patch, Mario stays big always, unless he has a cape or fire, and you get knocked back when hit.
;;you want to keep a powerup until Mario has died, removed the specified code in the Hit routine.
;;
;;This patch is NOT compatable with the two-player mode of smw, so either disable to only have mario
;;playable, or have ASM knowledge to edit this patch to make it compatable for both players.
;;
;;For custom sprites, put the code included below in your Mario Contact routine to make
;;a sprite deal more or less damage individually. Default sprites deal 20 HP worth of damage. Mushrooms heal 20. 
;;midway points heal all.
;;
;;;;;;Hurt Code for custom sprites;;;;;;
;;!Damage_flag = $58		;>have this on top!!!!
;;JSL $01A7DC			;If not touching Mario
;;BCC (whatever your return label is)	;then return
;;LDA $1497			;If mario is Invulnerable
;;BNE (whatever your return label is)	;then don't damage mario
;;LDA #$02			;set the hurt flag for custom sprites (#$02)
;;STA !Damage_flag		;in the heal/hurt routine
;;LDA #$**			;This is the number of points
;;STA $1900			;to take away IN HEX.
;;
;;Patch starts below
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; defines
;--------------------------------------------------------------------------------------
;ram addresses:
!Health = $0DC4
!MaxHealth = $0DC5
!MarioHealth = $0F44
!LuigiHealth = $0F45		;>not used?
!MarioHeartsFound = $1F2C
!LuigiHeartsFound = $1F2D	;>not used?
!Powerup = $19
!Record_effect = $1900		;>use for bonus stars at level end.
!MarioPowerup = $0DB8		;\using same addresses?!?
!LuigiPowerup = $0DB8		;/
!Damage_flag = $58		;$0670 wasn't safe to use.

;specific values:
!knockSpeed1 = $29
!knockSpeed2 = $D7
!mushroom_heal = 20		;>(in decimal) how much mushroom heal you.
!damage = 20			;>(in decimal) how much damage dealt from smw's hazards.
;--------------------------------------------------------------------------------------

; -------------------------------------------
; Patches
; -------------------------------------------
; Mushroom Item
org $01C510
	db $00, 00, 00, 00 ; Disable mushroom giveing item
org $01C515
	db $00 ; Disable flower giveing mushroom
org $01C51C
	db $00 ; Disable feather giveing mushroom
org $01C524
	db $00, 00, 00, 00 ; Mushroom always trys to make you big
org $01C561
	JML Mushroom	; New Mushroom pickup code
; -------------------------------------------
org $008F49			; hijack status bar routine
autoclean JSL new_routine	; for the hurt/heal routine

; Status Bar
org $8FC8	; Change Mario/Luigi text to health
JML Healthbar 

org $05CC1A	;Get rid of Mario at course clear since we use that for other GFX.
	db $FC,$2C,$FC,$2C,$FC,$2C,$FC,$2C,$FC,$2C
org $05CC61	;and do the same for Luigi (Though it's best to use this patch for one player)
	db $FC,$FC,$FC,$FC,$FC

org $00D129	; Eliminate powerdown animation and jump to flash routine
	db $EA,$EA,$EA,$80

;We disable the bonus star routine here so we can use it for HP!
org $008F5E
	nop #21 

org $009E4B	;Disable bonus game if bonus stars are 100		
	nop #3
;Patches to move the bonus star counter (from Aiyo's code)
org $008F9D
	nop #40
org $009053
	 nop #3
org $009068
	nop #3
; -------------------------------------------
; Map Mode Code
org $9E2C
JML Newgame 	; When starting a new game from titlescreen
NOP
NOP

org $0491DB
JML Startlevel 	; Whenever you enter a level
NOP

org $A0E6
JSL Endlevel 	; Whenever you go back to the map
; -------------------------------------------
org $F606
JML Death

org $00F5B3	;if mario falls down a hole, reroute to new death routine.
	db $06

org $F5D5
JML Hit
org $F5F8
NOP 		; Disable item box getting used when hurt 
NOP
NOP
NOP

org $F600
NOP 		; Disable power up takeing when hurt (we do this elsewhere)
NOP
; -------------------------------------------
org $8C89 ; Status bar rearangeing
	db $FC, $2C, $3E, $2C, $3E, $2C, $3E, $2C, $3E, $2C, $3E, $2C, $3E, $2C, $3E, $2C
	db $FC, $2C, $42, $38, $40, $38, $41, $38, $4A, $38, $FC, $38, $FC, $38, $4A, $78
	db $76, $38, $26, $38, $FC, $38, $27, $3C, $27, $3C, $27, $3C, $FC, $38, $2E, $3C
	db $26, $38, $FC, $38, $27, $38, $27, $38, $30, $38, $31, $38, $32, $38, $33, $38
	db $FC, $38, $FC, $38, $FC, $38, $FC, $38, $43, $38, $27, $38, $27, $38, $4A, $38
	db $FC, $38, $FC, $38, $4A, $78, $FC, $3C, $FC, $3C, $FC, $3C, $FC, $3C, $FC, $38
	db $FC, $38, $FC, $38, $FC, $38, $FC, $38, $FC, $38, $FC, $38
org $8E6F ; Time
	LDA $0F31
	STA $0F0C
	LDA $0F32
	STA $0F0D
	LDA $0F33
	STA $0F0E
org $8E8C ; Score?
	STA $0EFC,x
org $8F55 ; Lives
	STX $0F1E
	STA $0F1F
org $8FEF ; Dragon Coins
	STA $0F24,x
; -------------------------------------------
org $F2E0 ; Midway Point Healing/Powerup
	JML Midwayheal
	NOP
	NOP
	NOP
	NOP
freecode


; -------------------------------------------
Hit:

LDA #$38			;play hurt
STA $1DFc			;sound
LDA !Damage_flag		;If user has set custom hit decrement
CMP #$02			;in cusom sprite contact routine
BEQ custom_HP			;skip default HP dealt.
LDA #$01			;set the hurt flag so we can dec HP
STA !Damage_flag		;in the heal/hurt routine

LDA #!damage			;set the inc/dec RAM
STA !Record_effect			;to 20 in Hex
custom_HP:
	LDA !Powerup		;Powerup is always		\
	CMP #$01		;big if not hurt		|
	BMI Endhit		;Branch to knocbkack	|-remove this block to keep current powerup
	LDA #$01 		;Get rid of flower 		|
	STA !Powerup		;or cape if you have them	/
Endhit:				;this is the knockback code
LDA #!knockSpeed2
    STA $7D
    
    LDA $76
    BNE Other
    
    LDA #!knockSpeed1
    STA $7B
    BRA Next
    
Other:
    LDA #!knockSpeed2
    STA $7B
Next:
JML $00F5DD
rtl
; -------------------------------------------
Healthbar:
	LDX #$08
	HeathBarFillLoop:
		TXA
		CMP !Health
		BPL Empty
		Full:
			LDA #$3F
			BRA Set
		Empty:
			CMP !MaxHealth
			BPL Blank
			LDA #$3E
			BRA Set
		Blank:
			LDA #$3D
		Set:
			STA $0EF8,x
			DEX
			BPL HeathBarFillLoop

	JML $008FD8

; -------------------------------------------
Mushroom:

STZ !Damage_flag		;Zero the hurt flag. A well timed shroom can save your life!
LDA #$0A		;\Play mushroom sound
STA $1dF9		;/
LDA !Record_effect
CLC : ADC #!mushroom_heal	;add HP inc/dec RAM
STA !Record_effect			;to 20 (change this so if you grab two mushroom
				;before inc/dec stops, wouldn't "interrupt" 1st mushroom value.

LDA $0F48		;If HP is 99
CMP #$63		;Check to see if health bar is full
BMI nocheckitem		;otherwise return
LDA !Health		;Is health bar
CMP !MaxHealth		;Full?
BPL checkitem
			;if not, check for item
nocheckitem:
JML $01C608

checkitem:
LDA $0DC2		;item in the box
CMP #$00		;No?
BNE Endmush		;if so, return
LDA #$01		;if not, and HP+health are full
STA $0DC2		;put a mushroom in the box

Endmush:
JML $01C608
; -------------------------------------------
Newgame:

	STA $0DBE
	STZ $0DBF	
	LDX $0DB2
	STZ !Health
	STZ !MaxHealth
	LDA #$01
	STA !Powerup ; Start big
	LDA #$63
	STA $0F48
	STA $0DB8 
	STA $0DB9
	STZ $0DC1
  	JML $009E37
; -------------------------------------------
Startlevel:
	PHY
	LDY #$01
	LDA #$01
		BitCount:
		BIT !MarioHeartsFound,x
		BEQ NotSet
		INY
		NotSet:
		ROL
		BCC BitCount
	STY !MaxHealth
	LDA !MarioHealth,x
	BNE HasHealth
	TYA
	STA !MarioHealth,x
	HasHealth:
	STA !Health
	PLY
	LDA #$02
	STA $0DB1
	JML $0491E0
; -------------------------------------------
Endlevel:
	LDA !MaxHealth ; Skip this on init
	BEQ .Skip
	LDA !Health
	BNE .Alive
	.Dead
		LDA #$01
		STA !Powerup
		STA !MarioPowerup,x
		LDA #$63		;Most metroid games start with 30 HP after death
		STA $0F48		;Change value here to #$1E for 30, otherwise, we do 99
		LDA #$01		;Full tanks after death -1. Metroid does 0
		STA !Health		;Change #$01 to $0DC5 to do all tanks full.

	.Alive
		STA !MarioHealth,x
;LDA $19
;BEQ .dead
	.Skip
		LDA #$03
		STA $44
		RTL
; -------------------------------------------
Midwayheal:

		LDA !MaxHealth		;midway points heal you fully
		STA !Health		;add semicolons to these to lines to use just the next two
		LDA #$63		;This heals HP to 99
		STA $0F48		;Semicolon these two to just heal all health bars
	JML $00F2E8

;--------------------------
; Hurt and Heal code + new status bar stuff
;------------------------
new_routine:
	LDA $0100	;\prevent death on title screen (his HP starts out as
	CMP #$0C	;|00 in the title screen, thats why this is here)
	BCC +		;/
	LDA $0F48	;\if mario's HP tank and numerical HP are empty
	BNE +		;|then death (this is here to prevent "0HP but
	LDA !Health	;|not die until next hit" glitch)
	CMP #$02	;|
	BCS +		;|
	LDA $71		;|
	CMP #$09	;|
	BEQ +		;|
	JSL $00F606	;/
+
        PHX                     	;> Save whatever's in X for later
        LDA $0F48              	;\ Load HP (stars)
        JSL HexToDec        	;| Jump to HEX->DEC converter
        STA $0F1B           	;| store ones into status bar
        STX $0F1A          	;| store tens into status bar
PLX

LDA !Damage_flag		;If hurt flag
CMP #$00		;is set
BNE hurt			;then go to decrease routine

LDA !Record_effect		;If bonus star inc/dec RAM is zero
BEQ stop			;then stop

LDA !Health		;If health
CMP !MaxHealth		;isn't equal to MaxHealth
BMI dontcheck		;don't check for Max HP
LDA $0F48		;If HP counter
CMP #$63		;is 99
BEQ stop2			;jump to zero increase flag
BRA increasing		;otherwise, increase HP
dontcheck:
LDA $0F48		;If HP counter 
CMP #$64		;is 100
BPL reset			;Jump to rollover code
increasing:
LDA $14			;increase
AND #$00		;HP
BNE stop			;every
INC $0F48		;frame
DEC !Record_effect		;and decrease the inc/dec flag, too.
BRA stop			;and stop.
reset:
LDA !Health		;if health
CMP !MaxHealth		;is full
BPL dontinc		;don't increase health bar
INC !Health		;otherwise, increase with HP rollover
dontinc:
STZ $0F48		;zero HP for rollover
BRA stop
stop2:
STZ !Record_effect		;Zero the inc/dec flag if Max HP and health
stop:
lda $0dbe
inc
RTL

hurt:

LDA !Record_effect		;if the inc/dec flag is zero
BEQ stop3		;then stop decreasing HP
LDA $0F48		;If the HP
CMP #$01		;is less than 1
BMI remove		;rollover and remove a health bar

LDA $14			;decrease
AND #$00		;HP
BNE stop3		;every
DEC $0F48		;frame
DEC !Record_effect		;and decrease the inc/dec flag, too.

BRA stop3		;and zero the hurt flag
remove:
LDA !Health		;if the health bar is zero
CMP #$01
BEQ Death		;and HP is too, kill Mario.
DEC !Health		;otherwise, decrease health bar with rollover
LDA #$64		;set new rollover
STA $0F48		;to 99
stop3:
LDA !Record_effect		;stop the inc/dec flag
BNE nozero
STZ !Damage_flag		;zero the hurt flag
nozero:
lda $0dbe
inc
RTL

Death:
STZ !Damage_flag
STZ !Record_effect
STZ $0F48
STZ !Health
LDA #$09
STA $1DFB

LDA #$90
STA $7d
JML $00F60F
lda $0dbe
inc
RTL

HexToDec:                                    ;HEX->DEC converter
                     LDX #$00                ;> Set X to 0
                     LDY #$00                ;> Set Y to 0
StartCompare1:
                     CMP #$64                ;\
                     BCC StartCompare2       ; |While A >= 100:
                     SBC #$64                ; |Decrease A by 100
                     INY                     ; |Increase Y by 1
                     BRA StartCompare1       ;/
StartCompare2:
                     CMP #$0A                ;\
                     BCC ReturnLong          ; |While A >= 10:
                     SBC #$0A                ; |Decrease A by 10
                     INX                     ; |Increase X by 1
                     BRA StartCompare2       ;/
ReturnLong:
                     RTL