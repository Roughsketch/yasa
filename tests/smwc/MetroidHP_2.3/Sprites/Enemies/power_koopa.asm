Damage_flag = $58

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Power Koopa - for Metroid Health Patch
;; This Koopa takes away 50 HP when touched. This is to demonstrate
;; how to set costum hit decrements in a sprite.
;; based on Classic Koopa, by mikeyk
;;
;; Description: 
;;
;; Uses first extra bit: YES
;; If the first extra bit is set, Yoshi abilities will be enambled
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Extra Property Byte 1
;;    Bit 0 - Move fast
;;    Bit 1 - Stay on ledges
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	EXTRA_BITS = $7FAB10  
	EXTRA_PROP_1 = $7FAB28
	EXTRA_PROP_2 = $7FAB34

	SprGfxRt1x1	= $0190B2
	
	RAM_SprOAMIndex = $15EA
	OAM_DispX	= $0300
	OAM_DispY	= $0301
	OAM_Tile	= $0302
	OAM_Prop	= $0303
	OAM_Tile2DispX	= $0304
	OAM_Tile2DispY	= $0305
	OAM_Tile2	= $0306
	OAM_Tile2Prop	= $0307
	OAM_Tile3DispX	= $0308
	OAM_Tile3DispY	= $0309
	OAM_Tile3	= $030A
	OAM_Tile3Prop	= $030B
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
; sprite init JSL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        dcb "INIT"
        PHY
        JSR SUB_HORZ_POS
        TYA
        STA $157C,x
        PLY
	LDA $1588,x            
        ORA #$04
        STA $1588,x            
        RTL


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sprite main JSL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        dcb "MAIN"
        PHB
        PHK
        PLB
	;;         LDA $14C8,x
	CMP #$07
	BEQ InMouth
	PHA			; Acts like Buzzy Beetle if not in mouth
	LDA #$11
	STA $9E,x
	PLA
	CMP #$09
	BCS InShell
	CMP #$04
	BEQ Return
	CMP #$06
	BEQ Return
        JSR CODE_START
        PLB
        RTL
	
InMouth:
	LDA EXTRA_BITS,x
	AND #04
	BEQ DontGiveShellPower
	LDA EXTRA_PROP_2,x
	AND #$02
	STA $141E
	LDA #$04		; Acts like a Koopa shell if in mouth
	STA $9E,x
DontGiveShellPower:	
	PLB
        RTL

InShell:
	LDY.W RAM_SprOAMIndex,X
	
	LDA.W OAM_Tile,Y
	CLC
	ADC #$06
	STA.W OAM_Tile,Y
	
	LDA.W OAM_Tile2,Y
	CLC
	ADC #$06
	STA.W OAM_Tile2,Y
	
	LDA.W OAM_Tile3,Y
	CMP #$8A
	BCS NoSet3
	CLC
	ADC #$06
	STA.W OAM_Tile3,Y
NoSet3:

	LDA $1540,x		; Set stunned timer if not set
	BNE Return
	LDA #$FF
	STA $1540,x
Return:		
	PLB
        RTL
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sprite main code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

X_SPEED:
	dcb $08,$F8,$0C,$F4

CODE_START
	JSR SUB_GFX1
	LDA $9D                 ; \ if sprites locked, return
	BNE RETURN2             ; /
	LDA $14C8,x
	CMP #$08
	BNE RETURN2
	
	JSR SUB_OFF_SCREEN_X0   ; handle off screen situation

        LDA $1588,x             ; \ if sprite is in contact with an object...
        AND #$03                ;  |
        BEQ NO_OBJ_CONTACT      ;  |
        LDA $157C,x             ;  | flip the direction status
        EOR #$01                ;  |
        STA $157C,x             ; /	
NO_OBJ_CONTACT:
	
	LDA EXTRA_PROP_1,x      ; Stay on ledges if bit is set
	AND #$02                ;
	BEQ NO_CHANGE 
	LDA $1588,x             ; run the subroutine if the sprite is in the air...
	ORA $151C,x             ; ...and not already turning
	BNE NO_CHANGE           ;
	JSR SUB_CHANGE_DIR      ;
        LDA #$01                ; set that we're already turning
	STA $151C,x             ;

