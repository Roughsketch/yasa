Damage_flag = $58

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Metroid                                                                            ;
; By: Schwa -- Edited by ICB for Metroid Health Patch           
;                                                                                    ;
; What this does:                                                                    ;
; This sprite hovers in the air, moving back and forth while bobbing up and down.    ;
; When approached by Mario, it suddenly gives chase, and this thing is FAST. It      ;
; will continue to chase Mario until it is outrun or until it catches him. If it     ;
; catches him, it will latch on to him and drain his HP very fast. It can then    ;
; be shaken off by mashing the controller buttons repeatedly, and when this happens  ;
; the Metroid falls off and dies.                                                    ;
;                                                                                    ;
; This sprite does not use the Extra Bit, but you can choose how long of a detection ;
; range it has by changing the Extra Property 2.                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;
; Init Routine ;
;;;;;;;;;;;;;;;;

	dcb "INIT"
        JSR SUB_HORZ_POS	; Face Mario
        TYA
        STA $157C,x
	STZ $1528,x	; \ set Mode and Button Count to 0
	STZ $C2,x	; /
	RTL

;;;;;;;;;;;;;;;;
; Main Routine ;
;;;;;;;;;;;;;;;;

	dcb "MAIN"
	PHB
	PHK
	PLB
	JSR MAIN_CODE
	PLB
	RTL

;;;;;;;;;;;;;;;;;;;;
; Main Sprite Code ;
;;;;;;;;;;;;;;;;;;;;

X_SPEED:	dcb $08,$F8
Y_SPEED:	dcb $00,$F8,$F2,$F8,$00,$08,$0E,$08

RETURN1:
	RTS

MAIN_CODE:
	JSR SUB_GFX	; call gfx routine

	LDA $14C8,x		; \  handle sprite if off screen or dead
	CMP #$08		;  |
	BNE RETURN1		;  |
	LDA $9D			;  |
	BNE RETURN1		;  |
	JSR SUB_OFF_SCREEN_X0	; /

	INC $1570,x		; increase how many frames sprite has been on screen

	LDA $C2,x		; load sprite Mode ... 0 is normal, 1 is chasing, 2 is latched onto Mario
	CMP #$01		; \ branch to Chasing code if needed
	BEQ MODE_CHASING	; /
	CMP #$02		; \ branch to Latched On code if needed
	BEQ MODE_DRAINING	; /

MODE_NORMAL:
	LDA $1570,x		; \ change direction every once in a while
	AND #$7F		;  |
	BNE NO_CHANGE_DIR	;  |
	LDA $157C,x		;  |
        EOR #$01		;  |
        STA $157C,x		; /

NO_CHANGE_DIR:
	LDY $157C,x		; \ set x speed based on facing direction
	LDA X_SPEED,y		;  |
	STA $B6,x		; /

	LDA $1570,x	; \
	LSR A		;  | set y speed based on frame count, so it does the wave motion
	LSR A		;  | every 8th frame, change
	LSR A		;  |
	AND #$07	;  |
	TAY		;  |
	LDA Y_SPEED,y	;  |
	STA $AA,x	; /

	JSR PROXIMITY		; \ check to see if Mario is close to the sprite
	BEQ FINISH_STUFF_1	;  | If so, set mode to Chasing Mode
	LDA #$01		;  |
	STA $C2,x		; /
	BRA FINISH_STUFF_1

MODE_CHASING:
	JSR DO_CHASE

FINISH_STUFF_1:
	JSL $01802A	; update speed
	JSL $01A7DC	; check for Mario contact
	BCC RETURN2
	
	STZ $1534,x
	LDA #$02
	STA $C2,x
RETURN2:
	RTS

MODE_DRAINING:
	STZ $AA,x
	STZ $B6,x

	LDA $94		; \  set sprite position to center on Mario's head whether he's big or small
	STA $E4,x	;  |
	LDA $95		;  |
	STA $14E0,x	;  |
	LDA $19		;  |
	BNE BIG		;  |
	LDA $96		;  |
	CLC		;  |
	ADC #$04	;  |
	STA $D8,x	;  |
	BRA NOT_BIG	;  |