NO_CHANGE:
	LDA $1588,x             ; if on the ground, reset the turn counter
        AND #$04
        BEQ FALLING
        STZ $151C,x
        STZ $AA,x
FALLING:

        LDY $157C,x             ; \ set x speed based on direction
	LDA EXTRA_PROP_1,x
	AND #$01
	BEQ NotFast
	INY
	INY
NotFast:
        LDA X_SPEED,y           
        STA $B6,x   	

	JSL $01802A             ; update position based on speed values
        JSL $018032             ; interact with other sprites
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;This code sets the custom hit count. *The shell stuff is for this sprite only, since it's a koopa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
JSL $01A7DC			; Interact with Mario
BCC return2			; if not touching, return
LDA $14C8,x			; if in shell*
CMP #$09			; return*
BEQ Return2
LDA $1497			;If mario is Invulnerable
BNE Return2			;then don't damage mario
LDA #$02			;set the hurt flag for custom sprites (#$02)
STA Damage_flag		;in the heal/hurt routine
LDA #$32			;This is the number of points
STA $1900			;to take away IN HEX.
                    
RETURN2:	
	RTS                     ; return

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SUB_CHANGE_DIR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SUB_CHANGE_DIR:
	LDA $B6,x
        EOR #$FF
        INC A
        STA $B6,x
        LDA $157C,x
        EOR #$01
        STA $157C,x
        RTS        


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  graphics routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

VERT_DISP:
	dcb $F0,$00,$F1,$01,$00,$00
TILEMAP:
	dcb $82,$A0,$82,$A2,$8C,$8C
PROPERTIES:
	dcb $40,$00

SUB_GFX1:
	JSR GET_DRAW_INFO

	PHX
	LDA $157C,x
	TAX
	LDA PROPERTIES,x
	STA $0F
	PLX   
	
	LDA $14C8,x
	CMP #$08
	BEQ Normal

StarKilled:
	LDA #$04
	STA $03
	LDA $0F
	ORA #$80
	STA $0F
	BRA SetUpLoop

Normal:		            
	;; 	LDA $1588,x
	;; 	AND #$04
	;; 	BEQ SetFrame	
        LDA $14                 ;\ $03 = index to frame start (0 or 2)
        LSR A                   ; |
        LSR A                   ; |
        LSR A                   ; |
        CLC                     ; |
        ADC $15E9               ; |
        AND #$01                ; |
        ASL A                   ; |
SetFrame:	
        STA $03                 ;/


SetUpLoop:	
        PHX                     
        LDX #$01                ; run loop 4 times, cuz 4 tiles per frame
LOOP_START:
	PHX                     ; push, current tile

        LDA $00                 ; \ tile x position = sprite x location ($00) + tile displacement
        CLC                     ; |
        STA $0300,y             ; /

	TXA
	CLC
	ADC $03
	TAX
	
        LDA $01                 ; |
        CLC                     ; | tile y position = sprite y location ($01) + tile displacement
        ADC VERT_DISP,x         ; |
        STA $0301,y             ; /

        LDA TILEMAP,x           ; \ store tile
        STA $0302,y             ; /
	
        LDX $15E9               ;
        LDA $15F6,x             ; get palette info
        ORA $0F
        ORA $64                 ; add in tile priority of level
        STA $0303,y             ; store tile properties

        PLX                     ; \ pull, current tile
        INY                     ; | increase index to sprite tile map ($300)...
        INY                     ; |    ...we wrote 1 16x16 tile...
        INY                     ; |    ...sprite OAM is 8x8...
        INY                     ; |    ...so increment 4 times
        DEX                     ; | go to next tile of frame and loop
        BPL LOOP_START

        PLX                     ; pull, X = sprite index

        LDY #$02               ; \ we've already set 460 so use FF
        LDA #$01                ; | A = number of tiles drawn - 1
        JSL $01B7B3             ; / don't draw if offscreen
        RTS                     ; return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; routines below can be shared by all sprites.  they are ripped from original
; SMW and poorly documented
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $B760 - graphics routine helper - shared
; sets off screen flags and sets index to OAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                    ;org $03B75C

TABLE1              dcb $0C,$1C
TABLE2              dcb $01,$02

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
                    ADC TABLE1,y            ;  |
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
                    ORA TABLE2,y            ;  |
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
; $B817 - horizontal mario/sprite check - shared
; Y = 1 if mario left of sprite??
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                    ;org $03B817                ; Y = 1 if contact

SUB_GET_DIR         LDY #$00                ;A:25D0 X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1020 VC:097 00 FL:31642
                    LDA $94                 ;A:25D0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:envMXdiZCHC:1036 VC:097 00 FL:31642
                    SEC                     ;A:25F0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1060 VC:097 00 FL:31642
                    SBC $E4,x               ;A:25F0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1074 VC:097 00 FL:31642
                    STA $0F                 ;A:25F4 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1104 VC:097 00 FL:31642
                    LDA $95                 ;A:25F4 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1128 VC:097 00 FL:31642
                    SBC $14E0,x             ;A:2500 X:0006 Y:0000 D:0000 DB:03 S:01ED P:envMXdiZcHC:1152 VC:097 00 FL:31642
                    BPL LABEL16             ;A:25FF X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1184 VC:097 00 FL:31642
                    INY                     ;A:25FF X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1200 VC:097 00 FL:31642
LABEL16             RTS                     ;A:25FF X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:1214 VC:097 00 FL:31642

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $B829 - vertical mario/sprite position check - shared
; Y = 1 if mario below sprite??
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                    ;org $03B829 

SUB_VERT_POS        LDY #$00               ;A:25A1 X:0007 Y:0001 D:0000 DB:03 S:01EA P:envMXdizCHC:0130 VC:085 00 FL:924
                    LDA $96                ;A:25A1 X:0007 Y:0000 D:0000 DB:03 S:01EA P:envMXdiZCHC:0146 VC:085 00 FL:924
                    SEC                    ;A:2546 X:0007 Y:0000 D:0000 DB:03 S:01EA P:envMXdizCHC:0170 VC:085 00 FL:924
                    SBC $D8,x              ;A:2546 X:0007 Y:0000 D:0000 DB:03 S:01EA P:envMXdizCHC:0184 VC:085 00 FL:924
                    STA $0F                ;A:25D6 X:0007 Y:0000 D:0000 DB:03 S:01EA P:eNvMXdizcHC:0214 VC:085 00 FL:924
                    LDA $97                ;A:25D6 X:0007 Y:0000 D:0000 DB:03 S:01EA P:eNvMXdizcHC:0238 VC:085 00 FL:924
                    SBC $14D4,x            ;A:2501 X:0007 Y:0000 D:0000 DB:03 S:01EA P:envMXdizcHC:0262 VC:085 00 FL:924
                    BPL LABEL11            ;A:25FF X:0007 Y:0000 D:0000 DB:03 S:01EA P:eNvMXdizcHC:0294 VC:085 00 FL:924
                    INY                    ;A:25FF X:0007 Y:0000 D:0000 DB:03 S:01EA P:eNvMXdizcHC:0310 VC:085 00 FL:924
LABEL11             RTS                    ;A:25FF X:0007 Y:0001 D:0000 DB:03 S:01EA P:envMXdizcHC:0324 VC:085 00 FL:924


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $B817 - horizontal mario/sprite check - shared
; Y = 1 if mario left of sprite??
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                    ;org $03B817        

SUB_HORZ_POS        LDY #$00                ;A:25D0 X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1020 VC:097 00 FL:31642
                    LDA $94                 ;A:25D0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:envMXdiZCHC:1036 VC:097 00 FL:31642
                    SEC                     ;A:25F0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1060 VC:097 00 FL:31642
                    SBC $E4,x               ;A:25F0 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizCHC:1074 VC:097 00 FL:31642
                    STA $0F                 ;A:25F4 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1104 VC:097 00 FL:31642
                    LDA $95                 ;A:25F4 X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1128 VC:097 00 FL:31642
                    SBC $14E0,x             ;A:2500 X:0006 Y:0000 D:0000 DB:03 S:01ED P:envMXdiZcHC:1152 VC:097 00 FL:31642
                    BPL LABEL16             ;A:25FF X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1184 VC:097 00 FL:31642
                    INY                     ;A:25FF X:0006 Y:0000 D:0000 DB:03 S:01ED P:eNvMXdizcHC:1200 VC:097 00 FL:31642