BIG:			;  |
	LDA $96		;  |
	SEC		;  |
	SBC #$04	;  |
	STA $D8,x	;  |
NOT_BIG:		;  |
	LDA $97		;  |
	STA $14D4,x	; /

	LDA $1490	; \ kill sprite if Mario has a star
	BNE STAR_KILL	; /

	LDA $7D			; \ prevent Mario from jumping
	BPL NO_MARIO_JUMP	;  |
	LDA $77			;  |
	BNE NO_MARIO_JUMP	;  |
	STZ $7D			; /
NO_MARIO_JUMP:
LDA #$02			;set hurt flag
STA Damage_flag			;for custom sprite
	LDA $14			;  |
	AND #$05		;  | change AND #$07 to different values to change the rate of coin drainage
	BNE NO_DRAIN_COIN	;  | Make sure it's a power of 2, though (i.e. 2, 4, 8, 16, 32, etc. but in hex)
	LDA #$01
	STA $1900		;  |
	LDA #$06		;  |
	STA $1DFC		; /
NO_DRAIN_COIN:
	LDA $16			; \ if buttons are being pressed, increase the button counter
	BEQ NO_PRESS_BUTTON	;  |
	INC $1534,x		; /
	LDA $1534,x
	CMP #$14		; change CMP #$14 to other values to change how many button presses are
	BCC NO_PRESS_BUTTON	;   required to shake off the Metroid
	JSR STAR_KILL
NO_PRESS_BUTTON:
	RTS

;;;;;;;;;;;;;;;;;
; Chase Routine ;
;;;;;;;;;;;;;;;;;

TBL_ACCEL_X         dcb $02,$FE
TBL_MAX_SPEED_X     dcb $20,$E0
TBL_ACCEL_Y         dcb $04,$FC
TBL_MAX_SPEED_Y     dcb $10,$F0

DO_CHASE:
	JSR SUB_HORZ_POS	; \
	LDA $B6,x		;  | chase Mario horizontally
	CMP TBL_MAX_SPEED_X,y	;  |
	BEQ DO_Y		;  |
	CLC			;  |
	ADC TBL_ACCEL_X,y	;  |
	STA $B6,x		; /
DO_Y:
	JSR SUB_VERT_POS	; \
	LDA $AA,x		;  | chase Mario vertically
	CMP TBL_MAX_SPEED_Y,y	;  |
	BEQ RETURN3		;  |
	CLC			;  |
	ADC TBL_ACCEL_Y,y	;  |
	STA $AA,x		; /

RETURN3:
	RTS


;;;;;;;;;;;;;;;;;
; Death Routine ;
;;;;;;;;;;;;;;;;;

KILLED_X_SPEED:	dcb $F0,$10

STAR_KILL:
	LDA #$02		; Kill sprite
	STA $14C8,x
	LDA #$D0		; Set killed Y speed
        STA $AA,X
	JSR SUB_HORZ_POS
	;TYA			; Set killed X speed
	;EOR #$01
	;TAY
	LDA KILLED_X_SPEED,y
	STA $B6,x

	LDA #$02
        STA $1602,x             ;  write frame to show

	RTS

;;;;;;;;;;;;;;;;;;;;;
; Detection Routine ;
;;;;;;;;;;;;;;;;;;;;;

EORTBLI	dcb $FF,$00
		
PROXIMITY
	LDA $14E0,x		;sprite x high
	XBA
	LDA $E4,x		;sprite x low
	REP #$20		;16bitA
	SEC
	SBC $94			;sub mario x
	SEP #$20		;8bitA
	PHA			;preserve for routine jump
	JSR SUB_HORZ_POS	;horizontal distance
	PLA			;restore
	EOR EORTBLI,y		;invert if needed
	CMP $7FAB34,x		;range define by Extra Prop 2*
	BCS PRange_Out		;return not within range
	LDA #$01		;Z = 0
	RTS