LABEL16             RTS                     ;A:25FF X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:1214 VC:097 00 FL:31642


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $B85D - off screen processing code - shared
; sprites enter at different points
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                    ;org $03B83B             

TABLE3              dcb $40,$B0
TABLE6              dcb $01,$FF 
TABLE4              dcb $30,$C0,$A0,$80,$A0,$40,$60,$B0 
TABLE5              dcb $01,$FF,$01,$FF,$01,$00,$01,$FF

SUB_OFF_SCREEN_X0   LDA #$06                ; \ entry point of routine determines value of $03
                    BRA STORE_03            ;  | 
SUB_OFF_SCREEN_X1   LDA #$04                ;  |
                    BRA STORE_03            ;  |
SUB_OFF_SCREEN_X2   LDA #$02                ;  |
STORE_03            STA $03                 ;  |
                    BRA START_SUB           ;  |
SUB_OFF_SCREEN_HB   STZ $03                 ; /

START_SUB           JSR SUB_IS_OFF_SCREEN   ; \ if sprite is not off screen, return
                    BEQ RETURN_2            ; /    
                    LDA $5B                 ; \  goto VERTICAL_LEVEL if vertical level
                    AND #$01                ;  |
                    BNE VERTICAL_LEVEL      ; /     
                    LDA $D8,x               ; \
                    CLC                     ;  | 
                    ADC #$50                ;  | if the sprite has gone off the bottom of the level...
                    LDA $14D4,x             ;  | (if adding 0x50 to the sprite y position would make the high byte >= 2)
                    ADC #$00                ;  | 
                    CMP #$02                ;  | 
                    BPL ERASE_SPRITE        ; /    ...erase the sprite
                    LDA $167A,x             ; \ if "process offscreen" flag is set, return
                    AND #$04                ;  |
                    BNE RETURN_2            ; /
                    LDA $13                 ; \ 
                    AND #$01                ;  | 
                    ORA $03                 ;  | 
                    STA $01                 ;  |
                    TAY                     ; /
                    LDA $1A                 ;x boundry ;A:0101 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0256 VC:090 00 FL:16953
                    CLC                     ;A:0100 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdiZcHC:0280 VC:090 00 FL:16953
                    ADC TABLE4,y            ;A:0100 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdiZcHC:0294 VC:090 00 FL:16953
                    ROL $00                 ;A:01C0 X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizcHC:0326 VC:090 00 FL:16953
                    CMP $E4,x               ;x pos ;A:01C0 X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizcHC:0364 VC:090 00 FL:16953
                    PHP                     ;A:01C0 X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizCHC:0394 VC:090 00 FL:16953
                    LDA $1B                 ;x boundry hi ;A:01C0 X:0006 Y:0001 D:0000 DB:03 S:01EC P:eNvMXdizCHC:0416 VC:090 00 FL:16953
                    LSR $00                 ;A:0100 X:0006 Y:0001 D:0000 DB:03 S:01EC P:envMXdiZCHC:0440 VC:090 00 FL:16953
                    ADC TABLE5,y            ;A:0100 X:0006 Y:0001 D:0000 DB:03 S:01EC P:envMXdizcHC:0478 VC:090 00 FL:16953
                    PLP                     ;A:01FF X:0006 Y:0001 D:0000 DB:03 S:01EC P:eNvMXdizcHC:0510 VC:090 00 FL:16953
                    SBC $14E0,x             ;x pos high ;A:01FF X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizCHC:0538 VC:090 00 FL:16953
                    STA $00                 ;A:01FE X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizCHC:0570 VC:090 00 FL:16953
                    LSR $01                 ;A:01FE X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizCHC:0594 VC:090 00 FL:16953
                    BCC LABEL20             ;A:01FE X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdiZCHC:0632 VC:090 00 FL:16953
                    EOR #$80                ;A:01FE X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdiZCHC:0648 VC:090 00 FL:16953
                    STA $00                 ;A:017E X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizCHC:0664 VC:090 00 FL:16953
LABEL20             LDA $00                 ;A:017E X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizCHC:0688 VC:090 00 FL:16953
                    BPL RETURN_2            ;A:017E X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizCHC:0712 VC:090 00 FL:16953