PRange_Out
	LDA #$00		;Z = 1
	RTS


;;;;;;;;;;;;;;;;;;;;
; Graphics Routine ;
;;;;;;;;;;;;;;;;;;;;

TILEMAP:	dcb $C8,$A8,$C8		; the third frame is the death frame

SUB_GFX:
	JSR GET_DRAW_INFO

	LDA $157C,x             ; $02 = direction
        STA $02

        LDA $14C8,x		; If killed...
        CMP #$02
	BNE NOT_KILLED
	LDA #$02                ;    ...set killed frame
        STA $03			
        LDA $15F6,x		;    ...flip vertically
        ORA #$80
        STA $15F6,x
	BRA DRAW_SPRITE
NOT_KILLED:
        LDA $14                 ; Set walking frame based on frame counter
        LSR A                   
        LSR A                   
        LSR A                   
        CLC                     
        ADC $15E9               
        AND #$01                
        STA $03                 
DRAW_SPRITE:
	PHX

	LDA $00                 ; Tile x position = sprite x location ($00)
        STA $0300,y             

        LDA $01                 ; Tile y position = sprite y location ($01)
        STA $0301,y

        LDA $15F6,x             ; Yile properties xyppccct, format
        ORA $64                 ; Add in tile priority of level
        STA $0303,y

        LDX $03                 ; Store tile
        LDA TILEMAP,x
        STA $0302,y
        PLX

        LDY #$02                ; Set tiles to 16x16
        LDA #$00                ; We drew 1 tile
        JSL $01B7B3
        RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GET_DRAW_INFO
; This is a helper for the graphics routine.  It sets off screen flags, and sets up
; variables.  It will return with the following:
;
;		Y = index to sprite OAM ($300)
;		$00 = sprite x position relative to screen boarder
;		$01 = sprite y position relative to screen boarder  
;
; It is adapted from the subroutine at $03B760
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SPR_T1              dcb $0C,$1C
SPR_T2              dcb $01,$02

GET_DRAW_INFO       STZ $186C,x             ; reset sprite offscreen flag, vertical
                    STZ $15A0,x             ; reset sprite offscreen flag, horizontal
                    LDA $E4,x               ; \
                    CMP $1A                 ;  | set horizontal offscreen if necessary
                    LDA $14E0,x             ;  |
                    SBC $1B                 ;  |
                    BEQ ON_SCREEN_X         ;  |
                    INC $15A0,x             ; /

ON_SCREEN_X         LDA $14E0,x             ; \
                    XBA                     ;  |
                    LDA $E4,x               ;  |
                    REP #$20                ;  |
                    SEC                     ;  |
                    SBC $1A                 ;  | mark sprite invalid if far enough off screen
                    CLC                     ;  |
                    ADC.W #$0040            ;  |
                    CMP.W #$0180            ;  |
                    SEP #$20                ;  |
                    ROL A                   ;  |
                    AND #$01                ;  |
                    STA $15C4,x             ; / 
                    BNE INVALID             ; 
                    
                    LDY #$00                ; \ set up loop:
                    LDA $1662,x             ;  | 
                    AND #$20                ;  | if not smushed (1662 & 0x20), go through loop twice
                    BEQ ON_SCREEN_LOOP      ;  | else, go through loop once
                    INY                     ; / 
ON_SCREEN_LOOP      LDA $D8,x               ; \ 
                    CLC                     ;  | set vertical offscreen if necessary
                    ADC SPR_T1,y            ;  |
                    PHP                     ;  |
                    CMP $1C                 ;  | (vert screen boundry)
                    ROL $00                 ;  |
                    PLP                     ;  |
                    LDA $14D4,x             ;  | 
                    ADC #$00                ;  |
                    LSR $00                 ;  |
                    SBC $1D                 ;  |
                    BEQ ON_SCREEN_Y         ;  |
                    LDA $186C,x             ;  | (vert offscreen)
                    ORA SPR_T2,y            ;  |
                    STA $186C,x             ;  |
ON_SCREEN_Y         DEY                     ;  |
                    BPL ON_SCREEN_LOOP      ; /

                    LDY $15EA,x             ; get offset to sprite OAM
                    LDA $E4,x               ; \ 
                    SEC                     ;  | 
                    SBC $1A                 ;  | $00 = sprite x position relative to screen boarder
                    STA $00                 ; / 
                    LDA $D8,x               ; \ 
                    SEC                     ;  | 
                    SBC $1C                 ;  | $01 = sprite y position relative to screen boarder
                    STA $01                 ; / 
                    RTS                     ; return

INVALID             PLA                     ; \ return from *main gfx routine* subroutine...
                    PLA                     ;  |    ...(not just this subroutine)
                    RTS                     ; /

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SUB_OFF_SCREEN
; This subroutine deals with sprites that have moved off screen
; It is adapted from the subroutine at $01AC0D
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    
SPR_T12             dcb $40,$B0
SPR_T13             dcb $01,$FF
SPR_T14             dcb $30,$C0,$A0,$C0,$A0,$F0,$60,$90		;bank 1 sizes
		            dcb $30,$C0,$A0,$80,$A0,$40,$60,$B0		;bank 3 sizes
SPR_T15             dcb $01,$FF,$01,$FF,$01,$FF,$01,$FF		;bank 1 sizes
					dcb $01,$FF,$01,$FF,$01,$00,$01,$FF		;bank 3 sizes

SUB_OFF_SCREEN_X1   LDA #$02                ; \ entry point of routine determines value of $03
                    BRA STORE_03            ;  | (table entry to use on horizontal levels)
SUB_OFF_SCREEN_X2   LDA #$04                ;  | 
                    BRA STORE_03            ;  |
SUB_OFF_SCREEN_X3   LDA #$06                ;  |
                    BRA STORE_03            ;  |
SUB_OFF_SCREEN_X4   LDA #$08                ;  |
                    BRA STORE_03            ;  |
SUB_OFF_SCREEN_X5   LDA #$0A                ;  |
                    BRA STORE_03            ;  |
SUB_OFF_SCREEN_X6   LDA #$0C                ;  |
                    BRA STORE_03            ;  |
SUB_OFF_SCREEN_X7   LDA #$0E                ;  |
STORE_03			STA $03					;  |            
					BRA START_SUB			;  |
SUB_OFF_SCREEN_X0   STZ $03					; /