ERASE_SPRITE        LDA $14C8,x             ; \ if sprite status < 8, permanently erase sprite
                    CMP #$08                ;  |
                    BCC KILL_SPRITE         ; /
                    LDY $161A,x             ;A:FF08 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdiZCHC:0140 VC:071 00 FL:21152
                    CPY #$FF                ;A:FF08 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizCHC:0172 VC:071 00 FL:21152
                    BEQ KILL_SPRITE         ;A:FF08 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0188 VC:071 00 FL:21152
                    LDA #$00                ; \ mark sprite to come back    A:FF08 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0204 VC:071 00 FL:21152
                    STA $1938,y             ; /                             A:FF00 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdiZcHC:0220 VC:071 00 FL:21152
KILL_SPRITE         STZ $14C8,x             ; erase sprite
RETURN_2            RTS                     ; return

VERTICAL_LEVEL      LDA $167A,x             ; \ if "process offscreen" flag is set, return
                    AND #$04                ;  |
                    BNE RETURN_2            ; /
                    LDA $13                 ; \ only handle every other frame??
                    LSR A                   ;  | 
                    BCS RETURN_2            ; /
                    AND #$01                ;A:0227 X:0006 Y:00EC D:0000 DB:03 S:01ED P:envMXdizcHC:0228 VC:112 00 FL:1142
                    STA $01                 ;A:0201 X:0006 Y:00EC D:0000 DB:03 S:01ED P:envMXdizcHC:0244 VC:112 00 FL:1142
                    TAY                     ;A:0201 X:0006 Y:00EC D:0000 DB:03 S:01ED P:envMXdizcHC:0268 VC:112 00 FL:1142
                    LDA $1C                 ;A:0201 X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0282 VC:112 00 FL:1142
                    CLC                     ;A:02BD X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizcHC:0306 VC:112 00 FL:1142
                    ADC TABLE3,y            ;A:02BD X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizcHC:0320 VC:112 00 FL:1142
                    ROL $00                 ;A:026D X:0006 Y:0001 D:0000 DB:03 S:01ED P:enVMXdizCHC:0352 VC:112 00 FL:1142
                    CMP $D8,x               ;A:026D X:0006 Y:0001 D:0000 DB:03 S:01ED P:enVMXdizCHC:0390 VC:112 00 FL:1142
                    PHP                     ;A:026D X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNVMXdizcHC:0420 VC:112 00 FL:1142
                    LDA.W $001D             ;A:026D X:0006 Y:0001 D:0000 DB:03 S:01EC P:eNVMXdizcHC:0442 VC:112 00 FL:1142
                    LSR $00                 ;A:0200 X:0006 Y:0001 D:0000 DB:03 S:01EC P:enVMXdiZcHC:0474 VC:112 00 FL:1142
                    ADC TABLE6,y            ;A:0200 X:0006 Y:0001 D:0000 DB:03 S:01EC P:enVMXdizCHC:0512 VC:112 00 FL:1142
                    PLP                     ;A:0200 X:0006 Y:0001 D:0000 DB:03 S:01EC P:envMXdiZCHC:0544 VC:112 00 FL:1142
                    SBC $14D4,x             ;A:0200 X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNVMXdizcHC:0572 VC:112 00 FL:1142
                    STA $00                 ;A:02FF X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizcHC:0604 VC:112 00 FL:1142
                    LDY $01                 ;A:02FF X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizcHC:0628 VC:112 00 FL:1142
                    BEQ LABEL22             ;A:02FF X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0652 VC:112 00 FL:1142
                    EOR #$80                ;A:02FF X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0668 VC:112 00 FL:1142
                    STA $00                 ;A:027F X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0684 VC:112 00 FL:1142
LABEL22             LDA $00                 ;A:027F X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0708 VC:112 00 FL:1142
                    BPL RETURN_2            ;A:027F X:0006 Y:0001 D:0000 DB:03 S:01ED P:envMXdizcHC:0732 VC:112 00 FL:1142
                    BMI ERASE_SPRITE        ;A:0280 X:0006 Y:0001 D:0000 DB:03 S:01ED P:eNvMXdizCHC:0170 VC:064 00 FL:1195

SUB_IS_OFF_SCREEN   LDA $15A0,x             ; \ if sprite is on screen, accumulator = 0 
                    ORA $186C,x             ;  |  
                    RTS                     ; / return

NOP