START_SUB           JSR SUB_IS_OFF_SCREEN   ; \ if sprite is not off screen, return
                    BEQ RETURN_35           ; /
                    LDA $5B                 ; \  goto VERTICAL_LEVEL if vertical level
                    AND #$01                ; |
                    BNE VERTICAL_LEVEL      ; /     
                    LDA $D8,x               ; \
                    CLC                     ; | 
                    ADC #$50                ; | if the sprite has gone off the bottom of the level...
                    LDA $14D4,x             ; | (if adding 0x50 to the sprite y position would make the high byte >= 2)
                    ADC #$00                ; | 
                    CMP #$02                ; | 
                    BPL ERASE_SPRITE        ; /    ...erase the sprite
                    LDA $167A,x             ; \ if "process offscreen" flag is set, return
                    AND #$04                ; |
                    BNE RETURN_35           ; /
                    LDA $13                 ;A:8A00 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdiZcHC:0756 VC:176 00 FL:205
                    AND #$01                ;A:8A01 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizcHC:0780 VC:176 00 FL:205
                    ORA $03                 ;A:8A01 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizcHC:0796 VC:176 00 FL:205
                    STA $01                 ;A:8A01 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizcHC:0820 VC:176 00 FL:205
                    TAY                     ;A:8A01 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizcHC:0844 VC:176 00 FL:205
                    LDA $1A                 ;A:8A01 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizcHC:0858 VC:176 00 FL:205
                    CLC                     ;A:8A00 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdiZcHC:0882 VC:176 00 FL:205
                    ADC SPR_T14,y           ;A:8A00 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdiZcHC:0896 VC:176 00 FL:205
                    ROL $00                 ;A:8AC0 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:eNvMXdizcHC:0928 VC:176 00 FL:205
                    CMP $E4,x               ;A:8AC0 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:eNvMXdizCHC:0966 VC:176 00 FL:205
                    PHP                     ;A:8AC0 X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizCHC:0996 VC:176 00 FL:205
                    LDA $1B                 ;A:8AC0 X:0009 Y:0001 D:0000 DB:01 S:01F0 P:envMXdizCHC:1018 VC:176 00 FL:205
                    LSR $00                 ;A:8A00 X:0009 Y:0001 D:0000 DB:01 S:01F0 P:envMXdiZCHC:1042 VC:176 00 FL:205
                    ADC SPR_T15,y           ;A:8A00 X:0009 Y:0001 D:0000 DB:01 S:01F0 P:envMXdizcHC:1080 VC:176 00 FL:205
                    PLP                     ;A:8AFF X:0009 Y:0001 D:0000 DB:01 S:01F0 P:eNvMXdizcHC:1112 VC:176 00 FL:205
                    SBC $14E0,x             ;A:8AFF X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizCHC:1140 VC:176 00 FL:205
                    STA $00                 ;A:8AFF X:0009 Y:0001 D:0000 DB:01 S:01F1 P:eNvMXdizCHC:1172 VC:176 00 FL:205
                    LSR $01                 ;A:8AFF X:0009 Y:0001 D:0000 DB:01 S:01F1 P:eNvMXdizCHC:1196 VC:176 00 FL:205
                    BCC SPR_L31             ;A:8AFF X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdiZCHC:1234 VC:176 00 FL:205
                    EOR #$80                ;A:8AFF X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdiZCHC:1250 VC:176 00 FL:205
                    STA $00                 ;A:8A7F X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizCHC:1266 VC:176 00 FL:205
SPR_L31             LDA $00                 ;A:8A7F X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizCHC:1290 VC:176 00 FL:205
                    BPL RETURN_35           ;A:8A7F X:0009 Y:0001 D:0000 DB:01 S:01F1 P:envMXdizCHC:1314 VC:176 00 FL:205
ERASE_SPRITE        LDA $14C8,x             ; \ if sprite status < 8, permanently erase sprite
                    CMP #$08                ; |
                    BCC KILL_SPRITE         ; /    
                    LDY $161A,x             ;A:FF08 X:0007 Y:0001 D:0000 DB:01 S:01F3 P:envMXdiZCHC:1108 VC:059 00 FL:2878
                    CPY #$FF                ;A:FF08 X:0007 Y:0000 D:0000 DB:01 S:01F3 P:envMXdiZCHC:1140 VC:059 00 FL:2878
                    BEQ KILL_SPRITE         ;A:FF08 X:0007 Y:0000 D:0000 DB:01 S:01F3 P:envMXdizcHC:1156 VC:059 00 FL:2878
                    LDA #$00                ;A:FF08 X:0007 Y:0000 D:0000 DB:01 S:01F3 P:envMXdizcHC:1172 VC:059 00 FL:2878
                    STA $1938,y             ;A:FF00 X:0007 Y:0000 D:0000 DB:01 S:01F3 P:envMXdiZcHC:1188 VC:059 00 FL:2878
KILL_SPRITE         STZ $14C8,x             ; erase sprite
RETURN_35           RTS                     ; return

VERTICAL_LEVEL      LDA $167A,x             ; \ if "process offscreen" flag is set, return
                    AND #$04                ; |
                    BNE RETURN_35           ; /
                    LDA $13                 ; \
                    LSR A                   ; | 
                    BCS RETURN_35           ; /
                    LDA $E4,x               ; \ 
                    CMP #$00                ;  | if the sprite has gone off the side of the level...
                    LDA $14E0,x             ;  |
                    SBC #$00                ;  |
                    CMP #$02                ;  |
                    BCS ERASE_SPRITE        ; /  ...erase the sprite
                    LDA $13                 ;A:0000 X:0009 Y:00E4 D:0000 DB:01 S:01F3 P:eNvMXdizcHC:1218 VC:250 00 FL:5379
                    LSR A                   ;A:0016 X:0009 Y:00E4 D:0000 DB:01 S:01F3 P:envMXdizcHC:1242 VC:250 00 FL:5379
                    AND #$01                ;A:000B X:0009 Y:00E4 D:0000 DB:01 S:01F3 P:envMXdizcHC:1256 VC:250 00 FL:5379
                    STA $01                 ;A:0001 X:0009 Y:00E4 D:0000 DB:01 S:01F3 P:envMXdizcHC:1272 VC:250 00 FL:5379
                    TAY                     ;A:0001 X:0009 Y:00E4 D:0000 DB:01 S:01F3 P:envMXdizcHC:1296 VC:250 00 FL:5379
                    LDA $1C                 ;A:001A X:0009 Y:0001 D:0000 DB:01 S:01F3 P:eNvMXdizcHC:0052 VC:251 00 FL:5379
                    CLC                     ;A:00BD X:0009 Y:0001 D:0000 DB:01 S:01F3 P:eNvMXdizcHC:0076 VC:251 00 FL:5379
                    ADC SPR_T12,y           ;A:00BD X:0009 Y:0001 D:0000 DB:01 S:01F3 P:eNvMXdizcHC:0090 VC:251 00 FL:5379
                    ROL $00                 ;A:006D X:0009 Y:0001 D:0000 DB:01 S:01F3 P:enVMXdizCHC:0122 VC:251 00 FL:5379
                    CMP $D8,x               ;A:006D X:0009 Y:0001 D:0000 DB:01 S:01F3 P:eNVMXdizcHC:0160 VC:251 00 FL:5379
                    PHP                     ;A:006D X:0009 Y:0001 D:0000 DB:01 S:01F3 P:eNVMXdizcHC:0190 VC:251 00 FL:5379
                    LDA.W $001D             ;A:006D X:0009 Y:0001 D:0000 DB:01 S:01F2 P:eNVMXdizcHC:0212 VC:251 00 FL:5379
                    LSR $00                 ;A:0000 X:0009 Y:0001 D:0000 DB:01 S:01F2 P:enVMXdiZcHC:0244 VC:251 00 FL:5379
                    ADC SPR_T13,y           ;A:0000 X:0009 Y:0001 D:0000 DB:01 S:01F2 P:enVMXdizCHC:0282 VC:251 00 FL:5379
                    PLP                     ;A:0000 X:0009 Y:0001 D:0000 DB:01 S:01F2 P:envMXdiZCHC:0314 VC:251 00 FL:5379
                    SBC $14D4,x             ;A:0000 X:0009 Y:0001 D:0000 DB:01 S:01F3 P:eNVMXdizcHC:0342 VC:251 00 FL:5379
                    STA $00                 ;A:00FF X:0009 Y:0001 D:0000 DB:01 S:01F3 P:eNvMXdizcHC:0374 VC:251 00 FL:5379
                    LDY $01                 ;A:00FF X:0009 Y:0001 D:0000 DB:01 S:01F3 P:eNvMXdizcHC:0398 VC:251 00 FL:5379
                    BEQ SPR_L38             ;A:00FF X:0009 Y:0001 D:0000 DB:01 S:01F3 P:envMXdizcHC:0422 VC:251 00 FL:5379
                    EOR #$80                ;A:00FF X:0009 Y:0001 D:0000 DB:01 S:01F3 P:envMXdizcHC:0438 VC:251 00 FL:5379
                    STA $00                 ;A:007F X:0009 Y:0001 D:0000 DB:01 S:01F3 P:envMXdizcHC:0454 VC:251 00 FL:5379
SPR_L38             LDA $00                 ;A:007F X:0009 Y:0001 D:0000 DB:01 S:01F3 P:envMXdizcHC:0478 VC:251 00 FL:5379
                    BPL RETURN_35           ;A:007F X:0009 Y:0001 D:0000 DB:01 S:01F3 P:envMXdizcHC:0502 VC:251 00 FL:5379
                    BMI ERASE_SPRITE        ;A:8AFF X:0002 Y:0000 D:0000 DB:01 S:01F3 P:eNvMXdizcHC:0704 VC:184 00 FL:5490

SUB_IS_OFF_SCREEN   LDA $15A0,x             ; \ if sprite is on screen, accumulator = 0 
                    ORA $186C,x             ; |  
                    RTS                     ; / return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SUB_HORZ_POS
; This routine determines which side of the sprite Mario is on.  It sets the Y register
; to the direction such that the sprite would face Mario
; It is ripped from $03B817
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SUB_HORZ_POS		LDY #$00				;A:25D0 X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1020 VC:097 00 FL:31642
					LDA $94					;A:25D0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:envMXdiZCHC:1036 VC:097 00 FL:31642
					SEC                     ;A:25F0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1060 VC:097 00 FL:31642
					SBC $E4,x				;A:25F0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1074 VC:097 00 FL:31642
					STA $0F					;A:25F4 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1104 VC:097 00 FL:31642
					LDA $95					;A:25F4 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1128 VC:097 00 FL:31642
					SBC $14E0,x				;A:2500 X:0006 Y:0000 D:0000 DB:03 S:01ED P:envMXdiZcHC:1152 VC:097 00 FL:31642
					BPL SPR_L16             ;A:25FF X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1184 VC:097 00 FL:31642
					INY                     ;A:25FF X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1200 VC:097 00 FL:31642
SPR_L16				RTS                     ;A:25FF X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:1214 VC:097 00 FL:31642


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SUB_VERT_POS
; This routine determines if Mario is above or below the sprite.  It sets the Y register
; to the direction such that the sprite would face Mario
; It is ripped from $03B829
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SUB_VERT_POS		LDY #$00               ;A:25A1 X:0007 Y:0001 D:0000 DB:03 S:01EA P:envMXdizCHC:0130 VC:085 00 FL:924
					LDA $96                ;A:25A1 X:0007 Y:0000 D:0000 DB:03 S:01EA P:envMXdiZCHC:0146 VC:085 00 FL:924
					SEC                    ;A:2546 X:0007 Y:0000 D:0000 DB:03 S:01EA P:envMXdizCHC:0170 VC:085 00 FL:924
					SBC $D8,x              ;A:2546 X:0007 Y:0000 D:0000 DB:03 S:01EA P:envMXdizCHC:0184 VC:085 00 FL:924
					STA $0F                ;A:25D6 X:0007 Y:0000 D:0000 DB:03 S:01EA P:eNvMXdizcHC:0214 VC:085 00 FL:924
					LDA $97                ;A:25D6 X:0007 Y:0000 D:0000 DB:03 S:01EA P:eNvMXdizcHC:0238 VC:085 00 FL:924
					SBC $14D4,x            ;A:2501 X:0007 Y:0000 D:0000 DB:03 S:01EA P:envMXdizcHC:0262 VC:085 00 FL:924
					BPL SPR_L11            ;A:25FF X:0007 Y:0000 D:0000 DB:03 S:01EA P:eNvMXdizcHC:0294 VC:085 00 FL:924
					INY                    ;A:25FF X:0007 Y:0000 D:0000 DB:03 S:01EA P:eNvMXdizcHC:0310 VC:085 00 FL:924
SPR_L11				RTS                    ;A:25FF X:0007 Y:0001 D:0000 DB:03 S:01EA P:envMXdizcHC:0324 VC:085 00 FL:924

