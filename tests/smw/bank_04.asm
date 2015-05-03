ORG $048000
DATA_048000:
        db $80,$B4,$98,$B4,$B0,$B4

DATA_048006:
        db $00,$B3,$18,$B3,$30,$B3,$48,$B3
        db $60,$B3,$78,$B3,$90,$B3,$A8,$B3
        db $C0,$B3,$D8,$B3,$F0,$B3,$08,$B4
        db $20,$B4,$38,$B4,$50,$B4,$68,$B4
        db $80,$B4,$98,$B4,$B0,$B4,$C8,$B4
        db $E0,$B4,$F8,$B4,$10,$B5,$28,$B5
        db $40,$B5,$58,$B5,$70,$B5,$88,$B5
        db $A0,$B5,$B8,$B5,$D0,$B5,$E8,$B5
        db $00,$B6,$18,$B6,$30,$B6,$48,$B6
        db $60,$B6,$78,$B6,$90,$B6,$A8,$B6
        db $C0,$B6,$D8,$B6,$F0,$B6,$08,$B7
        db $20,$B7,$38,$B7,$50,$B7,$68,$B7
        db $80,$B7,$98,$B7,$B0,$B7,$C8,$B7
        db $E0,$B7,$F8,$B7,$10,$B8,$28,$B8
        db $40,$B8,$58,$B8,$70,$B8,$88,$B8
        db $A0,$B8,$B8,$B8,$D0,$B8,$E8,$B8

CODE_048086:
        REP #$30
        STZ $03                                 ;$048088        |
        STZ $05                                 ;$04808A        |
CODE_04808C:
        LDX $03
        LDA.w DATA_048000,X                     ;$04808E        |
        STA $00                                 ;$048091        |
        SEP #$10                                ;$048093        |
        LDY.b #$7E                              ;$048095        |
        STY $02                                 ;$048097        |
        REP #$10                                ;$048099        |
        LDX $05                                 ;$04809B        |
        JSR CODE_0480B9                         ;$04809D        |
        LDA $05                                 ;$0480A0        |
        CLC                                     ;$0480A2        |
        ADC.w #$0020                            ;$0480A3        |
        STA $05                                 ;$0480A6        |
        LDA $03                                 ;$0480A8        |
        INC A                                   ;$0480AA        |
        INC A                                   ;$0480AB        |
        STA $03                                 ;$0480AC        |
        AND.w #$00FF                            ;$0480AE        |
        CMP.w #$0006                            ;$0480B1        |
        BNE CODE_04808C                         ;$0480B4        |
        SEP #$30                                ;$0480B6        |
        RTS                                     ;$0480B8        |

CODE_0480B9:
        LDY.w #$0000
        LDA.w #$0008                            ;$0480BC        |
        STA $07                                 ;$0480BF        |
        STA $09                                 ;$0480C1        |
CODE_0480C3:
        LDA [$00],Y
        STA.w $0AF6,X                           ;$0480C5        |
        INY                                     ;$0480C8        |
        INY                                     ;$0480C9        |
        INX                                     ;$0480CA        |
        INX                                     ;$0480CB        |
        DEC $07                                 ;$0480CC        |
        BNE CODE_0480C3                         ;$0480CE        |
CODE_0480D0:
        LDA [$00],Y
        AND.w #$00FF                            ;$0480D2        |
        STA.w $0AF6,X                           ;$0480D5        |
        INY                                     ;$0480D8        |
        INX                                     ;$0480D9        |
        INX                                     ;$0480DA        |
        DEC $09                                 ;$0480DB        |
        BNE CODE_0480D0                         ;$0480DD        |
        RTS                                     ;$0480DF        |

OW_Tile_Animation:
        LDA $13
        AND.b #$07                              ;$0480E2        |
        BNE CODE_048101                         ;$0480E4        |
        LDX.b #$1F                              ;$0480E6        |
CODE_0480E8:
        LDA.w $0AF6,X
        STA $00                                 ;$0480EB        |
        TXA                                     ;$0480ED        |
        AND.b #$08                              ;$0480EE        |
        BNE CODE_0480F9                         ;$0480F0        |
        ASL $00                                 ;$0480F2        |
        ROL.w $0AF6,X                           ;$0480F4        |
        BRA CODE_0480FE                         ;$0480F7        |

CODE_0480F9:
        LSR $00
        ROR.w $0AF6,X                           ;$0480FB        |
CODE_0480FE:
        DEX
        BPL CODE_0480E8                         ;$0480FF        |
CODE_048101:
        LDA $13
        AND.b #$07                              ;$048103        |
        BNE CODE_04810C                         ;$048105        |
        LDX.b #$20                              ;$048107        |
        JSR CODE_048172                         ;$048109        |
CODE_04810C:
        LDA $13
        AND.b #$07                              ;$04810E        |
        BNE CODE_048123                         ;$048110        |
        LDX.b #$1F                              ;$048112        |
CODE_048114:
        LDA.w $0B36,X
        ASL                                     ;$048117        |
        ROL.w $0B36,X                           ;$048118        |
        DEX                                     ;$04811B        |
        BPL CODE_048114                         ;$04811C        |
        LDX.b #$40                              ;$04811E        |
        JSR CODE_048172                         ;$048120        |
CODE_048123:
        REP #$30
        LDA.w #$0060                            ;$048125        |
        STA $0D                                 ;$048128        |
        STZ $0B                                 ;$04812A        |
CODE_04812C:
        LDX.w #$0038
        LDA $0B                                 ;$04812F        |
        CMP.w #$0020                            ;$048131        |
        BCS CODE_048139                         ;$048134        |
        LDX.w #$0070                            ;$048136        |
CODE_048139:
        TXA
        AND $13                                 ;$04813A        |
        LSR                                     ;$04813C        |
        LSR                                     ;$04813D        |
        CPX.w #$0038                            ;$04813E        |
        BEQ CODE_048144                         ;$048141        |
        LSR                                     ;$048143        |
CODE_048144:
        CLC
        ADC $0B                                 ;$048145        |
        TAX                                     ;$048147        |
        LDA.w DATA_048006,X                     ;$048148        |
        STA $00                                 ;$04814B        |
        SEP #$10                                ;$04814D        |
        LDY.b #$7E                              ;$04814F        |
        STY $02                                 ;$048151        |
        REP #$10                                ;$048153        |
        LDX $0D                                 ;$048155        |
        JSR CODE_0480B9                         ;$048157        |
        LDA $0D                                 ;$04815A        |
        CLC                                     ;$04815C        |
        ADC.w #$0020                            ;$04815D        |
        STA $0D                                 ;$048160        |
        LDA $0B                                 ;$048162        |
        CLC                                     ;$048164        |
        ADC.w #$0010                            ;$048165        |
        STA $0B                                 ;$048168        |
        CMP.w #$0080                            ;$04816A        |
        BNE CODE_04812C                         ;$04816D        |
        SEP #$30                                ;$04816F        |
        RTS                                     ;$048171        |

CODE_048172:
        REP #$20
        LDY.b #$00                              ;$048174        |
CODE_048176:
        PHX
        TXA                                     ;$048177        |
        CLC                                     ;$048178        |
        ADC.w #$000E                            ;$048179        |
        TAX                                     ;$04817C        |
        LDA.w $0AF6,X                           ;$04817D        |
        STA $00                                 ;$048180        |
        PLX                                     ;$048182        |
CODE_048183:
        LDA.w $0AF6,X
        STA $02                                 ;$048186        |
        LDA $00                                 ;$048188        |
        STA.w $0AF6,X                           ;$04818A        |
        LDA $02                                 ;$04818D        |
        STA $00                                 ;$04818F        |
        INX                                     ;$048191        |
        INX                                     ;$048192        |
        INY                                     ;$048193        |
        CPY.b #$08                              ;$048194        |
        BEQ CODE_048176                         ;$048196        |
        CPY.b #$10                              ;$048198        |
        BNE CODE_048183                         ;$04819A        |
        SEP #$20                                ;$04819C        |
        RTS                                     ;$04819E        |

DATA_04819F:
        db $50,$CF,$00,$03,$7E,$78,$7E,$38
        db $50,$EF,$00,$03,$7F,$38,$7F,$78
        db $51,$C3,$00,$03,$7E,$78,$7D,$78
        db $51,$E3,$00,$03,$7E,$F8,$7D,$F8
        db $51,$DB,$00,$03,$7D,$38,$7E,$38
        db $51,$FB,$00,$03,$7D,$B8,$7E,$B8
        db $52,$EF,$00,$03,$7F,$B8,$7F,$F8
        db $53,$0F,$00,$03,$7E,$F8,$7E,$B8
        db $FF

DATA_0481E0:
        db $50,$CF,$40,$02,$FC,$00,$50,$EF
        db $40,$02,$FC,$00,$51,$C3,$40,$02
        db $FC,$00,$51,$E3,$40,$02,$FC,$00
        db $51,$DB,$40,$02,$FC,$00,$51,$FB
        db $40,$02,$FC,$00,$52,$EF,$40,$02
        db $FC,$00,$53,$0F,$40,$02,$FC,$00
        db $FF

DATA_048211:
        db $00,$00,$02,$00,$FE,$FF,$02,$00
        db $00,$00,$02,$00,$FE,$FF,$02,$00
DATA_048221:
        db $00,$00,$11,$01,$EF,$FF,$11,$01
        db $00,$00,$32,$01,$D7,$FF,$32,$01
DATA_048231:
        db $0F,$0F,$07,$07,$07,$03,$03,$03
        db $01,$01,$03,$03,$03,$07,$07,$07

GameMode_0E_Prim:
        PHB
        PHK                                     ;$048242        |
        PLB                                     ;$048243        |
        LDX.b #$01                              ;$048244        |
CODE_048246:
        LDA.w $0DA6,X
        AND.b #$20                              ;$048249        |
        BRA CODE_048261                         ;$04824B        |

        LDA.w $0DBA,X                           ;$04824D        |
        INC A                                   ;$048250        |
        INC A                                   ;$048251        |
        CMP.b #$04                              ;$048252        |
        BCS ADDR_048258                         ;$048254        |
        LDA.b #$04                              ;$048256        |
ADDR_048258:
        CMP.b #$0B
        BCC ADDR_04825E                         ;$04825A        |
        LDA.b #$00                              ;$04825C        |
ADDR_04825E:
        STA.w $0DBA,X
CODE_048261:
        DEX
        BPL CODE_048246                         ;$048262        |
        JSR CODE_0485A7                         ;$048264        |
        JSR OW_Tile_Animation                   ;$048267        |
        LDA.w $13D2                             ;$04826A        |
        BEQ CODE_048275                         ;$04826D        |
        JSR CODE_04F290                         ;$04826F        |
        JMP CODE_04840D                         ;$048272        |

CODE_048275:
        LDA.w $13C9
        BEQ CODE_048281                         ;$048278        |
        JSL CODE_009B80                         ;$04827A        |
        JMP CODE_048410                         ;$04827E        |

CODE_048281:
        LDA.w $1B87
        BEQ CODE_048295                         ;$048284        |
        CMP.b #$05                              ;$048286        |
        BCS CODE_04828F                         ;$048288        |
        LDY.w $0DB2                             ;$04828A        |
        BEQ CODE_048295                         ;$04828D        |
CODE_04828F:
        JSR CODE_04F3E5
        JMP CODE_048413                         ;$048292        |

CODE_048295:
        LDA.w $13D4
        LSR                                     ;$048298        |
        BNE CODE_04829E                         ;$048299        |
        JMP CODE_048356                         ;$04829B        |

CODE_04829E:
        REP #$20
        LDA.w $1DF2                             ;$0482A0        |
        SEC                                     ;$0482A3        |
        SBC $1C                                 ;$0482A4        |
        STA $01                                 ;$0482A6        |
        BPL CODE_0482AE                         ;$0482A8        |
        EOR.w #$FFFF                            ;$0482AA        |
        INC A                                   ;$0482AD        |
CODE_0482AE:
        LSR
        SEP #$20                                ;$0482AF        |
        STA $05                                 ;$0482B1        |
        REP #$20                                ;$0482B3        |
        LDA.w $1DF0                             ;$0482B5        |
        SEC                                     ;$0482B8        |
        SBC $1A                                 ;$0482B9        |
        STA $00                                 ;$0482BB        |
        BPL CODE_0482C3                         ;$0482BD        |
        EOR.w #$FFFF                            ;$0482BF        |
        INC A                                   ;$0482C2        |
CODE_0482C3:
        LSR
        SEP #$20                                ;$0482C4        |
        STA $04                                 ;$0482C6        |
        LDX.b #$01                              ;$0482C8        |
        CMP $05                                 ;$0482CA        |
        BCS CODE_0482D1                         ;$0482CC        |
        DEX                                     ;$0482CE        |
        LDA $05                                 ;$0482CF        |
CODE_0482D1:
        CMP.b #$02
        BCS CODE_0482ED                         ;$0482D3        |
        REP #$20                                ;$0482D5        |
        LDA.w $1DF0                             ;$0482D7        |
        STA $1A                                 ;$0482DA        |
        STA $1E                                 ;$0482DC        |
        LDA.w $1DF2                             ;$0482DE        |
        STA $1C                                 ;$0482E1        |
        STA $20                                 ;$0482E3        |
        SEP #$20                                ;$0482E5        |
        STZ.w $13D4                             ;$0482E7        |
        JMP CODE_0483BD                         ;$0482EA        |

CODE_0482ED:
        STZ.w $4204
        LDY $04,X                               ;$0482F0        |
        STY.w $4205                             ;$0482F2        |
        STA.w $4206                             ;$0482F5        |
        NOP                                     ;$0482F8        |
        NOP                                     ;$0482F9        |
        NOP                                     ;$0482FA        |
        NOP                                     ;$0482FB        |
        NOP                                     ;$0482FC        |
        NOP                                     ;$0482FD        |
        REP #$20                                ;$0482FE        |
        LDA.w $4214                             ;$048300        |
        LSR                                     ;$048303        |
        LSR                                     ;$048304        |
        SEP #$20                                ;$048305        |
        LDY $01,X                               ;$048307        |
        BPL CODE_04830E                         ;$048309        |
        EOR.b #$FF                              ;$04830B        |
        INC A                                   ;$04830D        |
CODE_04830E:
        STA $01,X
        TXA                                     ;$048310        |
        EOR.b #$01                              ;$048311        |
        TAX                                     ;$048313        |
        LDA.b #$40                              ;$048314        |
        LDY $01,X                               ;$048316        |
        BPL CODE_04831C                         ;$048318        |
        LDA.b #$C0                              ;$04831A        |
CODE_04831C:
        STA $01,X
        LDY.b #$01                              ;$04831E        |
CODE_048320:
        TYA
        ASL                                     ;$048321        |
        TAX                                     ;$048322        |
        LDA.w $0001,Y                           ;$048323        |
        ASL                                     ;$048326        |
        ASL                                     ;$048327        |
        ASL                                     ;$048328        |
        ASL                                     ;$048329        |
        CLC                                     ;$04832A        |
        ADC.w $1B7C,Y                           ;$04832B        |
        STA.w $1B7C,Y                           ;$04832E        |
        LDA.w $0001,Y                           ;$048331        |
        PHY                                     ;$048334        |
        PHP                                     ;$048335        |
        LSR                                     ;$048336        |
        LSR                                     ;$048337        |
        LSR                                     ;$048338        |
        LSR                                     ;$048339        |
        LDY.b #$00                              ;$04833A        |
        PLP                                     ;$04833C        |
        BPL CODE_048342                         ;$04833D        |
        ORA.b #$F0                              ;$04833F        |
        DEY                                     ;$048341        |
CODE_048342:
        ADC $1A,X
        STA $1A,X                               ;$048344        |
        STA $1E,X                               ;$048346        |
        TYA                                     ;$048348        |
        ADC $1B,X                               ;$048349        |
        STA $1B,X                               ;$04834B        |
        STA $1F,X                               ;$04834D        |
        PLY                                     ;$04834F        |
        DEY                                     ;$048350        |
        BPL CODE_048320                         ;$048351        |
        JMP CODE_04840D                         ;$048353        |

CODE_048356:
        LDA.w $13D9
        CMP.b #$03                              ;$048359        |
        BEQ CODE_048366                         ;$04835B        |
        CMP.b #$04                              ;$04835D        |
        BNE CODE_04839A                         ;$04835F        |
        LDA.w $0DD8                             ;$048361        |
        BNE CODE_04839A                         ;$048364        |
CODE_048366:
        LDA.w $0DA8
        ORA.w $0DA9                             ;$048369        |
        AND.b #$30                              ;$04836C        |
        BEQ CODE_048375                         ;$04836E        |
        LDA.b #$01                              ;$048370        |
        STA.w $1B87                             ;$048372        |
CODE_048375:
        LDX.w $0DB3
        LDA.w $1F11,X                           ;$048378        |
        BNE CODE_04839A                         ;$04837B        |
        LDA $16                                 ;$04837D        |
        AND.b #$10                              ;$04837F        |
        BEQ CODE_04839A                         ;$048381        |
        INC.w $13D4                             ;$048383        |
        LDA.w $13D4                             ;$048386        |
        LSR                                     ;$048389        |
        BNE CODE_04839A                         ;$04838A        |
        REP #$20                                ;$04838C        |
        LDA $1A                                 ;$04838E        |
        STA.w $1DF0                             ;$048390        |
        LDA $1C                                 ;$048393        |
        STA.w $1DF2                             ;$048395        |
        SEP #$20                                ;$048398        |
CODE_04839A:
        LDA.w $13D4
        BEQ CODE_0483C3                         ;$04839D        |
        LDX.b #$00                              ;$04839F        |
        LDA $15                                 ;$0483A1        |
        AND.b #$03                              ;$0483A3        |
        ASL                                     ;$0483A5        |
        JSR CODE_048415                         ;$0483A6        |
        LDX.b #$02                              ;$0483A9        |
        LDA $15                                 ;$0483AB        |
        AND.b #$0C                              ;$0483AD        |
        ORA.b #$10                              ;$0483AF        |
        LSR                                     ;$0483B1        |
        JSR CODE_048415                         ;$0483B2        |
        LDY.b #$15                              ;$0483B5        |
        LDA $13                                 ;$0483B7        |
        AND.b #$18                              ;$0483B9        |
        BNE CODE_0483BF                         ;$0483BB        |
CODE_0483BD:
        LDY.b #$18
CODE_0483BF:
        STY $12
        BRA CODE_04840D                         ;$0483C1        |

CODE_0483C3:
        LDX.w $1BA0
        BEQ CODE_04840A                         ;$0483C6        |
        CPX.b #$FE                              ;$0483C8        |
        BNE CODE_0483D6                         ;$0483CA        |
        LDA.b #$21                              ;$0483CC        |
        STA.w $1DF9                             ;$0483CE        |
        LDA.b #$08                              ;$0483D1        |
        STA.w $1DFB                             ;$0483D3        |
CODE_0483D6:
        TXA
        LSR                                     ;$0483D7        |
        LSR                                     ;$0483D8        |
        LSR                                     ;$0483D9        |
        LSR                                     ;$0483DA        |
        TAY                                     ;$0483DB        |
        LDA $13                                 ;$0483DC        |
        AND.w DATA_048231,Y                     ;$0483DE        |
        BNE CODE_0483F3                         ;$0483E1        |
        LDA $1A                                 ;$0483E3        |
        EOR.b #$01                              ;$0483E5        |
        STA $1A                                 ;$0483E7        |
        STA $1E                                 ;$0483E9        |
        LDA $1C                                 ;$0483EB        |
        EOR.b #$01                              ;$0483ED        |
        STA $1C                                 ;$0483EF        |
        STA $20                                 ;$0483F1        |
CODE_0483F3:
        CPX.b #$80
        BCS CODE_0483FE                         ;$0483F5        |
        LDA.w $13D9                             ;$0483F7        |
        CMP.b #$02                              ;$0483FA        |
        BNE CODE_04840A                         ;$0483FC        |
CODE_0483FE:
        DEC.w $1BA0
        BNE CODE_04840D                         ;$048401        |
        LDA.b #$22                              ;$048403        |
        STA.w $1DF9                             ;$048405        |
        BRA CODE_04840D                         ;$048408        |

CODE_04840A:
        JSR CODE_048576
CODE_04840D:
        JSR CODE_04F708
CODE_048410:
        JSR CODE_04862E
CODE_048413:
        PLB
        RTL                                     ;$048414        |

CODE_048415:
        TAY
        REP #$20                                ;$048416        |
        LDA $1A,X                               ;$048418        |
        CLC                                     ;$04841A        |
        ADC.w DATA_048211,Y                     ;$04841B        |
        PHA                                     ;$04841E        |
        SEC                                     ;$04841F        |
        SBC.w DATA_048221,Y                     ;$048420        |
        EOR.w DATA_048211,Y                     ;$048423        |
        ASL                                     ;$048426        |
        PLA                                     ;$048427        |
        BCC CODE_04842E                         ;$048428        |
        STA $1A,X                               ;$04842A        |
        STA $1E,X                               ;$04842C        |
CODE_04842E:
        SEP #$20
        RTS                                     ;$048430        |

DATA_048431:
        db $11,$00,$0A,$00,$09,$00,$0B,$00
        db $12,$00,$0A,$00,$07,$00,$0A,$02
        db $03,$02,$10,$04,$12,$04,$1C,$04
        db $14,$04,$12,$06,$00,$02,$12,$06
        db $10,$00,$17,$06,$14,$00,$1C,$06
        db $14,$00,$1C,$06,$17,$06,$11,$05
        db $11,$05,$14,$04,$06,$01

DATA_048467:
        db $07,$00,$03,$00,$10,$00,$0E,$00
        db $17,$00,$18,$00,$12,$00,$14,$00
        db $0B,$00,$03,$00,$01,$00,$09,$00
        db $09,$00,$1D,$00,$0E,$00,$18,$00
        db $0F,$00,$16,$00,$10,$00,$18,$00
        db $02,$00,$1D,$00,$18,$00,$13,$00
        db $11,$00,$03,$00,$07,$00

DATA_04849D:
        db $A8,$04,$38,$04,$08,$09,$28,$09
        db $C8,$09,$48,$09,$28,$0D,$18,$01
        db $A8,$00,$98,$00,$B8,$00,$28,$01
        db $A8,$00,$78,$00,$28,$0D,$08,$04
        db $78,$0D,$08,$01,$C8,$0D,$48,$01
        db $C8,$0D,$48,$09,$18,$0B,$78,$0D
        db $68,$02,$C8,$0D,$28,$0D

DATA_0484D3:
        db $48,$01,$B8,$00,$38,$00,$18,$00
        db $98,$00,$98,$00,$D8,$01,$78,$00
        db $38,$00,$08,$01,$E8,$00,$78,$01
        db $88,$01,$28,$01,$88,$01,$E8,$00
        db $68,$01,$F8,$00,$88,$01,$08,$01
        db $D8,$01,$38,$00,$38,$01,$88,$01
        db $78,$00,$D8,$01,$D8,$01

CODE_048509:
        LDY.w $0DB3
        LDA.w $1F11,Y                           ;$04850C        |
        STA $01                                 ;$04850F        |
        STZ $00                                 ;$048511        |
        REP #$20                                ;$048513        |
        LDX.w $0DD6                             ;$048515        |
        LDY.b #$34                              ;$048518        |
CODE_04851A:
        LDA.w DATA_048431,Y
        EOR $00                                 ;$04851D        |
        CMP.w #$0200                            ;$04851F        |
        BCS CODE_048531                         ;$048522        |
        CMP.w $1F1F,X                           ;$048524        |
        BNE CODE_048531                         ;$048527        |
        LDA.w $1F21,X                           ;$048529        |
        CMP.w DATA_048467,Y                     ;$04852C        |
        BEQ CODE_048535                         ;$04852F        |
CODE_048531:
        DEY
        DEY                                     ;$048532        |
        BPL CODE_04851A                         ;$048533        |
CODE_048535:
        STY.w $1DF6
        SEP #$20                                ;$048538        |
        RTS                                     ;$04853A        |

CODE_04853B:
        PHB
        PHK                                     ;$04853C        |
        PLB                                     ;$04853D        |
        REP #$20                                ;$04853E        |
        LDX.w $0DD6                             ;$048540        |
        LDY.w $1DF6                             ;$048543        |
        LDA.w DATA_04849D,Y                     ;$048546        |
        PHA                                     ;$048549        |
        AND.w #$01FF                            ;$04854A        |
        STA.w $1F17,X                           ;$04854D        |
        LSR                                     ;$048550        |
        LSR                                     ;$048551        |
        LSR                                     ;$048552        |
        LSR                                     ;$048553        |
        STA.w $1F1F,X                           ;$048554        |
        LDA.w DATA_0484D3,Y                     ;$048557        |
        STA.w $1F19,X                           ;$04855A        |
        LSR                                     ;$04855D        |
        LSR                                     ;$04855E        |
        LSR                                     ;$04855F        |
        LSR                                     ;$048560        |
        STA.w $1F21,X                           ;$048561        |
        PLA                                     ;$048564        |
        LSR                                     ;$048565        |
        XBA                                     ;$048566        |
        AND.w #$000F                            ;$048567        |
        STA.w $13C3                             ;$04856A        |
        REP #$10                                ;$04856D        |
        JSR CODE_049A93                         ;$04856F        |
        SEP #$30                                ;$048572        |
        PLB                                     ;$048574        |
        RTL                                     ;$048575        |

CODE_048576:
        LDA.w $13D9
        JSL execute_pointer_long                ;$048579        |

PtrsLong04857D:
        dl CODE_048EF1
        dl CODE_04E570
        dl CODE_048F87
        dl CODE_049120
        dl CODE_04945D
        dl CODE_049D9A
        dl CODE_049E22
        dl CODE_049DD1
        dl CODE_049E22
        dl CODE_049E4C
        dl CODE_04DAEF
        dl CODE_049E52
        dl CODE_0498C6

DrawOWBoarder:
        JSR CODE_04862E
CODE_0485A7:
        REP #$20
        LDA.w #$001E                            ;$0485A9        |
        CLC                                     ;$0485AC        |
        ADC $1A                                 ;$0485AD        |
        STA $94                                 ;$0485AF        |
        LDA.w #$0006                            ;$0485B1        |
        CLC                                     ;$0485B4        |
        ADC $1C                                 ;$0485B5        |
        STA $96                                 ;$0485B7        |
        SEP #$20                                ;$0485B9        |
        LDA.b #$08                              ;$0485BB        |
        STA.w $7B                               ;$0485BD        |
        PHB                                     ;$0485C0        |
        LDA.b #$00                              ;$0485C1        |
        PHA                                     ;$0485C3        |
        PLB                                     ;$0485C4        |
        JSL set_player_pose                     ;$0485C5        |
        PLB                                     ;$0485C9        |
        LDA.b #$03                              ;$0485CA        |
        STA.w $13F9                             ;$0485CC        |
        JSL CODE_00E2BD                         ;$0485CF        |
        LDA.b #$06                              ;$0485D3        |
        STA.w $0D84                             ;$0485D5        |
        LDA.w $1496                             ;$0485D8        |
        BEQ CODE_0485E0                         ;$0485DB        |
        DEC.w $1496                             ;$0485DD        |
CODE_0485E0:
        LDA.w $14A2
        BEQ CODE_0485E8                         ;$0485E3        |
        DEC.w $14A2                             ;$0485E5        |
CODE_0485E8:
        LDA.b #$18
        STA $00                                 ;$0485EA        |
        LDA.b #$07                              ;$0485EC        |
        STA $01                                 ;$0485EE        |
        LDY.b #$00                              ;$0485F0        |
        TYX                                     ;$0485F2        |
CODE_0485F3:
        LDA $00
        STA.w $0200,X                           ;$0485F5        |
        CLC                                     ;$0485F8        |
        ADC.b #$08                              ;$0485F9        |
        STA $00                                 ;$0485FB        |
        LDA $01                                 ;$0485FD        |
        STA.w $0201,X                           ;$0485FF        |
        LDA.b #$7E                              ;$048602        |
        STA.w $0202,X                           ;$048604        |
        LDA.b #$36                              ;$048607        |
        STA.w $0203,X                           ;$048609        |
        PHX                                     ;$04860C        |
        TYX                                     ;$04860D        |
        LDA.b #$00                              ;$04860E        |
        STA.w $0420,X                           ;$048610        |
        PLX                                     ;$048613        |
        INY                                     ;$048614        |
        TYA                                     ;$048615        |
        AND.b #$03                              ;$048616        |
        BNE CODE_048625                         ;$048618        |
        LDA.b #$18                              ;$04861A        |
        STA $00                                 ;$04861C        |
        LDA $01                                 ;$04861E        |
        CLC                                     ;$048620        |
        ADC.b #$08                              ;$048621        |
        STA $01                                 ;$048623        |
CODE_048625:
        INX
        INX                                     ;$048626        |
        INX                                     ;$048627        |
        INX                                     ;$048628        |
        CPY.b #$10                              ;$048629        |
        BNE CODE_0485F3                         ;$04862B        |
        RTS                                     ;$04862D        |

CODE_04862E:
        REP #$30
        LDX.w $0DD6                             ;$048630        |
        LDA.w $1F17,X                           ;$048633        |
        SEC                                     ;$048636        |
        SBC $1A                                 ;$048637        |
        CMP.w #$0100                            ;$048639        |
        BCS CODE_04864D                         ;$04863C        |
        STA $00                                 ;$04863E        |
        STA $08                                 ;$048640        |
        LDA.w $1F19,X                           ;$048642        |
        SEC                                     ;$048645        |
        SBC $1C                                 ;$048646        |
        CMP.w #$0100                            ;$048648        |
        BCC CODE_048650                         ;$04864B        |
CODE_04864D:
        LDA.w #$00F0
CODE_048650:
        STA $02
        STA $0A                                 ;$048652        |
        TXA                                     ;$048654        |
        EOR.w #$0004                            ;$048655        |
        TAX                                     ;$048658        |
        LDA.w $1F17,X                           ;$048659        |
        SEC                                     ;$04865C        |
        SBC $1A                                 ;$04865D        |
        CMP.w #$0100                            ;$04865F        |
        BCS CODE_048673                         ;$048662        |
        STA $04                                 ;$048664        |
        STA $0C                                 ;$048666        |
        LDA.w $1F19,X                           ;$048668        |
        SEC                                     ;$04866B        |
        SBC $1C                                 ;$04866C        |
        CMP.w #$0100                            ;$04866E        |
        BCC CODE_048676                         ;$048671        |
CODE_048673:
        LDA.w #$00F0
CODE_048676:
        STA $06
        STA $0E                                 ;$048678        |
        SEP #$30                                ;$04867A        |
        LDA $00                                 ;$04867C        |
        SEC                                     ;$04867E        |
        SBC.b #$08                              ;$04867F        |
        STA $00                                 ;$048681        |
        LDA $02                                 ;$048683        |
        SEC                                     ;$048685        |
        SBC.b #$09                              ;$048686        |
        STA $01                                 ;$048688        |
        LDA $04                                 ;$04868A        |
        SEC                                     ;$04868C        |
        SBC.b #$08                              ;$04868D        |
        STA $02                                 ;$04868F        |
        LDA $06                                 ;$048691        |
        SEC                                     ;$048693        |
        SBC.b #$09                              ;$048694        |
        STA $03                                 ;$048696        |
        LDA.b #$03                              ;$048698        |
        STA $8C                                 ;$04869A        |
        LDA $00                                 ;$04869C        |
        STA $06                                 ;$04869E        |
        STA $8A                                 ;$0486A0        |
        LDA $01                                 ;$0486A2        |
        STA $07                                 ;$0486A4        |
        STA $8B                                 ;$0486A6        |
        LDA.w $0DD6                             ;$0486A8        |
        LSR                                     ;$0486AB        |
        TAY                                     ;$0486AC        |
        LDA.w $1F13,Y                           ;$0486AD        |
        CMP.b #$12                              ;$0486B0        |
        BEQ CODE_0486C5                         ;$0486B2        |
        CMP.b #$07                              ;$0486B4        |
        BCC CODE_0486BC                         ;$0486B6        |
        CMP.b #$0F                              ;$0486B8        |
        BCC CODE_0486C5                         ;$0486BA        |
CODE_0486BC:
        LDA $8B
        SEC                                     ;$0486BE        |
        SBC.b #$05                              ;$0486BF        |
        STA $8B                                 ;$0486C1        |
        STA $07                                 ;$0486C3        |
CODE_0486C5:
        REP #$30
        LDA.w $0DD6                             ;$0486C7        |
        XBA                                     ;$0486CA        |
        LSR                                     ;$0486CB        |
        STA $04                                 ;$0486CC        |
        LDX.w #$0000                            ;$0486CE        |
        JSR CODE_048789                         ;$0486D1        |
        LDA.w $0DD6                             ;$0486D4        |
        LSR                                     ;$0486D7        |
        TAY                                     ;$0486D8        |
        LDX.w #$0000                            ;$0486D9        |
        JSR CODE_04894F                         ;$0486DC        |
        SEP #$30                                ;$0486DF        |
        STZ.w $0447                             ;$0486E1        |
        STZ.w $0448                             ;$0486E4        |
        STZ.w $0449                             ;$0486E7        |
        STZ.w $044A                             ;$0486EA        |
        STZ.w $044B                             ;$0486ED        |
        STZ.w $044C                             ;$0486F0        |
        STZ.w $044D                             ;$0486F3        |
        STZ.w $044E                             ;$0486F6        |
        LDA.b #$03                              ;$0486F9        |
        STA $8C                                 ;$0486FB        |
        LDA.w $1F11                             ;$0486FD        |
        LDY.w $13D9                             ;$048700        |
        CPY.b #$0A                              ;$048703        |
        BNE CODE_048709                         ;$048705        |
        EOR.b #$01                              ;$048707        |
CODE_048709:
        CMP.w $1F12
        BNE CODE_048786                         ;$04870C        |
        LDA $02                                 ;$04870E        |
        STA $06                                 ;$048710        |
        STA $8A                                 ;$048712        |
        LDA $03                                 ;$048714        |
        STA $07                                 ;$048716        |
        STA $8B                                 ;$048718        |
        LDA.w $0DD6                             ;$04871A        |
        LSR                                     ;$04871D        |
        EOR.b #$02                              ;$04871E        |
        TAY                                     ;$048720        |
        LDA.w $1F13,Y                           ;$048721        |
        CMP.b #$12                              ;$048724        |
        BEQ CODE_048739                         ;$048726        |
        CMP.b #$07                              ;$048728        |
        BCC CODE_048730                         ;$04872A        |
        CMP.b #$0F                              ;$04872C        |
        BCC CODE_048739                         ;$04872E        |
CODE_048730:
        LDA $8B
        SEC                                     ;$048732        |
        SBC.b #$05                              ;$048733        |
        STA $8B                                 ;$048735        |
        STA $07                                 ;$048737        |
CODE_048739:
        REP #$30
        LDA.w $0DB2                             ;$04873B        |
        AND.w #$00FF                            ;$04873E        |
        BEQ CODE_048786                         ;$048741        |
        LDA $0C                                 ;$048743        |
        CMP.w #$00F0                            ;$048745        |
        BCS CODE_048786                         ;$048748        |
        LDA $0E                                 ;$04874A        |
        CMP.w #$00F0                            ;$04874C        |
        BCS CODE_048786                         ;$04874F        |
        LDA $04                                 ;$048751        |
        EOR.w #$0200                            ;$048753        |
        STA $04                                 ;$048756        |
        LDX.w #$0020                            ;$048758        |
        JSR CODE_048789                         ;$04875B        |
        LDA.w $0DD6                             ;$04875E        |
        LSR                                     ;$048761        |
        EOR.w #$0002                            ;$048762        |
        TAY                                     ;$048765        |
        LDX.w #$0020                            ;$048766        |
        JSR CODE_04894F                         ;$048769        |
        SEP #$30                                ;$04876C        |
        STZ.w $044F                             ;$04876E        |
        STZ.w $0450                             ;$048771        |
        STZ.w $0451                             ;$048774        |
        STZ.w $0452                             ;$048777        |
        STZ.w $0453                             ;$04877A        |
        STZ.w $0454                             ;$04877D        |
        STZ.w $0455                             ;$048780        |
        STZ.w $0456                             ;$048783        |
CODE_048786:
        SEP #$30
        RTS                                     ;$048788        |

CODE_048789:
        LDA $8A
        PHA                                     ;$04878B        |
        PHX                                     ;$04878C        |
        LDA $04                                 ;$04878D        |
        XBA                                     ;$04878F        |
        LSR                                     ;$048790        |
        TAX                                     ;$048791        |
        LDA.w $0DB3,X                           ;$048792        |
        PLX                                     ;$048795        |
        AND.w #$FF00                            ;$048796        |
        BPL CODE_0487C7                         ;$048799        |
        SEP #$20                                ;$04879B        |
        LDA $8A                                 ;$04879D        |
        STA.w $02B4,X                           ;$04879F        |
        CLC                                     ;$0487A2        |
        ADC.b #$08                              ;$0487A3        |
        STA.w $02B8,X                           ;$0487A5        |
        LDA $8B                                 ;$0487A8        |
        CLC                                     ;$0487AA        |
        ADC.b #$F9                              ;$0487AB        |
        STA.w $02B5,X                           ;$0487AD        |
        STA.w $02B9,X                           ;$0487B0        |
        LDA.b #$7C                              ;$0487B3        |
        STA.w $02B6,X                           ;$0487B5        |
        STA.w $02BA,X                           ;$0487B8        |
        LDA.b #$20                              ;$0487BB        |
        STA.w $02B7,X                           ;$0487BD        |
        LDA.b #$60                              ;$0487C0        |
        STA.w $02BB,X                           ;$0487C2        |
        REP #$20                                ;$0487C5        |
CODE_0487C7:
        PLA
        STA $8A                                 ;$0487C8        |
        RTS                                     ;$0487CA        |

DATA_0487CB:
        db $0E,$24,$0F,$24,$1E,$24,$1F,$24
        db $20,$24,$21,$24,$30,$24,$31,$24
        db $0E,$24,$0F,$24,$1E,$24,$1F,$24
        db $20,$24,$21,$24,$31,$64,$30,$64
        db $0A,$24,$0B,$24,$1A,$24,$1B,$24
        db $0C,$24,$0D,$24,$1C,$24,$1D,$24
        db $0A,$24,$0B,$24,$1A,$24,$1B,$24
        db $0C,$24,$0D,$24,$1D,$64,$1C,$64
        db $08,$24,$09,$24,$18,$24,$19,$24
        db $06,$24,$07,$24,$16,$24,$17,$24
        db $08,$24,$09,$24,$18,$24,$19,$24
        db $06,$24,$07,$24,$16,$24,$17,$24
        db $09,$64,$08,$64,$19,$64,$18,$64
        db $07,$64,$06,$64,$17,$64,$16,$64
        db $09,$64,$08,$64,$19,$64,$18,$64
        db $07,$64,$06,$64,$17,$64,$16,$64
        db $0E,$24,$0F,$24,$38,$24,$38,$64
        db $20,$24,$21,$24,$39,$24,$39,$64
        db $0E,$24,$0F,$24,$38,$24,$38,$64
        db $20,$24,$21,$24,$39,$24,$39,$64
        db $0A,$24,$0B,$24,$38,$24,$38,$64
        db $0C,$24,$0D,$24,$39,$24,$39,$64
        db $0A,$24,$0B,$24,$38,$24,$38,$64
        db $0C,$24,$0D,$24,$39,$24,$39,$64
        db $08,$24,$09,$24,$38,$24,$38,$64
        db $06,$24,$07,$24,$39,$24,$39,$64
        db $08,$24,$09,$24,$38,$24,$38,$64
        db $06,$24,$07,$24,$39,$24,$39,$64
        db $09,$64,$08,$64,$38,$24,$38,$64
        db $07,$64,$06,$64,$39,$24,$39,$64
        db $09,$64,$08,$64,$38,$24,$38,$64
        db $07,$64,$06,$64,$39,$24,$39,$64
        db $24,$24,$25,$24,$34,$24,$35,$24
        db $24,$24,$25,$24,$34,$24,$35,$24
        db $24,$24,$25,$24,$34,$24,$35,$24
        db $24,$24,$25,$24,$34,$24,$35,$24
        db $24,$24,$25,$24,$38,$24,$38,$64
        db $24,$24,$25,$24,$38,$24,$38,$64
        db $24,$24,$25,$24,$38,$24,$38,$64
        db $24,$24,$25,$24,$38,$24,$38,$64
        db $46,$24,$47,$24,$56,$24,$57,$24
        db $47,$64,$46,$64,$57,$64,$56,$64
        db $46,$24,$47,$24,$56,$24,$57,$24
        db $47,$64,$46,$64,$57,$64,$56,$64
        db $46,$24,$47,$24,$56,$24,$57,$24
        db $47,$64,$46,$64,$57,$64,$56,$64
        db $46,$24,$47,$24,$56,$24,$57,$24
        db $47,$64,$46,$64,$57,$64,$56,$64
DATA_04894B:
        db $20,$60,$00,$40

CODE_04894F:
        SEP #$30
        PHY                                     ;$048951        |
        TYA                                     ;$048952        |
        LSR                                     ;$048953        |
        TAY                                     ;$048954        |
        LDA.w $0DBA,Y                           ;$048955        |
        BEQ CODE_048962                         ;$048958        |
        STA $0E                                 ;$04895A        |
        STZ $0F                                 ;$04895C        |
        PLY                                     ;$04895E        |
        JMP CODE_048CE6                         ;$04895F        |

CODE_048962:
        PLY
        REP #$30                                ;$048963        |
        LDA.w $1F13,Y                           ;$048965        |
        ASL                                     ;$048968        |
        ASL                                     ;$048969        |
        ASL                                     ;$04896A        |
        ASL                                     ;$04896B        |
        STA $00                                 ;$04896C        |
        LDA $13                                 ;$04896E        |
        AND.w #$0018                            ;$048970        |
        CLC                                     ;$048973        |
        ADC $00                                 ;$048974        |
        TAY                                     ;$048976        |
        PHX                                     ;$048977        |
        LDA $04                                 ;$048978        |
        XBA                                     ;$04897A        |
        LSR                                     ;$04897B        |
        TAX                                     ;$04897C        |
        LDA.w $0DB3,X                           ;$04897D        |
        PLX                                     ;$048980        |
        AND.w #$FF00                            ;$048981        |
        BPL CODE_04898B                         ;$048984        |
        LDA $00                                 ;$048986        |
        TAY                                     ;$048988        |
        BRA CODE_0489A7                         ;$048989        |

CODE_04898B:
        CPX.w #$0000
        BNE CODE_0489A7                         ;$04898E        |
        LDA.w $13D9                             ;$048990        |
        CMP.w #$000B                            ;$048993        |
        BNE CODE_0489A7                         ;$048996        |
        LDA $13                                 ;$048998        |
        AND.w #$000C                            ;$04899A        |
        LSR                                     ;$04899D        |
        LSR                                     ;$04899E        |
        TAY                                     ;$04899F        |
        LDA.w DATA_04894B,Y                     ;$0489A0        |
        AND.w #$00FF                            ;$0489A3        |
        TAY                                     ;$0489A6        |
CODE_0489A7:
        REP #$20
        LDA $8A                                 ;$0489A9        |
        STA.w $029C,X                           ;$0489AB        |
        LDA.w DATA_0487CB,Y                     ;$0489AE        |
        CLC                                     ;$0489B1        |
        ADC $04                                 ;$0489B2        |
        STA.w $029E,X                           ;$0489B4        |
        SEP #$20                                ;$0489B7        |
        INX                                     ;$0489B9        |
        INX                                     ;$0489BA        |
        INX                                     ;$0489BB        |
        INX                                     ;$0489BC        |
        INY                                     ;$0489BD        |
        INY                                     ;$0489BE        |
        LDA $8A                                 ;$0489BF        |
        CLC                                     ;$0489C1        |
        ADC.b #$08                              ;$0489C2        |
        STA $8A                                 ;$0489C4        |
        DEC $8C                                 ;$0489C6        |
        LDA $8C                                 ;$0489C8        |
        AND.b #$01                              ;$0489CA        |
        BEQ CODE_0489D9                         ;$0489CC        |
        LDA $06                                 ;$0489CE        |
        STA $8A                                 ;$0489D0        |
        LDA $8B                                 ;$0489D2        |
        CLC                                     ;$0489D4        |
        ADC.b #$08                              ;$0489D5        |
        STA $8B                                 ;$0489D7        |
CODE_0489D9:
        LDA $8C
        BPL CODE_0489A7                         ;$0489DB        |
        RTS                                     ;$0489DD        |

DATA_0489DE:
        db $66,$24,$67,$24,$76,$24,$77,$24
        db $2F,$62,$2E,$62,$3F,$62,$3E,$62
        db $66,$24,$67,$24,$76,$24,$77,$24
        db $2E,$22,$2F,$22,$3E,$22,$3F,$22
        db $2F,$62,$2E,$62,$3F,$62,$3E,$62
        db $0A,$24,$0B,$24,$1A,$24,$1B,$24
        db $2E,$22,$2F,$22,$3E,$22,$3F,$22
        db $0A,$24,$0B,$24,$1A,$24,$1B,$24
        db $64,$24,$65,$24,$74,$24,$75,$24
        db $40,$22,$41,$22,$50,$22,$51,$22
        db $64,$24,$65,$24,$74,$24,$75,$24
        db $42,$22,$43,$24,$52,$24,$53,$24
        db $65,$64,$64,$64,$75,$64,$74,$64
        db $41,$62,$40,$62,$51,$62,$50,$62
        db $65,$64,$64,$64,$75,$64,$74,$64
        db $43,$62,$42,$62,$53,$62,$52,$62
        db $38,$24,$38,$64,$66,$24,$67,$24
        db $76,$24,$77,$24,$FF,$FF,$FF,$FF
        db $39,$24,$39,$64,$66,$24,$67,$24
        db $76,$24,$77,$24,$FF,$FF,$FF,$FF
        db $38,$24,$38,$64,$2F,$62,$2E,$62
        db $0A,$24,$0B,$24,$1A,$24,$1B,$24
        db $39,$24,$39,$24,$2E,$22,$2F,$22
        db $0A,$24,$0B,$24,$1A,$24,$1B,$24
        db $38,$24,$38,$64,$64,$24,$65,$24
        db $74,$24,$75,$24,$40,$22,$41,$22
        db $39,$24,$39,$64,$64,$24,$65,$24
        db $74,$24,$75,$24,$42,$22,$42,$22
        db $38,$24,$38,$64,$65,$64,$64,$64
        db $75,$64,$74,$64,$41,$62,$40,$62
        db $39,$24,$39,$64,$65,$64,$64,$64
        db $75,$64,$74,$64,$43,$62,$42,$62
        db $2F,$62,$2E,$62,$3F,$62,$3E,$62
        db $24,$24,$25,$24,$34,$24,$35,$24
        db $2E,$22,$2F,$22,$3E,$22,$3F,$22
        db $24,$24,$25,$24,$34,$24,$35,$24
        db $38,$24,$38,$64,$2F,$62,$2E,$62
        db $24,$24,$25,$24,$34,$24,$35,$24
        db $39,$24,$39,$64,$2E,$22,$2F,$22
        db $24,$24,$25,$24,$34,$24,$35,$24
        db $66,$24,$67,$24,$76,$24,$77,$24
        db $2F,$62,$2E,$62,$3F,$62,$3E,$62
        db $66,$24,$67,$24,$76,$24,$77,$24
        db $2E,$22,$2F,$22,$3E,$22,$3F,$22
        db $66,$24,$67,$24,$76,$24,$77,$24
        db $2F,$62,$2E,$62,$3F,$62,$3E,$62
        db $66,$24,$67,$24,$76,$24,$77,$24
        db $2E,$22,$2F,$22,$3E,$22,$3F,$22
DATA_048B5E:
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $07,$0F,$07,$0F,$00,$08,$00,$08
        db $07,$0F,$07,$0F,$00,$08,$00,$08
        db $F9,$01,$F9,$01,$00,$08,$00,$08
        db $F9,$01,$F9,$01,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$07,$0F,$07,$0F,$00,$08
        db $00,$08,$07,$0F,$07,$0F,$00,$08
        db $00,$08,$F9,$01,$F9,$01,$00,$08
        db $00,$08,$F9,$01,$F9,$01,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
        db $00,$08,$00,$08,$00,$08,$00,$08
DATA_048C1E:
        db $FB,$FB,$03,$03,$00,$00,$08,$08
        db $FA,$FA,$02,$02,$00,$00,$08,$08
        db $00,$00,$08,$08,$F8,$F8,$00,$00
        db $00,$00,$08,$08,$F9,$F9,$01,$01
        db $FC,$FC,$04,$04,$00,$00,$08,$08
        db $FB,$FB,$03,$03,$00,$00,$08,$08
        db $FC,$FC,$04,$04,$00,$00,$08,$08
        db $FB,$FB,$03,$03,$00,$00,$08,$08
        db $08,$08,$FB,$FB,$03,$03,$00,$00
        db $08,$08,$FA,$FA,$02,$02,$00,$00
        db $08,$08,$00,$00,$F8,$F8,$00,$00
        db $08,$08,$00,$00,$F9,$F9,$01,$01
        db $08,$08,$FC,$FC,$04,$04,$00,$00
        db $08,$08,$FB,$FB,$03,$03,$00,$00
        db $08,$08,$FC,$FC,$04,$04,$00,$00
        db $08,$08,$FB,$FB,$03,$03,$00,$00
        db $00,$00,$08,$08,$F8,$F8,$00,$00
        db $00,$00,$08,$08,$F8,$F8,$00,$00
        db $08,$08,$00,$00,$F8,$F8,$00,$00
        db $08,$08,$00,$00,$F8,$F8,$00,$00
        db $FB,$FB,$03,$03,$00,$00,$08,$08
        db $FA,$FA,$02,$02,$00,$00,$08,$08
        db $FB,$FB,$03,$03,$00,$00,$08,$08
        db $FA,$FA,$02,$02,$00,$00,$08,$08
DATA_048CDE:
        db $00,$00,$00,$02,$00,$04,$00,$06

CODE_048CE6:
        LDA.b #$07
        STA $8C                                 ;$048CE8        |
        REP #$30                                ;$048CEA        |
        LDA.w $1F13,Y                           ;$048CEC        |
        ASL                                     ;$048CEF        |
        ASL                                     ;$048CF0        |
        ASL                                     ;$048CF1        |
        ASL                                     ;$048CF2        |
        STA $00                                 ;$048CF3        |
        LDA $13                                 ;$048CF5        |
        AND.w #$0008                            ;$048CF7        |
        ASL                                     ;$048CFA        |
        CLC                                     ;$048CFB        |
        ADC $00                                 ;$048CFC        |
        TAY                                     ;$048CFE        |
        CPX.w #$0000                            ;$048CFF        |
        BNE CODE_048D1B                         ;$048D02        |
        LDA.w $13D9                             ;$048D04        |
        CMP.w #$000B                            ;$048D07        |
        BNE CODE_048D1B                         ;$048D0A        |
        LDA $13                                 ;$048D0C        |
        AND.w #$000C                            ;$048D0E        |
        LSR                                     ;$048D11        |
        LSR                                     ;$048D12        |
        TAY                                     ;$048D13        |
        LDA.w DATA_04894B,Y                     ;$048D14        |
        AND.w #$00FF                            ;$048D17        |
        TAY                                     ;$048D1A        |
CODE_048D1B:
        REP #$20
        PHY                                     ;$048D1D        |
        TYA                                     ;$048D1E        |
        LSR                                     ;$048D1F        |
        TAY                                     ;$048D20        |
        SEP #$20                                ;$048D21        |
        LDA.w DATA_048B5E,Y                     ;$048D23        |
        CLC                                     ;$048D26        |
        ADC $8A                                 ;$048D27        |
        STA.w $029C,X                           ;$048D29        |
        LDA.w DATA_048C1E,Y                     ;$048D2C        |
        CLC                                     ;$048D2F        |
        ADC $8B                                 ;$048D30        |
        STA.w $029D,X                           ;$048D32        |
        PLY                                     ;$048D35        |
        REP #$20                                ;$048D36        |
        LDA.w DATA_0489DE,Y                     ;$048D38        |
        CMP.w #$FFFF                            ;$048D3B        |
        BEQ CODE_048D67                         ;$048D3E        |
        PHA                                     ;$048D40        |
        AND.w #$0F00                            ;$048D41        |
        CMP.w #$0200                            ;$048D44        |
        BNE CODE_048D5E                         ;$048D47        |
        STY $08                                 ;$048D49        |
        LDA $0E                                 ;$048D4B        |
        SEC                                     ;$048D4D        |
        SBC.w #$0004                            ;$048D4E        |
        TAY                                     ;$048D51        |
        PLA                                     ;$048D52        |
        AND.w #$F0FF                            ;$048D53        |
        ORA.w DATA_048CDE,Y                     ;$048D56        |
        PHA                                     ;$048D59        |
        LDY $08                                 ;$048D5A        |
        BRA CODE_048D63                         ;$048D5C        |

CODE_048D5E:
        PLA
        CLC                                     ;$048D5F        |
        ADC $04                                 ;$048D60        |
        PHA                                     ;$048D62        |
CODE_048D63:
        PLA
        STA.w $029E,X                           ;$048D64        |
CODE_048D67:
        SEP #$20
        INX                                     ;$048D69        |
        INX                                     ;$048D6A        |
        INX                                     ;$048D6B        |
        INX                                     ;$048D6C        |
        INY                                     ;$048D6D        |
        INY                                     ;$048D6E        |
        DEC $8C                                 ;$048D6F        |
        BPL CODE_048D1B                         ;$048D71        |
        RTS                                     ;$048D73        |

DATA_048D74:
        db $0B,$00,$13,$00,$1A,$00,$1B,$00
        db $1F,$00,$20,$00,$31,$00,$32,$00
        db $34,$00,$35,$00,$40,$00

DATA_048D8A:
        db $02,$03,$04,$06,$07,$09,$05

CODE_048D91:
        PHB
        PHK                                     ;$048D92        |
        PLB                                     ;$048D93        |
        STZ.w $1B9E                             ;$048D94        |
        LDA.b #$0F                              ;$048D97        |
        STA.w $144E                             ;$048D99        |
        LDX.b #$02                              ;$048D9C        |
        LDA.w $1F13                             ;$048D9E        |
        CMP.b #$12                              ;$048DA1        |
        BEQ CODE_048DA9                         ;$048DA3        |
        AND.b #$08                              ;$048DA5        |
        BEQ CODE_048DAB                         ;$048DA7        |
CODE_048DA9:
        LDX.b #$0A
CODE_048DAB:
        STX.w $1F13
        LDX.b #$02                              ;$048DAE        |
        LDA.w $1F15                             ;$048DB0        |
        CMP.b #$12                              ;$048DB3        |
        BEQ CODE_048DBB                         ;$048DB5        |
        AND.b #$08                              ;$048DB7        |
        BEQ CODE_048DBD                         ;$048DB9        |
CODE_048DBB:
        LDX.b #$0A
CODE_048DBD:
        STX.w $1F15
        SEP #$10                                ;$048DC0        |
        JSR CODE_048E55                         ;$048DC2        |
        REP #$30                                ;$048DC5        |
        LDA.w $0DD4                             ;$048DC7        |
        AND.w #$FF00                            ;$048DCA        |
        BEQ CODE_048DDF                         ;$048DCD        |
        BMI CODE_048DDF                         ;$048DCF        |
        LDA.w $13BF                             ;$048DD1        |
        AND.w #$00FF                            ;$048DD4        |
        CMP.w #$0018                            ;$048DD7        |
        BNE CODE_048DDF                         ;$048DDA        |
        BRL CODE_048E34                         ;$048DDC        |
CODE_048DDF:
        LDA.w $13C6
        AND.w #$00FF                            ;$048DE2        |
        BEQ CODE_048E38                         ;$048DE5        |
        LDA.w $13C6                             ;$048DE7        |
        AND.w #$FF00                            ;$048DEA        |
        STA.w $13C6                             ;$048DED        |
        SEP #$10                                ;$048DF0        |
        LDX.w $0DD6                             ;$048DF2        |
        LDA.w $1F17,X                           ;$048DF5        |
        LSR                                     ;$048DF8        |
        LSR                                     ;$048DF9        |
        LSR                                     ;$048DFA        |
        LSR                                     ;$048DFB        |
        STA $00                                 ;$048DFC        |
        LDA.w $1F19,X                           ;$048DFE        |
        LSR                                     ;$048E01        |
        LSR                                     ;$048E02        |
        LSR                                     ;$048E03        |
        LSR                                     ;$048E04        |
        STA $02                                 ;$048E05        |
        TXA                                     ;$048E07        |
        LSR                                     ;$048E08        |
        LSR                                     ;$048E09        |
        TAX                                     ;$048E0A        |
        JSR OW_TilePos_Calc                     ;$048E0B        |
        REP #$10                                ;$048E0E        |
        LDX $04                                 ;$048E10        |
        LDA.l $7ED000,X                         ;$048E12        |
        AND.w #$00FF                            ;$048E16        |
        TAX                                     ;$048E19        |
        LDA.w $1EA2,X                           ;$048E1A        |
        AND.w #$0080                            ;$048E1D        |
        BNE CODE_048E38                         ;$048E20        |
        LDY.w #$0014                            ;$048E22        |
CODE_048E25:
        LDA.w $13BF
        AND.w #$00FF                            ;$048E28        |
        CMP.w DATA_048D74,Y                     ;$048E2B        |
        BEQ CODE_048E38                         ;$048E2E        |
        DEY                                     ;$048E30        |
        DEY                                     ;$048E31        |
        BPL CODE_048E25                         ;$048E32        |
CODE_048E34:
        SEP #$30
        BRA CODE_048E47                         ;$048E36        |

CODE_048E38:
        SEP #$30
        LDX.w $0DB3                             ;$048E3A        |
        LDA.w $1F11,X                           ;$048E3D        |
        TAX                                     ;$048E40        |
        LDA.w DATA_048D8A,X                     ;$048E41        |
        STA.w $1DFB                             ;$048E44        |
CODE_048E47:
        PLB
        RTL                                     ;$048E48        |

DATA_048E49:
        db $28,$01,$00,$00,$88,$01

DATA_048E4F:
        db $C8,$01,$00,$00,$D8,$01

CODE_048E55:
        REP #$30
        LDA.w $0DB3                             ;$048E57        |
        AND.w #$00FF                            ;$048E5A        |
        ASL                                     ;$048E5D        |
        ASL                                     ;$048E5E        |
        STA.w $0DD6                             ;$048E5F        |
        LDX.w $0DD6                             ;$048E62        |
        LDA.w $1F1F,X                           ;$048E65        |
        STA $00                                 ;$048E68        |
        LDA.w $1F21,X                           ;$048E6A        |
        STA $02                                 ;$048E6D        |
        TXA                                     ;$048E6F        |
        LSR                                     ;$048E70        |
        LSR                                     ;$048E71        |
        TAX                                     ;$048E72        |
        JSR OW_TilePos_Calc                     ;$048E73        |
        STZ $00                                 ;$048E76        |
        LDX $04                                 ;$048E78        |
        LDA.l $7ED000,X                         ;$048E7A        |
        AND.w #$00FF                            ;$048E7E        |
        ASL                                     ;$048E81        |
        TAX                                     ;$048E82        |
        LDA.w LevelNames,X                      ;$048E83        |
        STA $00                                 ;$048E86        |
        JSR CODE_049D07                         ;$048E88        |
        LDX $04                                 ;$048E8B        |
        BMI CODE_048E9E                         ;$048E8D        |
        CPX.w #$0800                            ;$048E8F        |
        BCS CODE_048E9E                         ;$048E92        |
        LDA.l $7EC800,X                         ;$048E94        |
        AND.w #$00FF                            ;$048E98        |
        STA.w $13C1                             ;$048E9B        |
CODE_048E9E:
        SEP #$30
        LDX.w $0EF7                             ;$048EA0        |
        BEQ CODE_048EE1                         ;$048EA3        |
        BPL ADDR_048ED9                         ;$048EA5        |
        TXA                                     ;$048EA7        |
        AND.b #$7F                              ;$048EA8        |
        TAX                                     ;$048EAA        |
        STZ.w $0DF5,X                           ;$048EAB        |
        LDA.w $0EF6                             ;$048EAE        |
        LDX.w $0DD5                             ;$048EB1        |
        BPL ADDR_048ECD                         ;$048EB4        |
        ASL                                     ;$048EB6        |
        TAX                                     ;$048EB7        |
        REP #$20                                ;$048EB8        |
        LDY.w $0DD6                             ;$048EBA        |
        LDA.w DATA_048E49,X                     ;$048EBD        |
        STA.w $1F17,Y                           ;$048EC0        |
        LDA.w DATA_048E4F,X                     ;$048EC3        |
        STA.w $1F19,Y                           ;$048EC6        |
        SEP #$20                                ;$048EC9        |
        BRA CODE_048EE1                         ;$048ECB        |

ADDR_048ECD:
        TAX
        LDA.w DATA_04FB85,X                     ;$048ECE        |
        ORA.w $0EF5                             ;$048ED1        |
        STA.w $0EF5                             ;$048ED4        |
        BRA CODE_048EE1                         ;$048ED7        |

ADDR_048ED9:
        LDA.w $0DD5
        BMI CODE_048EE1                         ;$048EDC        |
        STZ.w $0DE5,X                           ;$048EDE        |
CODE_048EE1:
        REP #$30
        JSR CODE_049831                         ;$048EE3        |
        SEP #$30                                ;$048EE6        |
        JSR DrawOWBoarder                       ;$048EE8        |
        JSR CODE_048086                         ;$048EEB        |
        JMP OW_Tile_Animation                   ;$048EEE        |

CODE_048EF1:
        LDA.b #$08
        STA.w $0DB1                             ;$048EF3        |
        LDA.w $1F11                             ;$048EF6        |
        CMP.b #$01                              ;$048EF9        |
        BNE CODE_048F13                         ;$048EFB        |
        LDA.w $1F17                             ;$048EFD        |
        CMP.b #$68                              ;$048F00        |
        BNE CODE_048F13                         ;$048F02        |
        LDA.w $1F19                             ;$048F04        |
        CMP.b #$8E                              ;$048F07        |
        BNE CODE_048F13                         ;$048F09        |
        LDA.b #$0C                              ;$048F0B        |
        STA.w $13D9                             ;$048F0D        |
        BRL CODE_048F7A                         ;$048F10        |
CODE_048F13:
        REP #$20
        LDX.w $0DD6                             ;$048F15        |
        LDA.w $1F17,X                           ;$048F18        |
        LSR                                     ;$048F1B        |
        LSR                                     ;$048F1C        |
        LSR                                     ;$048F1D        |
        LSR                                     ;$048F1E        |
        STA $00                                 ;$048F1F        |
        LDA.w $1F19,X                           ;$048F21        |
        LSR                                     ;$048F24        |
        LSR                                     ;$048F25        |
        LSR                                     ;$048F26        |
        LSR                                     ;$048F27        |
        STA $02                                 ;$048F28        |
        TXA                                     ;$048F2A        |
        LSR                                     ;$048F2B        |
        LSR                                     ;$048F2C        |
        TAX                                     ;$048F2D        |
        JSR OW_TilePos_Calc                     ;$048F2E        |
        REP #$10                                ;$048F31        |
        SEP #$20                                ;$048F33        |
        LDA.w $13CE                             ;$048F35        |
        BEQ CODE_048F56                         ;$048F38        |
        LDA.w $0DD5                             ;$048F3A        |
        BEQ CODE_048F56                         ;$048F3D        |
        BPL CODE_048F5F                         ;$048F3F        |
        REP #$20                                ;$048F41        |
        LDX $04                                 ;$048F43        |
        LDA.l $7ED000,X                         ;$048F45        |
        AND.w #$00FF                            ;$048F49        |
        TAX                                     ;$048F4C        |
        LDA.w $1EA2,X                           ;$048F4D        |
        ORA.w #$0040                            ;$048F50        |
        STA.w $1EA2,X                           ;$048F53        |
CODE_048F56:
        SEP #$20
        LDA.b #$05                              ;$048F58        |
        STA.w $13D9                             ;$048F5A        |
        BRA CODE_048F7A                         ;$048F5D        |

CODE_048F5F:
        REP #$20
        LDX $04                                 ;$048F61        |
        LDA.l $7ED000,X                         ;$048F63        |
        AND.w #$00FF                            ;$048F67        |
        TAX                                     ;$048F6A        |
        LDA.w $1EA2,X                           ;$048F6B        |
        ORA.w #$0080                            ;$048F6E        |
        AND.w #$FFBF                            ;$048F71        |
        STA.w $1EA2,X                           ;$048F74        |
        INC.w $13D9                             ;$048F77        |
CODE_048F7A:
        REP #$30
        JMP CODE_049831                         ;$048F7C        |

DATA_048F7F:
        db $58,$59,$5D,$63,$77,$79,$7E,$80

CODE_048F87:
        JSR CODE_049903
        LDX.b #$07                              ;$048F8A        |
CODE_048F8C:
        LDA.w $13C1
        CMP.w DATA_048F7F,X                     ;$048F8F        |
        BNE CODE_049000                         ;$048F92        |
        LDX.b #$2C                              ;$048F94        |
CODE_048F96:
        LDA.w $1F02,X
        STA.w $1FA9,X                           ;$048F99        |
        DEX                                     ;$048F9C        |
        BPL CODE_048F96                         ;$048F9D        |
        REP #$30                                ;$048F9F        |
        LDX.w $0DD6                             ;$048FA1        |
        TXA                                     ;$048FA4        |
        EOR.w #$0004                            ;$048FA5        |
        TAY                                     ;$048FA8        |
        LDA.w $1FBE,X                           ;$048FA9        |
        STA.w $1FBE,Y                           ;$048FAC        |
        LDA.w $1FC0,X                           ;$048FAF        |
        STA.w $1FC0,Y                           ;$048FB2        |
        LDA.w $1FC6,X                           ;$048FB5        |
        STA.w $1FC6,Y                           ;$048FB8        |
        LDA.w $1FC8,X                           ;$048FBB        |
        STA.w $1FC8,Y                           ;$048FBE        |
        TXA                                     ;$048FC1        |
        LSR                                     ;$048FC2        |
        TAX                                     ;$048FC3        |
        EOR.w #$0002                            ;$048FC4        |
        TAY                                     ;$048FC7        |
        LDA.w $1FBA,X                           ;$048FC8        |
        STA.w $1FBA,Y                           ;$048FCB        |
        TXA                                     ;$048FCE        |
        SEP #$30                                ;$048FCF        |
        LSR                                     ;$048FD1        |
        TAX                                     ;$048FD2        |
        EOR.b #$01                              ;$048FD3        |
        TAY                                     ;$048FD5        |
        LDA.w $1FB8,X                           ;$048FD6        |
        STA.w $1FB8,Y                           ;$048FD9        |
        LDA.w $0DD5                             ;$048FDC        |
        CMP.b #$E0                              ;$048FDF        |
        BNE CODE_048FFB                         ;$048FE1        |
        DEC.w $0DB1                             ;$048FE3        |
        BMI ADDR_048FE9                         ;$048FE6        |
        RTS                                     ;$048FE8        |

ADDR_048FE9:
        INC.w $13CA
        JSR CODE_049037                         ;$048FEC        |
        LDA.b #$02                              ;$048FEF        |
        STA.w $0DB1                             ;$048FF1        |
        LDA.b #$04                              ;$048FF4        |
        STA.w $13D9                             ;$048FF6        |
        BRA CODE_049003                         ;$048FF9        |

CODE_048FFB:
        INC.w $13CA
        BRA CODE_049003                         ;$048FFE        |

CODE_049000:
        DEX
        BPL CODE_048F8C                         ;$049001        |
CODE_049003:
        REP #$20
        STZ $06                                 ;$049005        |
        LDX.w $0DD6                             ;$049007        |
        LDA.w $1F17,X                           ;$04900A        |
        LSR                                     ;$04900D        |
        LSR                                     ;$04900E        |
        LSR                                     ;$04900F        |
        LSR                                     ;$049010        |
        STA $00                                 ;$049011        |
        LDA.w $1F19,X                           ;$049013        |
        LSR                                     ;$049016        |
        LSR                                     ;$049017        |
        LSR                                     ;$049018        |
        LSR                                     ;$049019        |
        STA $02                                 ;$04901A        |
        TXA                                     ;$04901C        |
        LSR                                     ;$04901D        |
        LSR                                     ;$04901E        |
        TAX                                     ;$04901F        |
        JSR OW_TilePos_Calc                     ;$049020        |
        REP #$10                                ;$049023        |
        LDX $04                                 ;$049025        |
        LDA.l $7EC800,X                         ;$049027        |
        AND.w #$00FF                            ;$04902B        |
        STA.w $13C1                             ;$04902E        |
        SEP #$30                                ;$049031        |
        INC.w $13D9                             ;$049033        |
        RTS                                     ;$049036        |

CODE_049037:
        PHX
        PHY                                     ;$049038        |
        PHP                                     ;$049039        |
        SEP #$30                                ;$04903A        |
        LDA.w $13CA                             ;$04903C        |
        BEQ CODE_049054                         ;$04903F        |
        LDX.b #$5F                              ;$049041        |
CODE_049043:
        LDA.w $1EA2,X
        STA.w $1F49,X                           ;$049046        |
        DEX                                     ;$049049        |
        BPL CODE_049043                         ;$04904A        |
        STZ.w $13CA                             ;$04904C        |
        LDA.b #$05                              ;$04904F        |
        STA.w $1B87                             ;$049051        |
CODE_049054:
        PLP
        PLY                                     ;$049055        |
        PLX                                     ;$049056        |
        RTS                                     ;$049057        |

DATA_049058:
        db $FF,$FF,$01,$00,$FF,$FF,$01,$00
DATA_049060:
        db $05,$03,$01,$00

DATA_049064:
        db $00,$00,$02,$00,$04,$00,$06,$00
DATA_04906C:
        db $28,$00,$08,$00,$14,$00,$36,$00
        db $3F,$00,$45,$00

HardCodedOWPaths:
        db $09,$15,$23,$1B,$43,$44,$24,$FF
        db $30,$31

DATA_049082:
        db $78,$01

DATA_049084:
        db $28,$01

DATA_049086:
        db $10,$10,$1E,$19,$16,$66,$16,$19
        db $1E,$10,$10,$66,$04,$04,$04,$58
        db $04,$04,$04,$66,$04,$04,$04,$04
        db $04,$6A,$04,$04,$04,$04,$04,$66
        db $1E,$19,$06,$09,$0F,$20,$1A,$21
        db $1A,$14,$19,$18,$1F,$17,$82,$17
        db $1F,$18,$19,$14,$1A,$21,$1A,$20
        db $0F,$09,$06,$19,$1E,$66,$04,$04
        db $58,$04,$04,$5F

DATA_0490CA:
        db $02,$02,$02,$02,$06,$06,$04,$04
        db $00,$00,$00,$00,$04,$04,$04,$04
        db $06,$06,$06,$06,$06,$06,$06,$06
        db $06,$06,$04,$04,$04,$04,$04,$04
        db $02,$02,$06,$06,$00,$00,$00,$04
        db $00,$04,$04,$00,$04,$00,$04,$06
        db $02,$06,$02,$06,$06,$02,$06,$02
        db $02,$02,$04,$04,$00,$00,$06,$06
        db $06,$04,$04,$04

DATA_04910E:
        db $00,$06,$0C,$10,$14,$1A,$20,$2F
        db $3E,$41,$08,$00,$04,$00,$02,$00
        db $01,$00

CODE_049120:
        STZ.w $0DD8
        LDY.w $0EF7                             ;$049123        |
        BMI OWPU_NotOnPipe                      ;$049126        |
        LDA.w $0DD5                             ;$049128        |
        BMI CODE_049132                         ;$04912B        |
        BEQ CODE_049132                         ;$04912D        |
        BRL CODE_0491E9                         ;$04912F        |
CODE_049132:
        LDA $16
        AND.b #$20                              ;$049134        |
        BRA OW_Player_Update                    ;$049136        |

        LDA.w $13C1                             ;$049138        |
        BEQ CODE_049165                         ;$04913B        |
        CMP.b #$56                              ;$04913D        |
        BEQ CODE_049165                         ;$04913F        |
OW_Player_Update:
        LDA $17
        AND.b #$30                              ;$049143        |
        CMP.b #$30                              ;$049145        |
        BNE OWPU_NoLR                           ;$049147        |
        LDA.w $13C1                             ;$049149        |
        CMP.b #$81                              ;$04914C        |
        BEQ OWPU_EnterLevel                     ;$04914E        |
OWPU_NoLR:
        LDA $16
        ORA $18                                 ;$049152        |
        AND.b #$C0                              ;$049154        |
        BNE OWPU_ABXY                           ;$049156        |
        BRL CODE_0491E9                         ;$049158        |
OWPU_ABXY:
        STZ.w $1B9E
        LDA.w $13C1                             ;$04915E        |
        CMP.b #$5F                              ;$049161        |
        BNE OWPU_NotOnStar                      ;$049163        |
CODE_049165:
        JSR CODE_048509
        BNE OWPU_IsOnPipeRTS                    ;$049168        |
        STZ.w $1DF7                             ;$04916A        |
        STZ.w $1DF8                             ;$04916D        |
        LDA.b #$0D                              ;$049170        |
        STA.w $1DF9                             ;$049172        |
        LDA.b #$0B                              ;$049175        |
        STA.w $13D9                             ;$049177        |
        JMP CODE_049E52                         ;$04917A        |

OWPU_NotOnStar:
        LDA.w $13C1
        CMP.b #$82                              ;$049180        |
        BEQ OWPU_IsOnPipe                       ;$049182        |
        CMP.b #$5B                              ;$049184        |
        BNE OWPU_NotOnPipe                      ;$049186        |
OWPU_IsOnPipe:
        JSR CODE_048509
        BNE OWPU_IsOnPipeRTS                    ;$04918B        |
CODE_04918D:
        INC.w $1B9C
        STZ.w $0DD5                             ;$049190        |
        LDA.b #$0B                              ;$049193        |
        STA.w $0100                             ;$049195        |
OWPU_IsOnPipeRTS:
        RTS

OWPU_NotOnPipe:
        CMP.b #$81
        BEQ CODE_0491E9                         ;$04919B        |
        BCS CODE_0491E9                         ;$04919D        |
OWPU_EnterLevel:
        LDA.w $0DD6
        LSR                                     ;$0491A2        |
        AND.b #$02                              ;$0491A3        |
        TAX                                     ;$0491A5        |
        LDY.b #$10                              ;$0491A6        |
        LDA.w $1F13,X                           ;$0491A8        |
        AND.b #$08                              ;$0491AB        |
        BEQ CODE_0491B1                         ;$0491AD        |
        LDY.b #$12                              ;$0491AF        |
CODE_0491B1:
        TYA
        STA.w $1F13,X                           ;$0491B2        |
        LDX.w $0DB3                             ;$0491B5        |
        LDA.w $0DB6,X                           ;$0491B8        |
        STA.w $0DBF                             ;$0491BB        |
        LDA.w $0DB4,X                           ;$0491BE        |
        STA.w $0DBE                             ;$0491C1        |
        LDA.w $0DB8,X                           ;$0491C4        |
        STA $19                                 ;$0491C7        |
        LDA.w $0DBA,X                           ;$0491C9        |
        STA.w $0DC1                             ;$0491CC        |
        STA.w $13C7                             ;$0491CF        |
        STA.w $187A                             ;$0491D2        |
        LDA.w $0DBC,X                           ;$0491D5        |
        STA.w $0DC2                             ;$0491D8        |
        LDA.b #$02                              ;$0491DB        |
        STA.w $0DB1                             ;$0491DD        |
        LDA.b #$80                              ;$0491E0        |
        STA.w $1DFB                             ;$0491E2        |
        INC.w $0100                             ;$0491E5        |
        RTS                                     ;$0491E8        |

CODE_0491E9:
        REP #$20
        LDX.w $0DD6                             ;$0491EB        |
        LDA.w $1F17,X                           ;$0491EE        |
        LSR                                     ;$0491F1        |
        LSR                                     ;$0491F2        |
        LSR                                     ;$0491F3        |
        LSR                                     ;$0491F4        |
        STA $00                                 ;$0491F5        |
        STA.w $1F1F,X                           ;$0491F7        |
        LDA.w $1F19,X                           ;$0491FA        |
        LSR                                     ;$0491FD        |
        LSR                                     ;$0491FE        |
        LSR                                     ;$0491FF        |
        LSR                                     ;$049200        |
        STA $02                                 ;$049201        |
        STA.w $1F21,X                           ;$049203        |
        TXA                                     ;$049206        |
        LSR                                     ;$049207        |
        LSR                                     ;$049208        |
        TAX                                     ;$049209        |
        JSR OW_TilePos_Calc                     ;$04920A        |
        SEP #$20                                ;$04920D        |
        LDX.w $0DD5                             ;$04920F        |
        BEQ OWPU_NotAutoWalk                    ;$049212        |
        DEX                                     ;$049214        |
        LDA.w DATA_049060,X                     ;$049215        |
        STA $08                                 ;$049218        |
        STZ $09                                 ;$04921A        |
        REP #$30                                ;$04921C        |
        LDX $04                                 ;$04921E        |
        LDA.l $7ED000,X                         ;$049220        |
        AND.w #$00FF                            ;$049224        |
        LDY.w #$000A                            ;$049227        |
CODE_04922A:
        CMP.w DATA_04906C,Y
        BNE CODE_04923B                         ;$04922D        |
        LDA.w #$0005                            ;$04922F        |
        STA.w $13D9                             ;$049232        |
        JSR CODE_049037                         ;$049235        |
        BRL CODE_049411                         ;$049238        |
CODE_04923B:
        DEY
        DEY                                     ;$04923C        |
        BPL CODE_04922A                         ;$04923D        |
        LDA.l $7ED800,X                         ;$04923F        |
        AND.w #$00FF                            ;$049243        |
        LDX $08                                 ;$049246        |
        BEQ CODE_04924E                         ;$049248        |
CODE_04924A:
        LSR
        DEX                                     ;$04924B        |
        BPL CODE_04924A                         ;$04924C        |
CODE_04924E:
        AND.w #$0003
        ASL                                     ;$049251        |
        TAX                                     ;$049252        |
        LDA.w DATA_049064,X                     ;$049253        |
        TAY                                     ;$049256        |
        JMP CODE_0492BC                         ;$049257        |

OWPU_NotAutoWalk:
        SEP #$30
        STZ.w $0DD5                             ;$04925C        |
        LDA $16                                 ;$04925F        |
        AND.b #$0F                              ;$049261        |
        BEQ CODE_04926E                         ;$049263        |
        LDX.w $13C1                             ;$049265        |
        CPX.b #$82                              ;$049268        |
        BEQ CODE_0492AD                         ;$04926A        |
        BRA CODE_04928C                         ;$04926C        |

CODE_04926E:
        DEC.w $144E
        BPL CODE_049287                         ;$049271        |
        STZ.w $144E                             ;$049273        |
        LDA.w $0DD6                             ;$049276        |
        LSR                                     ;$049279        |
        AND.b #$02                              ;$04927A        |
        TAX                                     ;$04927C        |
        LDA.w $1F13,X                           ;$04927D        |
        AND.b #$08                              ;$049280        |
        ORA.b #$02                              ;$049282        |
        STA.w $1F13,X                           ;$049284        |
CODE_049287:
        REP #$30
        JMP CODE_049831                         ;$049289        |

CODE_04928C:
        REP #$30
        AND.w #$00FF                            ;$04928E        |
        NOP                                     ;$049291        |
        NOP                                     ;$049292        |
        NOP                                     ;$049293        |
        PHA                                     ;$049294        |
        STZ $06                                 ;$049295        |
        LDX $04                                 ;$049297        |
        LDA.l $7ED000,X                         ;$049299        |
        AND.w #$00FF                            ;$04929D        |
        TAX                                     ;$0492A0        |
        PLA                                     ;$0492A1        |
        AND.w $1EA2,X                           ;$0492A2        |
        AND.w #$000F                            ;$0492A5        |
        BNE CODE_0492AD                         ;$0492A8        |
        JMP CODE_049411                         ;$0492AA        |

CODE_0492AD:
        REP #$30
        AND.w #$00FF                            ;$0492AF        |
        LDY.w #$0006                            ;$0492B2        |
CODE_0492B5:
        LSR
        BCS CODE_0492BC                         ;$0492B6        |
        DEY                                     ;$0492B8        |
        DEY                                     ;$0492B9        |
        BPL CODE_0492B5                         ;$0492BA        |
CODE_0492BC:
        TYA
        STA.w $0DD3                             ;$0492BD        |
        LDX.w #$0000                            ;$0492C0        |
        CPY.w #$0004                            ;$0492C3        |
        BCS CODE_0492CB                         ;$0492C6        |
        LDX.w #$0002                            ;$0492C8        |
CODE_0492CB:
        LDA $04
        STA $08                                 ;$0492CD        |
        LDA $00,X                               ;$0492CF        |
        CLC                                     ;$0492D1        |
        ADC.w DATA_049058,Y                     ;$0492D2        |
        STA $00,X                               ;$0492D5        |
        LDA.w $0DD6                             ;$0492D7        |
        LSR                                     ;$0492DA        |
        LSR                                     ;$0492DB        |
        TAX                                     ;$0492DC        |
        JSR OW_TilePos_Calc                     ;$0492DD        |
        LDX $04                                 ;$0492E0        |
        BMI CODE_049301                         ;$0492E2        |
        CMP.w #$0800                            ;$0492E4        |
        BCS CODE_049301                         ;$0492E7        |
        LDA.l $7EC800,X                         ;$0492E9        |
        AND.w #$00FF                            ;$0492ED        |
        BEQ CODE_049301                         ;$0492F0        |
        CMP.w #$0056                            ;$0492F2        |
        BCC CODE_0492FE                         ;$0492F5        |
        CMP.w #$0087                            ;$0492F7        |
        BCC CODE_0492FE                         ;$0492FA        |
        BRA CODE_049301                         ;$0492FC        |

CODE_0492FE:
        BRL CODE_049384
CODE_049301:
        STZ.w $1B78
        STZ.w $1B7A                             ;$049304        |
        LDX $08                                 ;$049307        |
        LDA.l $7ED000,X                         ;$049309        |
        AND.w #$00FF                            ;$04930D        |
        STA $00                                 ;$049310        |
        LDX.w #$0009                            ;$049312        |
CODE_049315:
        LDA.w HardCodedOWPaths,X
        AND.w #$00FF                            ;$049318        |
        CMP.w #$00FF                            ;$04931B        |
        BNE CODE_049349                         ;$04931E        |
        PHX                                     ;$049320        |
        LDX.w $0DD6                             ;$049321        |
        LDA.w $1F19,X                           ;$049324        |
        CMP.w DATA_049082                       ;$049327        |
        BNE CODE_049346                         ;$04932A        |
        LDA.w $1F17,X                           ;$04932C        |
        CMP.w DATA_049084                       ;$04932F        |
        BNE CODE_049346                         ;$049332        |
        LDA.w $0DB3                             ;$049334        |
        AND.w #$00FF                            ;$049337        |
        TAX                                     ;$04933A        |
        LDA.w $1F11,X                           ;$04933B        |
        AND.w #$00FF                            ;$04933E        |
        BNE CODE_049346                         ;$049341        |
        PLX                                     ;$049343        |
        BRA CODE_04934D                         ;$049344        |

CODE_049346:
        PLX
        BRA CODE_049374                         ;$049347        |

CODE_049349:
        CMP $00
        BNE CODE_049374                         ;$04934B        |
CODE_04934D:
        STX $00
        LDA.w DATA_04910E,X                     ;$04934F        |
        AND.w #$00FF                            ;$049352        |
        TAX                                     ;$049355        |
        DEC A                                   ;$049356        |
        STA.w $1B7A                             ;$049357        |
        STY $02                                 ;$04935A        |
        LDA.w DATA_0490CA,X                     ;$04935C        |
        AND.w #$00FF                            ;$04935F        |
        CMP $02                                 ;$049362        |
        BNE CODE_04937A                         ;$049364        |
        LDA.w #$0001                            ;$049366        |
        STA.w $1B78                             ;$049369        |
        LDA.w DATA_049086,X                     ;$04936C        |
        AND.w #$00FF                            ;$04936F        |
        BRA CODE_049384                         ;$049372        |

CODE_049374:
        DEX
        BMI CODE_04937A                         ;$049375        |
        BRL CODE_049315                         ;$049377        |
CODE_04937A:
        SEP #$20
        STZ.w $0DD5                             ;$04937C        |
        REP #$20                                ;$04937F        |
        JMP CODE_049411                         ;$049381        |

CODE_049384:
        STA.w $13C1
        STA $00                                 ;$049387        |
        STZ $02                                 ;$049389        |
        LDX.w #$0017                            ;$04938B        |
CODE_04938E:
        LDA.w DATA_04A03C,X
        AND.w #$00FF                            ;$049391        |
        CMP $00                                 ;$049394        |
        BNE CODE_0493B5                         ;$049396        |
        LDA.w DATA_04A0E4,X                     ;$049398        |
        CLC                                     ;$04939B        |
        ADC.w $0DD6                             ;$04939C        |
        PHA                                     ;$04939F        |
        TXA                                     ;$0493A0        |
        ASL                                     ;$0493A1        |
        ASL                                     ;$0493A2        |
        TAX                                     ;$0493A3        |
        LDA.w DATA_04A084,X                     ;$0493A4        |
        STA $00                                 ;$0493A7        |
        LDA.w DATA_04A086,X                     ;$0493A9        |
        STA $02                                 ;$0493AC        |
        PLA                                     ;$0493AE        |
        AND.w #$00FF                            ;$0493AF        |
        TAX                                     ;$0493B2        |
        BRA CODE_0493DA                         ;$0493B3        |

CODE_0493B5:
        DEX
        BPL CODE_04938E                         ;$0493B6        |
        LDX.w #$0008                            ;$0493B8        |
        TYA                                     ;$0493BB        |
        AND.w #$0002                            ;$0493BC        |
        BNE CODE_0493C7                         ;$0493BF        |
        TXA                                     ;$0493C1        |
        EOR.w #$FFFF                            ;$0493C2        |
        INC A                                   ;$0493C5        |
        TAX                                     ;$0493C6        |
CODE_0493C7:
        STX $00
        LDX.w #$0000                            ;$0493C9        |
        CPY.w #$0004                            ;$0493CC        |
        BCS CODE_0493D4                         ;$0493CF        |
        LDX.w #$0002                            ;$0493D1        |
CODE_0493D4:
        TXA
        CLC                                     ;$0493D5        |
        ADC.w $0DD6                             ;$0493D6        |
        TAX                                     ;$0493D9        |
CODE_0493DA:
        LDA $00
        CLC                                     ;$0493DC        |
        ADC.w $1F17,X                           ;$0493DD        |
        STA.w $0DC7,X                           ;$0493E0        |
        TXA                                     ;$0493E3        |
        EOR.w #$0002                            ;$0493E4        |
        TAX                                     ;$0493E7        |
        LDA $02                                 ;$0493E8        |
        CLC                                     ;$0493EA        |
        ADC.w $1F17,X                           ;$0493EB        |
        STA.w $0DC7,X                           ;$0493EE        |
        TXA                                     ;$0493F1        |
        LSR                                     ;$0493F2        |
        AND.w #$0002                            ;$0493F3        |
        TAX                                     ;$0493F6        |
        TYA                                     ;$0493F7        |
        STA $00                                 ;$0493F8        |
        LDA.w $1F13,X                           ;$0493FA        |
        AND.w #$0008                            ;$0493FD        |
        ORA $00                                 ;$049400        |
        STA.w $1F13,X                           ;$049402        |
        LDA.w #$000F                            ;$049405        |
        STA.w $144E                             ;$049408        |
        INC.w $13D9                             ;$04940B        |
        STZ.w $1444                             ;$04940E        |
CODE_049411:
        JMP CODE_049831

DATA_049414:
        db $0D,$08

DATA_049416:
        db $EF,$FF,$D7,$FF

DATA_04941A:
        db $11,$01,$31,$01

DATA_04941E:
        db $08,$00,$04,$00,$02,$00,$01,$00
DATA_049426:
        db $44,$43,$45,$46,$47,$48,$25,$40
        db $42,$4D

DATA_049430:
        db $0C

DATA_049431:
        db $00,$0E,$00,$10,$06,$12,$00,$18
        db $04,$1A,$02,$20,$06,$42,$06,$4E
        db $04,$50,$02,$58,$06,$5A,$00,$70
        db $06,$90,$00,$A0,$06

DATA_04944E:
        db $01,$01,$00,$01,$01,$00,$00,$00
        db $01,$00,$00,$01,$00,$01,$00

CODE_04945D:
        LDA.w $0DD8
        BEQ CODE_049468                         ;$049460        |
        LDA.b #$08                              ;$049462        |
        STA.w $13D9                             ;$049464        |
        RTS                                     ;$049467        |

CODE_049468:
        REP #$30
        LDA.w $0DD6                             ;$04946A        |
        CLC                                     ;$04946D        |
        ADC.w #$0002                            ;$04946E        |
        TAY                                     ;$049471        |
        LDX.w #$0002                            ;$049472        |
CODE_049475:
        LDA.w $0DC7,Y
        SEC                                     ;$049478        |
        SBC.w $1F17,Y                           ;$049479        |
        STA $00,X                               ;$04947C        |
        BPL CODE_049484                         ;$04947E        |
        EOR.w #$FFFF                            ;$049480        |
        INC A                                   ;$049483        |
CODE_049484:
        STA $04,X
        DEY                                     ;$049486        |
        DEY                                     ;$049487        |
        DEX                                     ;$049488        |
        DEX                                     ;$049489        |
        BPL CODE_049475                         ;$04948A        |
        LDY.w #$FFFF                            ;$04948C        |
        LDA $04                                 ;$04948F        |
        STA $0A                                 ;$049491        |
        LDA $06                                 ;$049493        |
        STA $0C                                 ;$049495        |
        CMP $04                                 ;$049497        |
        BCC CODE_0494A4                         ;$049499        |
        STA $0A                                 ;$04949B        |
        LDA $04                                 ;$04949D        |
        STA $0C                                 ;$04949F        |
        LDY.w #$0001                            ;$0494A1        |
CODE_0494A4:
        STY $08
        SEP #$20                                ;$0494A6        |
        LDX.w $1B80                             ;$0494A8        |
        LDA.w DATA_049414,X                     ;$0494AB        |
        ASL                                     ;$0494AE        |
        ASL                                     ;$0494AF        |
        ASL                                     ;$0494B0        |
        ASL                                     ;$0494B1        |
        STA.w $4202                             ;$0494B2        |
        LDA $0C                                 ;$0494B5        |
        BEQ CODE_0494DA                         ;$0494B7        |
        STA.w $4203                             ;$0494B9        |
        NOP                                     ;$0494BC        |
        NOP                                     ;$0494BD        |
        NOP                                     ;$0494BE        |
        NOP                                     ;$0494BF        |
        REP #$20                                ;$0494C0        |
        LDA.w $4216                             ;$0494C2        |
        STA.w $4204                             ;$0494C5        |
        SEP #$20                                ;$0494C8        |
        LDA $0A                                 ;$0494CA        |
        STA.w $4206                             ;$0494CC        |
        NOP                                     ;$0494CF        |
        NOP                                     ;$0494D0        |
        NOP                                     ;$0494D1        |
        NOP                                     ;$0494D2        |
        NOP                                     ;$0494D3        |
        NOP                                     ;$0494D4        |
        REP #$20                                ;$0494D5        |
        LDA.w $4214                             ;$0494D7        |
CODE_0494DA:
        REP #$20
        STA $0E                                 ;$0494DC        |
        LDX.w $1B80                             ;$0494DE        |
        LDA.w DATA_049414,X                     ;$0494E1        |
        AND.w #$00FF                            ;$0494E4        |
        ASL                                     ;$0494E7        |
        ASL                                     ;$0494E8        |
        ASL                                     ;$0494E9        |
        ASL                                     ;$0494EA        |
        STA $0A                                 ;$0494EB        |
        LDX.w #$0002                            ;$0494ED        |
CODE_0494F0:
        LDA $08
        BMI CODE_0494F8                         ;$0494F2        |
        LDA $0A                                 ;$0494F4        |
        BRA CODE_0494FA                         ;$0494F6        |

CODE_0494F8:
        LDA $0E
CODE_0494FA:
        BIT $00,X
        BPL CODE_049502                         ;$0494FC        |
        EOR.w #$FFFF                            ;$0494FE        |
        INC A                                   ;$049501        |
CODE_049502:
        STA.w $0DCF,X
        LDA $08                                 ;$049505        |
        EOR.w #$FFFF                            ;$049507        |
        INC A                                   ;$04950A        |
        STA $08                                 ;$04950B        |
        DEX                                     ;$04950D        |
        DEX                                     ;$04950E        |
        BPL CODE_0494F0                         ;$04950F        |
        LDX.w #$0000                            ;$049511        |
        LDA $08                                 ;$049514        |
        BMI CODE_04951B                         ;$049516        |
        LDX.w #$0002                            ;$049518        |
CODE_04951B:
        LDA $00,X
        BEQ CODE_049522                         ;$04951D        |
        JMP CODE_049801                         ;$04951F        |

CODE_049522:
        LDA.w $1444
        BEQ CODE_04955C                         ;$049525        |
        STZ.w $1B78                             ;$049527        |
        LDX.w $0DD6                             ;$04952A        |
        LDA.w $1F1F,X                           ;$04952D        |
        STA $00                                 ;$049530        |
        LDA.w $1F21,X                           ;$049532        |
        STA $02                                 ;$049535        |
        TXA                                     ;$049537        |
        LSR                                     ;$049538        |
        LSR                                     ;$049539        |
        TAX                                     ;$04953A        |
        JSR OW_TilePos_Calc                     ;$04953B        |
        STZ $00                                 ;$04953E        |
        LDX $04                                 ;$049540        |
        LDA.l $7ED000,X                         ;$049542        |
        AND.w #$00FF                            ;$049546        |
        ASL                                     ;$049549        |
        TAX                                     ;$04954A        |
        LDA.w LevelNames,X                      ;$04954B        |
        STA $00                                 ;$04954E        |
        JSR CODE_049D07                         ;$049550        |
        INC.w $13D9                             ;$049553        |
        JSR CODE_049037                         ;$049556        |
        JMP CODE_049831                         ;$049559        |

CODE_04955C:
        LDA.w $13C1
        STA.w $1B7E                             ;$04955F        |
        LDA.w #$0008                            ;$049562        |
        STA $08                                 ;$049565        |
        LDY.w $0DD3                             ;$049567        |
        TYA                                     ;$04956A        |
        AND.w #$00FF                            ;$04956B        |
        EOR.w #$0002                            ;$04956E        |
        STA $0A                                 ;$049571        |
        BRA CODE_049582                         ;$049573        |

ADDR_049575:
        LDA $08
        SEC                                     ;$049577        |
        SBC.w #$0002                            ;$049578        |
        STA $08                                 ;$04957B        |
        CMP $0A                                 ;$04957D        |
        BEQ ADDR_049575                         ;$04957F        |
        TAY                                     ;$049581        |
CODE_049582:
        LDX.w $0DD6
        LDA.w $1F1F,X                           ;$049585        |
        STA $00                                 ;$049588        |
        LDA.w $1F21,X                           ;$04958A        |
        STA $02                                 ;$04958D        |
        LDX.w #$0000                            ;$04958F        |
        CPY.w #$0004                            ;$049592        |
        BCS CODE_04959A                         ;$049595        |
        LDX.w #$0002                            ;$049597        |
CODE_04959A:
        LDA $00,X
        CLC                                     ;$04959C        |
        ADC.w DATA_049058,Y                     ;$04959D        |
        STA $00,X                               ;$0495A0        |
        LDA.w $0DD6                             ;$0495A2        |
        LSR                                     ;$0495A5        |
        LSR                                     ;$0495A6        |
        TAX                                     ;$0495A7        |
        JSR OW_TilePos_Calc                     ;$0495A8        |
        LDA.w $1B78                             ;$0495AB        |
        BEQ CODE_0495CE                         ;$0495AE        |
        STY $06                                 ;$0495B0        |
        LDX.w $1B7A                             ;$0495B2        |
        INX                                     ;$0495B5        |
        LDA.w DATA_0490CA,X                     ;$0495B6        |
        AND.w #$00FF                            ;$0495B9        |
        CMP $06                                 ;$0495BC        |
        BNE ADDR_049575                         ;$0495BE        |
        STX.w $1B7A                             ;$0495C0        |
        LDA.w DATA_049086,X                     ;$0495C3        |
        AND.w #$00FF                            ;$0495C6        |
        CMP.w #$0058                            ;$0495C9        |
        BNE CODE_0495DE                         ;$0495CC        |
CODE_0495CE:
        LDX $04
        BMI ADDR_049575                         ;$0495D0        |
        CMP.w #$0800                            ;$0495D2        |
        BCS ADDR_049575                         ;$0495D5        |
        LDA.l $7EC800,X                         ;$0495D7        |
        AND.w #$00FF                            ;$0495DB        |
CODE_0495DE:
        STA.w $13C1
        BEQ ADDR_049575                         ;$0495E1        |
        CMP.w #$0087                            ;$0495E3        |
        BCS ADDR_049575                         ;$0495E6        |
        PHA                                     ;$0495E8        |
        PHY                                     ;$0495E9        |
        TAX                                     ;$0495EA        |
        DEX                                     ;$0495EB        |
        LDY.w #$0000                            ;$0495EC        |
        LDA.w DATA_049FEB,X                     ;$0495EF        |
        STA $0E                                 ;$0495F2        |
        AND.w #$00FF                            ;$0495F4        |
        CMP.w #$0014                            ;$0495F7        |
        BNE CODE_0495FF                         ;$0495FA        |
        LDY.w #$0001                            ;$0495FC        |
CODE_0495FF:
        STY.w $1B80
        LDX.w $0DD6                             ;$049602        |
        LDA $00                                 ;$049605        |
        STA.w $1F1F,X                           ;$049607        |
        LDA $02                                 ;$04960A        |
        STA.w $1F21,X                           ;$04960C        |
        PLY                                     ;$04960F        |
        PLA                                     ;$049610        |
        PHA                                     ;$049611        |
        SEP #$30                                ;$049612        |
        LDX.b #$09                              ;$049614        |
CODE_049616:
        CMP.w DATA_049426,X
        BNE CODE_049645                         ;$049619        |
        PHY                                     ;$04961B        |
        JSR CODE_049A24                         ;$04961C        |
        PLY                                     ;$04961F        |
        LDA.b #$01                              ;$049620        |
        STA.w $1B9E                             ;$049622        |
        JSR CODE_04F407                         ;$049625        |
        STZ.w $1B8C                             ;$049628        |
        REP #$20                                ;$04962B        |
        STZ.w $0701                             ;$04962D        |
        LDA.w #$7000                            ;$049630        |
        STA.w $1B8D                             ;$049633        |
        LDA.w #$5400                            ;$049636        |
        STA.w $1B8F                             ;$049639        |
        SEP #$20                                ;$04963C        |
        LDA.b #$0A                              ;$04963E        |
        STA.w $13D9                             ;$049640        |
        BRA CODE_049648                         ;$049643        |

CODE_049645:
        DEX
        BPL CODE_049616                         ;$049646        |
CODE_049648:
        REP #$30
        PLA                                     ;$04964A        |
        PHA                                     ;$04964B        |
        CMP.w #$0056                            ;$04964C        |
        BCS CODE_049654                         ;$04964F        |
        JMP CODE_04971D                         ;$049651        |

CODE_049654:
        CMP.w #$0080
        BEQ CODE_049663                         ;$049657        |
        CMP.w #$006A                            ;$049659        |
        BCC CODE_049676                         ;$04965C        |
        CMP.w #$006E                            ;$04965E        |
        BCS CODE_049676                         ;$049661        |
CODE_049663:
        LDA.w $0DD6
        LSR                                     ;$049666        |
        AND.w #$0002                            ;$049667        |
        TAX                                     ;$04966A        |
        LDA.w $1F13,X                           ;$04966B        |
        ORA.w #$0008                            ;$04966E        |
        STA.w $1F13,X                           ;$049671        |
        BRA CODE_049687                         ;$049674        |

CODE_049676:
        LDA.w $0DD6
        LSR                                     ;$049679        |
        AND.w #$0002                            ;$04967A        |
        TAX                                     ;$04967D        |
        LDA.w $1F13,X                           ;$04967E        |
        AND.w #$00F7                            ;$049681        |
        STA.w $1F13,X                           ;$049684        |
CODE_049687:
        LDA.w #$0001
        STA.w $1444                             ;$04968A        |
        LDA.w $13C1                             ;$04968D        |
        CMP.w #$005F                            ;$049690        |
        BEQ CODE_0496A5                         ;$049693        |
        CMP.w #$005B                            ;$049695        |
        BEQ CODE_0496A5                         ;$049698        |
        CMP.w #$0082                            ;$04969A        |
        BEQ CODE_0496A5                         ;$04969D        |
        LDA.w #$0023                            ;$04969F        |
        STA.w $1DFC                             ;$0496A2        |
CODE_0496A5:
        NOP
        NOP                                     ;$0496A6        |
        NOP                                     ;$0496A7        |
        LDA.w $13C1                             ;$0496A8        |
        AND.w #$00FF                            ;$0496AB        |
        CMP.w #$0082                            ;$0496AE        |
        BEQ CODE_0496D2                         ;$0496B1        |
        PHY                                     ;$0496B3        |
        TYA                                     ;$0496B4        |
        AND.w #$00FF                            ;$0496B5        |
        EOR.w #$0002                            ;$0496B8        |
        TAY                                     ;$0496BB        |
        STZ $06                                 ;$0496BC        |
        LDX $04                                 ;$0496BE        |
        LDA.l $7ED000,X                         ;$0496C0        |
        AND.w #$00FF                            ;$0496C4        |
        TAX                                     ;$0496C7        |
        LDA.w DATA_04941E,Y                     ;$0496C8        |
        ORA.w $1EA2,X                           ;$0496CB        |
        STA.w $1EA2,X                           ;$0496CE        |
        PLY                                     ;$0496D1        |
CODE_0496D2:
        LDA.w $0DD6
        LSR                                     ;$0496D5        |
        AND.w #$0002                            ;$0496D6        |
        TAX                                     ;$0496D9        |
        LDA.w $1F13,X                           ;$0496DA        |
        AND.w #$000C                            ;$0496DD        |
        STA $0E                                 ;$0496E0        |
        LDA.w #$0001                            ;$0496E2        |
        STA $04                                 ;$0496E5        |
        LDA.w $1B7E                             ;$0496E7        |
        AND.w #$00FF                            ;$0496EA        |
        STA $00                                 ;$0496ED        |
        LDX.w #$0017                            ;$0496EF        |
CODE_0496F2:
        LDA.w DATA_04A03C,X
        AND.w #$00FF                            ;$0496F5        |
        CMP $00                                 ;$0496F8        |
        BNE CODE_049704                         ;$0496FA        |
        TXA                                     ;$0496FC        |
        ASL                                     ;$0496FD        |
        TAX                                     ;$0496FE        |
        LDA.w DATA_04A054,X                     ;$0496FF        |
        BRA CODE_049718                         ;$049702        |

CODE_049704:
        DEX
        BPL CODE_0496F2                         ;$049705        |
        LDA.w #$0000                            ;$049707        |
        ORA.w #$0800                            ;$04970A        |
        CPY.w #$0004                            ;$04970D        |
        BCC CODE_049718                         ;$049710        |
        LDA.w #$0000                            ;$049712        |
        ORA.w #$0008                            ;$049715        |
CODE_049718:
        LDX.w #$0000
        BRA CODE_049728                         ;$04971B        |

CODE_04971D:
        DEC A
        ASL                                     ;$04971E        |
        TAX                                     ;$04971F        |
        LDA.w DATA_049F49,X                     ;$049720        |
        STA $04                                 ;$049723        |
        LDA.w DATA_049EA7,X                     ;$049725        |
CODE_049728:
        STA $00
        TXA                                     ;$04972A        |
        SEP #$20                                ;$04972B        |
        LDX.w #$001C                            ;$04972D        |
CODE_049730:
        CMP.w DATA_049430,X
        BEQ CODE_04973B                         ;$049733        |
        DEX                                     ;$049735        |
        DEX                                     ;$049736        |
        BPL CODE_049730                         ;$049737        |
        BRA CODE_04974A                         ;$049739        |

CODE_04973B:
        TYA
        CMP.w DATA_049431,X                     ;$04973C        |
        BEQ CODE_04974A                         ;$04973F        |
        TXA                                     ;$049741        |
        LSR                                     ;$049742        |
        TAX                                     ;$049743        |
        LDA.w DATA_04944E,X                     ;$049744        |
        TAX                                     ;$049747        |
        BRA CODE_049755                         ;$049748        |

CODE_04974A:
        LDX.w #$0000
        TYA                                     ;$04974D        |
        AND.b #$02                              ;$04974E        |
        BEQ CODE_049755                         ;$049750        |
        LDX.w #$0001                            ;$049752        |
CODE_049755:
        LDA $04,X
        BEQ CODE_049767                         ;$049757        |
        LDA $00                                 ;$049759        |
        EOR.b #$FF                              ;$04975B        |
        INC A                                   ;$04975D        |
        STA $00                                 ;$04975E        |
        LDA $01                                 ;$049760        |
        EOR.b #$FF                              ;$049762        |
        INC A                                   ;$049764        |
        STA $01                                 ;$049765        |
CODE_049767:
        REP #$20
        PLA                                     ;$049769        |
        LDX.w #$0000                            ;$04976A        |
        LDA $0E                                 ;$04976D        |
        AND.w #$0007                            ;$04976F        |
        BNE CODE_049777                         ;$049772        |
        LDX.w #$0001                            ;$049774        |
CODE_049777:
        LDA $0E
        AND.w #$00FF                            ;$049779        |
        STA $04                                 ;$04977C        |
        LDA $00,X                               ;$04977E        |
        AND.w #$00FF                            ;$049780        |
        CMP.w #$0080                            ;$049783        |
        BCS CODE_049790                         ;$049786        |
        LDA $04                                 ;$049788        |
        CLC                                     ;$04978A        |
        ADC.w #$0002                            ;$04978B        |
        STA $04                                 ;$04978E        |
CODE_049790:
        LDA.w $0DD6
        LSR                                     ;$049793        |
        AND.w #$0002                            ;$049794        |
        TAX                                     ;$049797        |
        LDA $04                                 ;$049798        |
        STA.w $1F13,X                           ;$04979A        |
        LDX.w $0DD6                             ;$04979D        |
        LDA $00                                 ;$0497A0        |
        AND.w #$00FF                            ;$0497A2        |
        CMP.w #$0080                            ;$0497A5        |
        BCC CODE_0497AD                         ;$0497A8        |
        ORA.w #$FF00                            ;$0497AA        |
CODE_0497AD:
        CLC
        ADC.w $1F17,X                           ;$0497AE        |
        AND.w #$FFFC                            ;$0497B1        |
        STA.w $0DC7,X                           ;$0497B4        |
        LDA $01                                 ;$0497B7        |
        AND.w #$00FF                            ;$0497B9        |
        CMP.w #$0080                            ;$0497BC        |
        BCC CODE_0497C4                         ;$0497BF        |
        ORA.w #$FF00                            ;$0497C1        |
CODE_0497C4:
        CLC
        ADC.w $1F19,X                           ;$0497C5        |
        AND.w #$FFFC                            ;$0497C8        |
        STA.w $0DC9,X                           ;$0497CB        |
        SEP #$20                                ;$0497CE        |
        LDA.w $0DC7,X                           ;$0497D0        |
        AND.b #$0F                              ;$0497D3        |
        BNE CODE_0497E3                         ;$0497D5        |
        LDY.w #$0004                            ;$0497D7        |
        LDA $00                                 ;$0497DA        |
        BMI CODE_0497E1                         ;$0497DC        |
        LDY.w #$0006                            ;$0497DE        |
CODE_0497E1:
        BRA CODE_0497F4

CODE_0497E3:
        LDA.w $0DC9,X
        AND.b #$0F                              ;$0497E6        |
        BNE CODE_0497F4                         ;$0497E8        |
        LDY.w #$0000                            ;$0497EA        |
        LDA $01                                 ;$0497ED        |
        BMI CODE_0497F4                         ;$0497EF        |
        LDY.w #$0002                            ;$0497F1        |
CODE_0497F4:
        STY.w $0DD3
        LDA.w $13D9                             ;$0497F7        |
        CMP.b #$0A                              ;$0497FA        |
        BEQ CODE_049831                         ;$0497FC        |
        JMP CODE_04945D                         ;$0497FE        |

CODE_049801:
        REP #$20
        LDA.w $0DD6                             ;$049803        |
        CLC                                     ;$049806        |
        ADC.w #$0002                            ;$049807        |
        TAX                                     ;$04980A        |
        LDY.w #$0002                            ;$04980B        |
CODE_04980E:
        LDA.w $13D5,Y
        AND.w #$00FF                            ;$049811        |
        CLC                                     ;$049814        |
        ADC.w $0DCF,Y                           ;$049815        |
        STA.w $13D5,Y                           ;$049818        |
        AND.w #$FF00                            ;$04981B        |
        BPL CODE_049823                         ;$04981E        |
        ORA.w #$00FF                            ;$049820        |
CODE_049823:
        XBA
        CLC                                     ;$049824        |
        ADC.w $1F17,X                           ;$049825        |
        STA.w $1F17,X                           ;$049828        |
        DEX                                     ;$04982B        |
        DEX                                     ;$04982C        |
        DEY                                     ;$04982D        |
        DEY                                     ;$04982E        |
        BPL CODE_04980E                         ;$04982F        |
CODE_049831:
        SEP #$20
        LDA.w $13D9                             ;$049833        |
        CMP.b #$0A                              ;$049836        |
        BEQ CODE_049882                         ;$049838        |
        LDA.w $1BA0                             ;$04983A        |
        BNE CODE_049882                         ;$04983D        |
CODE_04983F:
        REP #$30
        LDX.w $0DD6                             ;$049841        |
        LDA.w $1F17,X                           ;$049844        |
        STA $00                                 ;$049847        |
        LDA.w $1F19,X                           ;$049849        |
        STA $02                                 ;$04984C        |
        TXA                                     ;$04984E        |
        LSR                                     ;$04984F        |
        LSR                                     ;$049850        |
        TAX                                     ;$049851        |
        LDA.w $1F11,X                           ;$049852        |
        AND.w #$00FF                            ;$049855        |
        BNE CODE_049882                         ;$049858        |
        LDX.w #$0002                            ;$04985A        |
        TXY                                     ;$04985D        |
CODE_04985E:
        LDA $00,X
        SEC                                     ;$049860        |
        SBC.w #$0080                            ;$049861        |
        BPL CODE_049870                         ;$049864        |
        CMP.w DATA_049416,Y                     ;$049866        |
        BCS CODE_049878                         ;$049869        |
        LDA.w DATA_049416,Y                     ;$04986B        |
        BRA CODE_049878                         ;$04986E        |

CODE_049870:
        CMP.w DATA_04941A,Y
        BCC CODE_049878                         ;$049873        |
        LDA.w DATA_04941A,Y                     ;$049875        |
CODE_049878:
        STA $1A,X
        STA $1E,X                               ;$04987A        |
        DEY                                     ;$04987C        |
        DEY                                     ;$04987D        |
        DEX                                     ;$04987E        |
        DEX                                     ;$04987F        |
        BPL CODE_04985E                         ;$049880        |
CODE_049882:
        SEP #$30
        RTS                                     ;$049884        |

OW_TilePos_Calc:
        LDA $00
        AND.w #$000F                            ;$049887        |
        STA $04                                 ;$04988A        |
        LDA $00                                 ;$04988C        |
        AND.w #$0010                            ;$04988E        |
        ASL                                     ;$049891        |
        ASL                                     ;$049892        |
        ASL                                     ;$049893        |
        ASL                                     ;$049894        |
        ADC $04                                 ;$049895        |
        STA $04                                 ;$049897        |
        LDA $02                                 ;$049899        |
        ASL                                     ;$04989B        |
        ASL                                     ;$04989C        |
        ASL                                     ;$04989D        |
        ASL                                     ;$04989E        |
        AND.w #$00FF                            ;$04989F        |
        ADC $04                                 ;$0498A2        |
        STA $04                                 ;$0498A4        |
        LDA $02                                 ;$0498A6        |
        AND.w #$0010                            ;$0498A8        |
        BEQ CODE_0498B5                         ;$0498AB        |
        LDA $04                                 ;$0498AD        |
        CLC                                     ;$0498AF        |
        ADC.w #$0200                            ;$0498B0        |
        STA $04                                 ;$0498B3        |
CODE_0498B5:
        LDA.w $1F11,X
        AND.w #$00FF                            ;$0498B8        |
        BEQ Return0498C5                        ;$0498BB        |
        LDA $04                                 ;$0498BD        |
        CLC                                     ;$0498BF        |
        ADC.w #$0400                            ;$0498C0        |
        STA $04                                 ;$0498C3        |
Return0498C5:
        RTS

CODE_0498C6:
        STZ.w $1F13
        LDA.b #$80                              ;$0498C9        |
        CLC                                     ;$0498CB        |
        ADC.w $13D7                             ;$0498CC        |
        STA.w $13D7                             ;$0498CF        |
        PHP                                     ;$0498D2        |
        LDA.b #$0F                              ;$0498D3        |
        CMP.b #$08                              ;$0498D5        |
        LDY.b #$00                              ;$0498D7        |
        BCC CODE_0498DE                         ;$0498D9        |
        ORA.b #$F0                              ;$0498DB        |
        DEY                                     ;$0498DD        |
CODE_0498DE:
        PLP
        ADC.w $1F19                             ;$0498DF        |
        STA.w $1F19                             ;$0498E2        |
        TYA                                     ;$0498E5        |
        ADC.w $1F1A                             ;$0498E6        |
        STA.w $1F1A                             ;$0498E9        |
        LDA.w $1F19                             ;$0498EC        |
        CMP.b #$78                              ;$0498EF        |
        BNE Return0498FA                        ;$0498F1        |
        STZ.w $13D9                             ;$0498F3        |
        JSL CODE_009BC9                         ;$0498F6        |
Return0498FA:
        RTS

DATA_0498FB:
        db $08,$00,$04,$00,$02,$00,$01,$00

CODE_049903:
        LDX.w $0DD5
        BEQ Return0498C5                        ;$049906        |
        BMI Return0498C5                        ;$049908        |
        DEX                                     ;$04990A        |
        LDA.w DATA_049060,X                     ;$04990B        |
        STA $08                                 ;$04990E        |
        STZ $09                                 ;$049910        |
        REP #$20                                ;$049912        |
        LDX.w $0DD6                             ;$049914        |
        LDA.w $1F17,X                           ;$049917        |
        LSR                                     ;$04991A        |
        LSR                                     ;$04991B        |
        LSR                                     ;$04991C        |
        LSR                                     ;$04991D        |
        STA $00                                 ;$04991E        |
        STA.w $1F1F,X                           ;$049920        |
        LDA.w $1F19,X                           ;$049923        |
        LSR                                     ;$049926        |
        LSR                                     ;$049927        |
        LSR                                     ;$049928        |
        LSR                                     ;$049929        |
        STA $02                                 ;$04992A        |
        STA.w $1F21,X                           ;$04992C        |
        TXA                                     ;$04992F        |
        LSR                                     ;$049930        |
        LSR                                     ;$049931        |
        TAX                                     ;$049932        |
        JSR OW_TilePos_Calc                     ;$049933        |
        REP #$10                                ;$049936        |
        LDX $04                                 ;$049938        |
        LDA.l $7ED800,X                         ;$04993A        |
        AND.w #$00FF                            ;$04993E        |
        LDX $08                                 ;$049941        |
        BEQ CODE_049949                         ;$049943        |
CODE_049945:
        LSR
        DEX                                     ;$049946        |
        BPL CODE_049945                         ;$049947        |
CODE_049949:
        AND.w #$0003
        ASL                                     ;$04994C        |
        TAY                                     ;$04994D        |
        LDX $04                                 ;$04994E        |
        LDA.l $7ED000,X                         ;$049950        |
        AND.w #$00FF                            ;$049954        |
        TAX                                     ;$049957        |
        LDA.w DATA_04941E,Y                     ;$049958        |
        ORA.w $1EA2,X                           ;$04995B        |
        STA.w $1EA2,X                           ;$04995E        |
        SEP #$30                                ;$049961        |
        RTS                                     ;$049963        |

DATA_049964:
        db $40,$01

DATA_049966:
        db $28,$00

DATA_049968:
        db $00,$50,$01,$58,$00,$00,$10,$00
        db $48,$00,$01,$10,$00,$98,$00,$01
        db $A0,$00,$D8,$00,$00,$40,$01,$58
        db $00,$02,$90,$00,$E8,$01,$04,$60
        db $01,$E8,$00,$00,$A0,$00,$C8,$01
        db $00,$60,$01,$88,$00,$03,$08,$01
        db $90,$01,$00,$E8,$01,$10,$00,$03
        db $10,$01,$C8,$01,$00,$F0,$01,$88
        db $00,$03

DATA_0499AA:
        db $00,$00

DATA_0499AC:
        db $48,$00

DATA_0499AE:
        db $01,$00,$00,$98,$00,$01,$50,$01
        db $28,$00,$00,$60,$01,$58,$00,$00
        db $50,$01,$58,$00,$02,$90,$00,$D8
        db $00,$00,$50,$01,$E8,$00,$00,$A0
        db $00,$E8,$01,$04,$50,$01,$88,$00
        db $03,$B0,$00,$C8,$01,$00,$E8,$01
        db $00,$00,$03,$08,$01,$A0,$01,$00
        db $00,$02,$88,$00,$03,$00,$01,$C8
        db $01,$00

DATA_0499F0:
        db $00

DATA_0499F1:
        db $04,$00,$09,$14,$02,$15,$05,$14
        db $05,$09,$0D,$15,$0E,$09,$1E,$15
        db $08,$0A,$1C,$1E,$00,$10,$19,$1F
        db $08,$10,$1C

DATA_049A0C:
        db $EF,$FF

DATA_049A0E:
        db $D8,$FF,$EF,$FF,$80,$00,$EF,$FF
        db $28,$01,$F0,$00,$D8,$FF,$F0,$00
        db $80,$00,$F0,$00,$28,$01

CODE_049A24:
        REP #$20
        LDA.w $0DD6                             ;$049A26        |
        LSR                                     ;$049A29        |
        LSR                                     ;$049A2A        |
        TAX                                     ;$049A2B        |
        LDA.w $1F11,X                           ;$049A2C        |
        AND.w #$00FF                            ;$049A2F        |
        STA.w $13C3                             ;$049A32        |
        LDA.w #$001A                            ;$049A35        |
        STA $02                                 ;$049A38        |
        LDY.b #$41                              ;$049A3A        |
        LDX.w $0DD6                             ;$049A3C        |
CODE_049A3F:
        LDA.w $1F19,X
        CMP.w DATA_049964,Y                     ;$049A42        |
        BNE CODE_049A85                         ;$049A45        |
        LDA.w $1F17,X                           ;$049A47        |
        CMP.w DATA_049966,Y                     ;$049A4A        |
        BNE CODE_049A85                         ;$049A4D        |
        LDA.w DATA_049968,Y                     ;$049A4F        |
        AND.w #$00FF                            ;$049A52        |
        CMP.w $13C3                             ;$049A55        |
        BNE CODE_049A85                         ;$049A58        |
        LDA.w DATA_0499AA,Y                     ;$049A5A        |
        STA.w $1F19,X                           ;$049A5D        |
        LDA.w DATA_0499AC,Y                     ;$049A60        |
        STA.w $1F17,X                           ;$049A63        |
        LDA.w DATA_0499AE,Y                     ;$049A66        |
        AND.w #$00FF                            ;$049A69        |
        STA.w $13C3                             ;$049A6C        |
        LDY $02                                 ;$049A6F        |
        LDA.w DATA_0499F0,Y                     ;$049A71        |
        AND.w #$00FF                            ;$049A74        |
        STA.w $1F21,X                           ;$049A77        |
        LDA.w DATA_0499F1,Y                     ;$049A7A        |
        AND.w #$00FF                            ;$049A7D        |
        STA.w $1F1F,X                           ;$049A80        |
        BRA CODE_049A90                         ;$049A83        |

CODE_049A85:
        DEC $02
        DEC $02                                 ;$049A87        |
        DEY                                     ;$049A89        |
        DEY                                     ;$049A8A        |
        DEY                                     ;$049A8B        |
        DEY                                     ;$049A8C        |
        DEY                                     ;$049A8D        |
        BPL CODE_049A3F                         ;$049A8E        |
CODE_049A90:
        SEP #$20
        RTS                                     ;$049A92        |

CODE_049A93:
        LDA.w $0DD6
        AND.w #$00FF                            ;$049A96        |
        LSR                                     ;$049A99        |
        LSR                                     ;$049A9A        |
        TAX                                     ;$049A9B        |
        LDA.w $1F11,X                           ;$049A9C        |
        AND.w #$FF00                            ;$049A9F        |
        ORA.w $13C3                             ;$049AA2        |
        STA.w $1F11,X                           ;$049AA5        |
        AND.w #$00FF                            ;$049AA8        |
        BNE CODE_049AB0                         ;$049AAB        |
        JMP CODE_04983F                         ;$049AAD        |

CODE_049AB0:
        DEC A
        ASL                                     ;$049AB1        |
        ASL                                     ;$049AB2        |
        TAY                                     ;$049AB3        |
        LDA.w DATA_049A0C,Y                     ;$049AB4        |
        STA $1A                                 ;$049AB7        |
        STA $1E                                 ;$049AB9        |
        LDA.w DATA_049A0E,Y                     ;$049ABB        |
        STA $1C                                 ;$049ABE        |
        STA $20                                 ;$049AC0        |
        SEP #$30                                ;$049AC2        |
        RTS                                     ;$049AC4        |

LevelNameStrings:
        db $18,$0E,$12,$07,$08,$5D,$12,$9F
        db $12,$13,$00,$11,$9F,$5A,$64,$1F
        db $08,$06,$06,$18,$5D,$12,$9F,$5A
        db $65,$1F,$0C,$0E,$11,$13,$0E,$0D
        db $5D,$12,$9F,$5A,$66,$1F,$0B,$04
        db $0C,$0C,$18,$5D,$12,$9F,$5A,$67
        db $1F,$0B,$14,$03,$16,$08,$06,$5D
        db $12,$9F,$5A,$68,$1F,$11,$0E,$18
        db $5D,$12,$9F,$5A,$69,$1F,$16,$04
        db $0D,$03,$18,$5D,$12,$9F,$5A,$6A
        db $1F,$0B,$00,$11,$11,$18,$5D,$12
        db $9F,$03,$0E,$0D,$14,$13,$9F,$06
        db $11,$04,$04,$0D,$9F,$13,$0E,$0F
        db $1F,$12,$04,$02,$11,$04,$13,$1F
        db $00,$11,$04,$00,$9F,$15,$00,$0D
        db $08,$0B,$0B,$00,$9F,$38,$39,$3A
        db $3B,$3C,$9F,$11,$04,$03,$9F,$01
        db $0B,$14,$04,$9F,$01,$14,$13,$13
        db $04,$11,$1F,$01,$11,$08,$03,$06
        db $04,$9F,$02,$07,$04,$04,$12,$04
        db $1F,$01,$11,$08,$03,$06,$04,$9F
        db $12,$0E,$03,$00,$1F,$0B,$00,$0A
        db $04,$9F,$02,$0E,$0E,$0A,$08,$04
        db $1F,$0C,$0E,$14,$0D,$13,$00,$08
        db $0D,$9F,$05,$0E,$11,$04,$12,$13
        db $9F,$02,$07,$0E,$02,$0E,$0B,$00
        db $13,$04,$9F,$02,$07,$0E,$02,$0E
        db $1C,$06,$07,$0E,$12,$13,$1F,$07
        db $0E,$14,$12,$04,$9F,$12,$14,$0D
        db $0A,$04,$0D,$1F,$06,$07,$0E,$12
        db $13,$1F,$12,$07,$08,$0F,$9F,$15
        db $00,$0B,$0B,$04,$18,$9F,$01,$00
        db $02,$0A,$1F,$03,$0E,$0E,$11,$9F
        db $05,$11,$0E,$0D,$13,$1F,$03,$0E
        db $0E,$11,$9F,$06,$0D,$00,$11,$0B
        db $18,$9F,$13,$14,$01,$14,$0B,$00
        db $11,$9F,$16,$00,$18,$1F,$02,$0E
        db $0E,$0B,$9F,$07,$0E,$14,$12,$04
        db $9F,$08,$12,$0B,$00,$0D,$03,$9F
        db $12,$16,$08,$13,$02,$07,$1F,$0F
        db $00,$0B,$00,$02,$04,$9F,$02,$00
        db $12,$13,$0B,$04,$9F,$0F,$0B,$00
        db $08,$0D,$12,$9F,$06,$07,$0E,$12
        db $13,$1F,$07,$0E,$14,$12,$04,$9F
        db $12,$04,$02,$11,$04,$13,$9F,$03
        db $0E,$0C,$04,$9F,$05,$0E,$11,$13
        db $11,$04,$12,$12,$9F,$0E,$05,$32
        db $33,$34,$35,$36,$37,$0E,$0D,$9F
        db $0E,$05,$1F,$01,$0E,$16,$12,$04
        db $11,$9F,$11,$0E,$00,$03,$9F,$16
        db $0E,$11,$0B,$03,$9F,$00,$16,$04
        db $12,$0E,$0C,$04,$9F,$E4,$E5,$E6
        db $E7,$E8,$0F,$00,$0B,$00,$02,$84
        db $00,$11,$04,$80,$06,$11,$0E,$0E
        db $15,$98,$0C,$0E,$0D,$03,$8E,$0E
        db $14,$13,$11,$00,$06,$04,$0E,$14
        db $92,$05,$14,$0D,$0A,$98,$07,$0E
        db $14,$12,$84,$9F

DATA_049C91:
        db $CB,$01,$00,$00,$08,$00,$0D,$00
        db $17,$00,$23,$00,$2E,$00,$3A,$00
        db $43,$00,$4E,$00,$59,$00,$5F,$00
        db $65,$00,$75,$00,$7D,$00,$83,$00
        db $87,$00,$8C,$00,$9A,$00,$A8,$00
        db $B2,$00,$C2,$00,$C9,$00,$D3,$00
        db $E5,$00,$F7,$00,$FE,$00,$08,$01
        db $13,$01,$1A,$01,$22,$01

DATA_049CCF:
        db $CB,$01,$2B,$01,$31,$01,$38,$01
        db $46,$01,$4D,$01,$54,$01,$60,$01
        db $67,$01,$6C,$01,$75,$01,$80,$01
        db $8A,$01,$8F,$01,$95,$01

DATA_049CED:
        db $CB,$01,$9D,$01,$9E,$01,$9F,$01
        db $A0,$01,$A1,$01,$A2,$01,$A8,$01
        db $AC,$01,$B2,$01,$B7,$01,$C1,$01
        db $C6,$01

CODE_049D07:
        LDA.l $7F837B
        TAX                                     ;$049D0B        |
        CLC                                     ;$049D0C        |
        ADC.w #$0026                            ;$049D0D        |
        STA $02                                 ;$049D10        |
        CLC                                     ;$049D12        |
        ADC.w #$0004                            ;$049D13        |
        STA.l $7F837B                           ;$049D16        |
        LDA.w #$2500                            ;$049D1A        |
        STA.l $7F837F,X                         ;$049D1D        |
        LDA.w #$8B50                            ;$049D21        |
        STA.l $7F837D,X                         ;$049D24        |
        LDA $01                                 ;$049D28        |
        AND.w #$007F                            ;$049D2A        |
        ASL                                     ;$049D2D        |
        TAY                                     ;$049D2E        |
        LDA.w DATA_049C91,Y                     ;$049D2F        |
        TAY                                     ;$049D32        |
        SEP #$20                                ;$049D33        |
        LDA.w LevelNameStrings,Y                ;$049D35        |
        BMI CODE_049D3D                         ;$049D38        |
        JSR CODE_049D7F                         ;$049D3A        |
CODE_049D3D:
        REP #$20
        LDA $00                                 ;$049D3F        |
        AND.w #$00F0                            ;$049D41        |
        LSR                                     ;$049D44        |
        LSR                                     ;$049D45        |
        LSR                                     ;$049D46        |
        TAY                                     ;$049D47        |
        LDA.w DATA_049CCF,Y                     ;$049D48        |
        TAY                                     ;$049D4B        |
        SEP #$20                                ;$049D4C        |
        LDA.w LevelNameStrings,Y                ;$049D4E        |
        CMP.b #$9F                              ;$049D51        |
        BEQ CODE_049D58                         ;$049D53        |
        JSR CODE_049D7F                         ;$049D55        |
CODE_049D58:
        REP #$20
        LDA $00                                 ;$049D5A        |
        AND.w #$000F                            ;$049D5C        |
        ASL                                     ;$049D5F        |
        TAY                                     ;$049D60        |
        LDA.w DATA_049CED,Y                     ;$049D61        |
        TAY                                     ;$049D64        |
        SEP #$20                                ;$049D65        |
        JSR CODE_049D7F                         ;$049D67        |
CODE_049D6A:
        CPX $02
        BCS CODE_049D76                         ;$049D6C        |
        LDY.w #$01CB                            ;$049D6E        |
        JSR CODE_049D7F                         ;$049D71        |
        BRA CODE_049D6A                         ;$049D74        |

CODE_049D76:
        LDA.b #$FF
        STA.l $7F8381,X                         ;$049D78        |
        REP #$20                                ;$049D7C        |
        RTS                                     ;$049D7E        |

CODE_049D7F:
        LDA.w LevelNameStrings,Y
        PHP                                     ;$049D82        |
        CPX $02                                 ;$049D83        |
        BCS CODE_049D95                         ;$049D85        |
        AND.b #$7F                              ;$049D87        |
        STA.l $7F8381,X                         ;$049D89        |
        LDA.b #$39                              ;$049D8D        |
        STA.l $7F8382,X                         ;$049D8F        |
        INX                                     ;$049D93        |
        INX                                     ;$049D94        |
CODE_049D95:
        INY
        PLP                                     ;$049D96        |
        BPL CODE_049D7F                         ;$049D97        |
        RTS                                     ;$049D99        |

CODE_049D9A:
        LDA.w $0DB2
        BEQ CODE_049DAF                         ;$049D9D        |
        LDA.w $0DB3                             ;$049D9F        |
        EOR.b #$01                              ;$049DA2        |
        TAX                                     ;$049DA4        |
        LDA.w $0DB4,X                           ;$049DA5        |
        BMI CODE_049DAF                         ;$049DA8        |
        LDA.w $0DD5                             ;$049DAA        |
        BNE CODE_049DBC                         ;$049DAD        |
CODE_049DAF:
        LDA.b #$03
        STA.w $13D9                             ;$049DB1        |
        STZ.w $0DD5                             ;$049DB4        |
        REP #$30                                ;$049DB7        |
        JMP CODE_049831                         ;$049DB9        |

CODE_049DBC:
        DEC.w $0DB1
        BPL CODE_049DCC                         ;$049DBF        |
        LDA.b #$02                              ;$049DC1        |
        STA.w $0DB1                             ;$049DC3        |
        STZ.w $0DD5                             ;$049DC6        |
        INC.w $13D9                             ;$049DC9        |
CODE_049DCC:
        REP #$30
        JMP CODE_049831                         ;$049DCE        |

CODE_049DD1:
        LDA.w $0DB3
        EOR.b #$01                              ;$049DD4        |
        STA.w $0DB3                             ;$049DD6        |
        TAX                                     ;$049DD9        |
        LDA.w $0DB6,X                           ;$049DDA        |
        STA.w $0DBF                             ;$049DDD        |
        LDA.w $0DB4,X                           ;$049DE0        |
        STA.w $0DBE                             ;$049DE3        |
        LDA.w $0DB8,X                           ;$049DE6        |
        STA $19                                 ;$049DE9        |
        LDA.w $0DBA,X                           ;$049DEB        |
        STA.w $0DC1                             ;$049DEE        |
        STA.w $13C7                             ;$049DF1        |
        STA.w $187A                             ;$049DF4        |
        LDA.w $0DBC,X                           ;$049DF7        |
        STA.w $0DC2                             ;$049DFA        |
        JSL CODE_05DBF2                         ;$049DFD        |
        REP #$20                                ;$049E01        |
        JSR CODE_048E55                         ;$049E03        |
        SEP #$20                                ;$049E06        |
        LDX.w $0DB3                             ;$049E08        |
        LDA.w $1F11,X                           ;$049E0B        |
        STA.w $13C3                             ;$049E0E        |
        STZ.w $13C4                             ;$049E11        |
        LDA.b #$02                              ;$049E14        |
        STA.w $0DB1                             ;$049E16        |
        LDA.b #$0A                              ;$049E19        |
        STA.w $13D9                             ;$049E1B        |
        INC.w $0DD8                             ;$049E1E        |
        RTS                                     ;$049E21        |

CODE_049E22:
        DEC.w $0DB1
        BPL Return049E4B                        ;$049E25        |
        LDA.b #$02                              ;$049E27        |
        STA.w $0DB1                             ;$049E29        |
        LDX.w $0DAF                             ;$049E2C        |
        LDA.w $0DAE                             ;$049E2F        |
        CLC                                     ;$049E32        |
        ADC.l DATA_009F2F,X                     ;$049E33        |
        STA.w $0DAE                             ;$049E37        |
        CMP.l DATA_009F33,X                     ;$049E3A        |
        BNE Return049E4B                        ;$049E3E        |
        INC.w $13D9                             ;$049E40        |
        LDA.w $0DAF                             ;$049E43        |
        EOR.b #$01                              ;$049E46        |
        STA.w $0DAF                             ;$049E48        |
Return049E4B:
        RTS

CODE_049E4C:
        LDA.b #$03
        STA.w $13D9                             ;$049E4E        |
        RTS                                     ;$049E51        |

CODE_049E52:
        LDA.w $1DF7
        BNE CODE_049E63                         ;$049E55        |
        INC.w $1DF8                             ;$049E57        |
        LDA.w $1DF8                             ;$049E5A        |
        CMP.b #$31                              ;$049E5D        |
        BNE CODE_049E93                         ;$049E5F        |
        BRA CODE_049E69                         ;$049E61        |

CODE_049E63:
        LDA $13
        AND.b #$07                              ;$049E65        |
        BNE CODE_049E78                         ;$049E67        |
CODE_049E69:
        INC.w $1DF7
        LDA.w $1DF7                             ;$049E6C        |
        CMP.b #$05                              ;$049E6F        |
        BNE CODE_049E78                         ;$049E71        |
        LDA.b #$04                              ;$049E73        |
        STA.w $1DF7                             ;$049E75        |
CODE_049E78:
        REP #$20
        LDA.w $1DF7                             ;$049E7A        |
        AND.w #$00FF                            ;$049E7D        |
        STA $00                                 ;$049E80        |
        LDX.w $0DD6                             ;$049E82        |
        LDA.w $1F19,X                           ;$049E85        |
        SEC                                     ;$049E88        |
        SBC $00                                 ;$049E89        |
        STA.w $1F19,X                           ;$049E8B        |
        SEC                                     ;$049E8E        |
        SBC $1C                                 ;$049E8F        |
        BMI CODE_049E96                         ;$049E91        |
CODE_049E93:
        SEP #$20
        RTS                                     ;$049E95        |

CODE_049E96:
        SEP #$20
        JMP CODE_04918D                         ;$049E98        |

        LDY.b #$00                              ;$049E9B        |
ADDR_049E9D:
        CMP.b #$0A
        BCC Return049EA6                        ;$049E9F        |
        SBC.b #$0A                              ;$049EA1        |
        INY                                     ;$049EA3        |
        BRA ADDR_049E9D                         ;$049EA4        |

Return049EA6:
        RTS

DATA_049EA7:
        db $10,$F8,$10,$00,$10,$FC,$10,$00
        db $10,$FC,$10,$00,$08,$FC,$0C,$F4
        db $FC,$04,$04,$FC,$F8,$10,$00,$10
        db $FC,$08,$FC,$08,$FC,$10,$00,$10
        db $F8,$04,$FC,$10,$00,$10,$10,$08
        db $10,$04,$10,$04,$08,$04,$0C,$0C
        db $04,$04,$04,$04,$08,$10,$FC,$F8
        db $FC,$F8,$04,$10,$F8,$FC,$04,$10
        db $F4,$F4,$0C,$F4,$10,$00,$00,$10
        db $00,$10,$10,$00,$10,$00,$FC,$08
        db $FC,$08,$00,$10,$10,$FC,$10,$FC
        db $FC,$04,$04,$FC,$F8,$10,$00,$10
        db $FC,$10,$10,$04,$10,$00,$04,$10
        db $04,$04,$FC,$F8,$04,$04,$10,$08
        db $0C,$F4,$00,$10,$FC,$10,$10,$00
        db $04,$10,$10,$F8,$00,$10,$00,$10
        db $FC,$10,$10,$00,$00,$10,$00,$10
        db $00,$10,$00,$10,$00,$10,$00,$10
        db $04,$FC,$04,$04,$04,$04,$00,$10
        db $00,$10,$10,$00,$10,$00,$FC,$10
        db $FC,$04

DATA_049F49:
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $01,$00,$01,$00,$00,$01,$00,$01
        db $00,$01,$00,$01,$01,$00,$01,$00
        db $00,$01,$01,$00,$01,$00,$01,$00
        db $00,$01,$01,$00,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$00,$01
        db $00,$01,$01,$00,$00,$01,$01,$00
        db $00,$01,$01,$00,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$00,$01
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $00,$01,$00,$01,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $01,$00,$00,$01,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $00,$01,$01,$00,$01,$00,$01,$00
        db $01,$00,$01,$00,$01,$00,$01,$00
        db $00,$01

DATA_049FEB:
        db $04,$04,$04,$04,$04,$04,$04,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $04,$00,$00,$04,$04,$04,$04,$00
        db $00,$00,$00,$00,$00,$00,$04,$00
        db $00,$00,$04,$00,$00,$04,$04,$08
        db $08,$08,$0C,$0C,$08,$08,$08,$08
        db $08,$0C,$0C,$08,$08,$08,$08,$0C
        db $08,$08,$08,$0C,$08,$0C,$14,$14
        db $14,$04,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$04,$04,$08
        db $00

DATA_04A03C:
        db $07,$09,$0A,$0D,$0E,$11,$17,$19
        db $1A,$1C,$1D,$1F,$28,$29,$2D,$2E
        db $35,$36,$37,$49,$4A,$4B,$4D,$51
DATA_04A054:
        db $08,$FC,$FC,$08,$FC,$08,$FC,$08
        db $FC,$08,$04,$00,$08,$04,$04,$08
        db $04,$08,$04,$00,$04,$08,$04,$00
        db $FC,$08,$00,$00,$FC,$08,$FC,$08
        db $04,$00,$04,$00,$00,$00,$08,$FC
        db $08,$04,$08,$04,$FC,$08,$08,$FC
DATA_04A084:
        db $04,$00

DATA_04A086:
        db $F8,$FF,$08,$00,$FC,$FF,$F8,$FF
        db $04,$00,$F8,$FF,$04,$00,$08,$00
        db $FC,$FF,$04,$00,$04,$00,$04,$00
        db $08,$00,$08,$00,$04,$00,$F8,$FF
        db $FC,$FF,$00,$00,$00,$00,$08,$00
        db $04,$00,$04,$00,$04,$00,$F8,$FF
        db $04,$00,$04,$00,$04,$00,$08,$00
        db $FC,$FF,$F8,$FF,$04,$00,$04,$00
        db $04,$00,$00,$00,$00,$00,$04,$00
        db $04,$00,$04,$00,$F8,$FF,$04,$00
        db $08,$00,$FC,$FF,$F8,$FF,$F8,$FF
        db $04,$00,$FC,$FF,$08,$00

DATA_04A0E4:
        db $02,$02,$02,$02,$02,$00,$02,$02
        db $02,$00,$02,$00,$02,$00,$02,$02
        db $00,$00,$00,$02,$02,$02,$02,$02
LevelNames:
        db $00,$00,$72,$0D,$73,$0D,$00,$0C
        db $60,$0A,$53,$0A,$54,$0A,$40,$04
        db $30,$0B,$52,$0A,$71,$0A,$90,$0D
        db $01,$11,$02,$11,$40,$06,$07,$12
        db $00,$14,$00,$13,$C0,$02,$7C,$0A
        db $33,$0E,$51,$0A,$C0,$02,$53,$04
        db $00,$18,$53,$04,$40,$08,$90,$16
        db $25,$16,$24,$16,$C0,$02,$90,$15
        db $40,$07,$00,$17,$21,$16,$23,$16
        db $22,$16,$40,$03,$24,$01,$23,$01
        db $10,$01,$21,$01,$22,$01,$60,$0D
        db $C0,$02,$71,$0D,$83,$0D,$72,$0A
        db $C0,$02,$00,$1B,$00,$1A,$B4,$19
        db $40,$09,$90,$19,$00,$00,$B3,$19
        db $60,$19,$B2,$19,$B1,$19,$70,$16
        db $82,$0D,$84,$0D,$81,$0D,$30,$0F
        db $40,$05,$60,$15,$A1,$15,$A4,$15
        db $A2,$15,$30,$10,$77,$15,$A3,$15
        db $C0,$02,$0B,$00,$0A,$00,$09,$00
        db $08,$00,$C0,$02,$00,$1C,$00,$1D
        db $00,$1E,$E0,$00,$C0,$02,$C0,$02
        db $D2,$02,$C0,$02,$D3,$02,$C0,$02
        db $D1,$02,$D4,$02,$D5,$02,$C0,$02
        db $C0,$02,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF

DATA_04A400:
        db $50,$00,$41,$3E,$FE,$38,$50,$A0
        db $C0,$28,$FE,$38,$50,$A1,$C0,$28
        db $FE,$38,$50,$BE,$C0,$28,$FE,$38
        db $50,$BF,$C0,$28,$FE,$38,$53,$40
        db $41,$7E,$FE,$38,$50,$A2,$00,$01
        db $92,$3C,$50,$A3,$40,$32,$93,$3C
        db $50,$BD,$00,$01,$92,$7C,$50,$C2
        db $C0,$24,$94,$7C,$50,$DD,$C0,$24
        db $94,$3C,$53,$22,$00,$01,$92,$BC
        db $53,$23,$40,$32,$93,$BC,$53,$3D
        db $00,$01,$92,$FC,$50,$FE,$C0,$24
        db $D6,$2C,$53,$44,$40,$32,$D5,$2C
        db $50,$DE,$00,$01,$D4,$2C,$53,$43
        db $00,$01,$D4,$EC,$53,$5E,$00,$01
        db $D4,$AC,$50,$02,$00,$01,$95,$38
        db $50,$09,$00,$01,$97,$38,$50,$0E
        db $00,$01,$96,$38,$50,$33,$00,$01
        db $97,$38,$50,$37,$00,$01,$95,$38
        db $50,$3B,$00,$01,$96,$38,$50,$42
        db $00,$01,$96,$38,$50,$50,$00,$01
        db $95,$38,$50,$55,$00,$01,$96,$38
        db $50,$5E,$00,$01,$95,$38,$51,$01
        db $00,$01,$97,$38,$51,$5F,$00,$01
        db $96,$38,$51,$81,$00,$01,$95,$38
        db $51,$C0,$00,$01,$96,$38,$51,$FF
        db $00,$01,$97,$38,$52,$60,$00,$01
        db $95,$38,$52,$7F,$00,$01,$95,$38
        db $53,$00,$00,$01,$97,$38,$53,$1F
        db $00,$01,$96,$38,$53,$61,$00,$01
        db $95,$38,$53,$6A,$00,$01,$95,$38
        db $53,$73,$00,$01,$96,$38,$53,$76
        db $00,$01,$95,$38,$53,$86,$00,$01
        db $96,$38,$53,$91,$00,$01,$95,$38
        db $53,$9A,$00,$01,$97,$38,$53,$9E
        db $00,$01,$95,$38,$50,$23,$C0,$06
        db $FC,$2C,$50,$24,$C0,$06,$FC,$2C
        db $50,$25,$C0,$06,$FC,$2C,$50,$26
        db $C0,$06,$FC,$2C,$50,$87,$00,$01
        db $8F,$38,$FF,$9B,$75,$81,$20,$01
        db $76,$20,$9B,$75,$81,$20,$01,$76
        db $20,$9A,$75,$00,$10,$81,$20,$01
        db $76,$20,$94,$75,$00,$01,$81,$02
        db $81,$01,$05,$02,$11,$50,$20,$7D
        db $20,$92,$75,$02,$10,$03,$11,$81
        db $71,$81,$11,$81,$71,$03,$11,$43
        db $10,$9C,$91,$75,$01,$10,$11,$89
        db $71,$01,$11,$10,$89,$75,$04,$01
        db $02,$03,$02,$01,$82,$75,$01,$3D
        db $71,$83,$AD,$81,$8A,$81,$AD,$81
        db $8A,$01,$11,$10,$89,$75,$00,$3D
        db $82,$71,$00,$3D,$82,$75,$01,$3D
        db $71,$83,$AD,$81,$8A,$81,$AD,$81
        db $8A,$01,$3D,$3F,$89,$75,$00,$00
        db $81,$43,$01,$42,$40,$81,$75,$01
        db $10,$00,$83,$43,$00,$11,$85,$71
        db $01,$11,$10,$88,$75,$01,$11,$20
        db $82,$69,$03,$20,$11,$75,$3D,$81
        db $20,$82,$69,$00,$00,$81,$43,$00
        db $11,$83,$71,$00,$3D,$88,$75,$01
        db $11,$50,$81,$69,$04,$41,$42,$11
        db $75,$3D,$81,$20,$81,$69,$01,$20
        db $69,$81,$20,$00,$50,$83,$43,$00
        db $10,$89,$75,$00,$11,$81,$43,$00
        db $11,$82,$75,$02,$3D,$50,$20,$82
        db $69,$81,$20,$01,$69,$20,$82,$69
        db $01,$20,$76,$86,$75,$01,$54,$55
        db $87,$75,$01,$00,$11,$83,$43,$00
        db $50,$81,$20,$83,$69,$01,$20,$76
        db $86,$75,$03,$9E,$9F,$06,$05,$85
        db $03,$01,$20,$50,$83,$43,$00,$11
        db $81,$43,$00,$50,$82,$69,$01,$20
        db $7D,$84,$75,$04,$01,$02,$9E,$9F
        db $58,$81,$71,$02,$BA,$BD,$BF,$81
        db $71,$81,$20,$83,$69,$03,$50,$11
        db $71,$11,$82,$43,$01,$9C,$10,$84
        db $75,$0E,$3D,$71,$9E,$9F,$71,$58
        db $71,$BD,$BF,$BA,$71,$11,$20,$69
        db $20,$83,$69,$00,$50,$83,$43,$02
        db $10,$9C,$43,$84,$75,$04,$3D,$58
        db $9E,$9F,$71,$81,$58,$06,$BF,$71
        db $BD,$71,$11,$50,$20,$84,$69,$00
        db $20,$82,$69,$03,$20,$76,$20,$69
        db $83,$75,$05,$10,$11,$58,$9E,$9F
        db $58,$81,$71,$07,$58,$BA,$BD,$BF
        db $71,$11,$50,$20,$84,$69,$00,$20
        db $81,$69,$03,$20,$76,$20,$69,$82
        db $75,$06,$10,$11,$56,$57,$9E,$9F
        db $58,$82,$71,$02,$BD,$71,$BA,$81
        db $71,$81,$58,$04,$43,$58,$43,$50
        db $20,$82,$69,$03,$20,$76,$20,$69
        db $82,$75,$05,$3D,$58,$9E,$9F,$64
        db $65,$84,$71,$81,$BD,$00,$BF,$83
        db $58,$04,$71,$58,$11,$50,$20,$81
        db $69,$03,$20,$76,$20,$69,$82,$75
        db $03,$3D,$71,$64,$65,$81,$71,$00
        db $6E,$81,$6B,$05,$6E,$BD,$BF,$BA
        db $BD,$58,$81,$8A,$01,$AD,$8E,$81
        db $58,$07,$11,$43,$BC,$3D,$20,$7D
        db $20,$69,$82,$75,$01,$00,$11,$81
        db $71,$01,$AE,$BC,$83,$68,$04,$BA
        db $BD,$11,$43,$11,$81,$8A,$09,$AD
        db $8A,$8F,$53,$52,$71,$BC,$3D,$43
        db $3F,$81,$43,$82,$75,$06,$20,$50
        db $11,$8F,$9B,$71,$6E,$81,$6B,$05
        db $6E,$11,$43,$00,$69,$00,$81,$43
        db $08,$58,$8F,$9B,$63,$62,$71,$BC
        db $71,$10,$82,$3F,$82,$75,$02,$20
        db $50,$11,$81,$AC,$01,$58,$11,$82
        db $43,$04,$00,$69,$50,$43,$50,$81
        db $20,$04,$50,$58,$9B,$8F,$6C,$81
        db $68,$01,$6C,$3D,$82,$3F,$82,$75
        db $02,$00,$11,$58,$81,$AC,$09,$11
        db $50,$20,$69,$20,$50,$43,$11,$3F
        db $11,$81,$43,$03,$50,$3D,$8A,$BC
        db $83,$68,$00,$6C,$82,$03,$81,$75
        db $03,$10,$11,$56,$57,$81,$AC,$01
        db $3D,$50,$82,$43,$00,$11,$85,$3F
        db $03,$10,$11,$8A,$BC,$84,$68,$81
        db $71,$00,$43,$81,$75,$03,$3D,$58
        db $64,$65,$81,$8A,$01,$11,$10,$87
        db $3F,$03,$10,$03,$52,$53,$81,$71
        db $00,$6C,$82,$68,$03,$6C,$11,$00
        db $69,$81,$75,$03,$3D,$71,$56,$57
        db $81,$8A,$01,$58,$3D,$86,$3F,$00
        db $10,$81,$8F,$0B,$62,$63,$52,$53
        db $71,$52,$53,$71,$11,$50,$69,$20
        db $81,$75,$03,$00,$11,$64,$65,$81
        db $AC,$02,$11,$00,$11,$84,$3F,$0F
        db $10,$52,$53,$71,$8E,$71,$62,$63
        db $52,$51,$63,$11,$50,$69,$20,$69
        db $81,$75,$03,$20,$3D,$71,$58,$81
        db $AC,$02,$3D,$50,$11,$84,$3F,$04
        db $3D,$62,$63,$71,$8E,$82,$71,$03
        db $62,$63,$42,$41,$82,$69,$00,$20
        db $81,$75,$03,$20,$3D,$58,$71,$81
        db $AC,$00,$3D,$83,$3F,$00,$10,$81
        db $03,$0A,$11,$52,$53,$52,$53,$71
        db $52,$53,$11,$50,$20,$82,$69,$07
        db $50,$43,$75,$11,$20,$00,$11,$71
        db $81,$AC,$01,$11,$10,$82,$3F,$00
        db $3D,$81,$71,$09,$52,$51,$63,$62
        db $63,$52,$51,$63,$3A,$20,$82,$69
        db $03,$50,$11,$75,$20,$9E,$75,$00
        db $20,$9E,$75,$01,$20,$10,$95,$75
        db $03,$E2,$E5,$F5,$F6,$83,$75,$02
        db $50,$11,$10,$90,$75,$07,$01,$02
        db $03,$05,$84,$32,$33,$C4,$83,$75
        db $03,$11,$71,$11,$10,$8D,$75,$02
        db $01,$02,$11,$82,$71,$04,$35,$36
        db $37,$38,$01,$82,$75,$01,$10,$03
        db $81,$11,$00,$10,$8B,$75,$01,$10
        db $11,$84,$71,$05,$49,$4A,$59,$5A
        db $11,$10,$81,$75,$81,$3F,$02,$10
        db $71,$3D,$8B,$75,$02,$3D,$AD,$5D
        db $84,$68,$00,$5D,$82,$71,$00,$3D
        db $81,$75,$82,$3F,$81,$3D,$8B,$75
        db $01,$3D,$AD,$86,$68,$81,$71,$01
        db $11,$00,$81,$75,$81,$3F,$02,$10
        db $11,$00,$87,$75,$01,$01,$02,$81
        db $03,$02,$00,$11,$5D,$84,$68,$04
        db $5D,$71,$11,$50,$20,$81,$75,$05
        db $3F,$10,$11,$50,$20,$10,$85,$75
        db $01,$10,$11,$82,$71,$04,$20,$50
        db $44,$43,$44,$81,$43,$05,$44,$43
        db $42,$40,$69,$20,$81,$75,$05,$9C
        db $43,$50,$69,$20,$3D,$85,$A4,$01
        db $3D,$AD,$81,$8A,$03,$11,$20,$69
        db $20,$87,$69,$81,$20,$81,$75,$81
        db $20,$81,$69,$01,$50,$3D,$81,$B4
        db $01,$B5,$A5,$81,$B4,$01,$3D,$AD
        db $81,$8A,$02,$11,$50,$20,$87,$69
        db $0A,$20,$69,$20,$10,$75,$20,$69
        db $20,$50,$11,$4D,$85,$75,$01,$4D
        db $71,$81,$AC,$03,$71,$11,$50,$20
        db $87,$69,$81,$20,$01,$11,$10,$81
        db $20,$00,$50,$81,$11,$01,$00,$02
        db $82,$03,$05,$02,$01,$3D,$71,$8F
        db $9B,$81,$71,$01,$11,$44,$81,$43
        db $00,$60,$83,$69,$04,$20,$69,$20
        db $71,$3D,$81,$43,$81,$11,$02,$50
        db $20,$11,$82,$43,$81,$11,$03,$00
        db $11,$71,$AE,$83,$BC,$02,$AE,$11
        db $00,$84,$69,$0A,$20,$50,$58,$4D
        db $43,$11,$71,$3D,$69,$20,$41,$82
        db $69,$07,$41,$42,$20,$41,$42,$44
        db $43,$44,$81,$43,$02,$44,$50,$20
        db $83,$69,$0B,$20,$50,$11,$71,$3D
        db $20,$50,$43,$00,$69,$20,$42,$82
        db $43,$02,$42,$41,$20,$81,$69,$00
        db $20,$84,$69,$81,$20,$82,$69,$0B
        db $41,$42,$11,$58,$71,$4D,$69,$20
        db $69,$20,$69,$20,$85,$73,$02,$20
        db $69,$20,$84,$69,$02,$20,$69,$20
        db $82,$43,$00,$11,$81,$58,$03,$71
        db $58,$3D,$20,$81,$69,$03,$20,$69
        db $50,$11,$83,$3F,$01,$11,$20,$81
        db $69,$00,$20,$84,$69,$02,$20,$50
        db $58,$81,$AC,$81,$89,$81,$58,$07
        db $11,$00,$69,$20,$69,$20,$50,$11
        db $84,$3F,$03,$11,$50,$69,$20,$84
        db $69,$01,$20,$50,$81,$89,$81,$AC
        db $81,$99,$81,$89,$00,$3D,$81,$20
        db $81,$69,$01,$20,$11,$86,$3F,$04
        db $11,$42,$41,$20,$60,$83,$43,$00
        db $11,$81,$99,$81,$AC,$81,$89,$81
        db $99,$06,$3D,$20,$43,$50,$69,$50
        db $11,$88,$3F,$03,$11,$43,$3D,$71
        db $81,$89,$01,$71,$58,$81,$89,$81
        db $8F,$09,$99,$98,$89,$71,$3D,$20
        db $3F,$11,$43,$11,$8A,$3F,$02,$10
        db $11,$58,$81,$99,$81,$89,$01,$99
        db $98,$82,$89,$81,$99,$02,$58,$3D
        db $50,$82,$3F,$81,$10,$83,$3F,$81
        db $10,$82,$3F,$01,$10,$11,$81,$89
        db $04,$58,$89,$98,$99,$89,$82,$98
        db $00,$99,$81,$89,$02,$58,$4D,$11
        db $82,$03,$02,$11,$00,$11,$81,$3F
        db $00,$10,$81,$11,$82,$03,$04,$11
        db $58,$99,$98,$89,$81,$99,$00,$89
        db $83,$98,$00,$89,$81,$99,$02,$71
        db $4D,$75,$82,$43,$81,$50,$02,$11
        db $3F,$9C,$82,$43,$02,$11,$71,$58
        db $82,$89,$01,$98,$99,$81,$89,$85
        db $99,$00,$58,$81,$89,$01,$11,$10
        db $81,$69,$81,$20,$82,$76,$00,$20
        db $81,$69,$03,$20,$50,$11,$71,$82
        db $99,$03,$98,$89,$99,$98,$86,$89
        db $81,$99,$01,$58,$3D,$81,$69,$81
        db $20,$82,$76,$00,$20,$82,$69,$03
        db $20,$41,$42,$11,$81,$89,$81,$99
        db $01,$89,$98,$81,$99,$81,$98,$82
        db $99,$81,$89,$01,$58,$3D,$81,$69
        db $81,$20,$82,$7D,$00,$20,$81,$69
        db $00,$20,$82,$69,$00,$3D,$81,$99
        db $81,$89,$01,$99,$98,$81,$89,$81
        db $98,$06,$89,$3B,$89,$98,$99,$11
        db $00,$81,$69,$05,$20,$50,$11,$3F
        db $11,$20,$82,$69,$00,$20,$81,$69
        db $06,$3D,$71,$58,$99,$98,$89,$99
        db $83,$98,$01,$99,$89,$81,$98,$02
        db $89,$3D,$20,$82,$43,$00,$11,$81
        db $3F,$00,$11,$83,$43,$03,$50,$41
        db $42,$11,$82,$89,$82,$98,$82,$99
        db $01,$98,$89,$83,$99,$01,$3D,$20
        db $87,$75,$04,$08,$07,$06,$05,$11
        db $81,$58,$84,$99,$00,$98,$82,$89
        db $81,$99,$81,$89,$09,$58,$71,$3D
        db $20,$75,$11,$50,$20,$3D,$71,$81
        db $AC,$01,$71,$11,$82,$03,$00,$11
        db $81,$71,$01,$62,$63,$82,$71,$08
        db $62,$63,$11,$2A,$69,$20,$69,$50
        db $11,$83,$75,$05,$11,$20,$00,$11
        db $8F,$9B,$84,$71,$00,$5D,$81,$68
        db $00,$5D,$82,$71,$03,$58,$71,$11
        db $50,$81,$20,$02,$41,$42,$11,$85
        db $75,$06,$00,$43,$23,$30,$AE,$AF
        db $AD,$81,$8A,$01,$71,$5D,$81,$68
        db $00,$5D,$83,$71,$05,$11,$50,$20
        db $69,$2A,$11,$86,$75,$01,$10,$11
        db $81,$71,$03,$11,$30,$8E,$AD,$81
        db $8A,$01,$52,$53,$81,$71,$81,$58
        db $03,$71,$58,$11,$50,$81,$69,$01
        db $20,$3A,$81,$75,$01,$A6,$A7,$83
        db $75,$01,$00,$11,$81,$71,$03,$11
        db $00,$52,$53,$81,$AC,$02,$62,$63
        db $71,$81,$58,$03,$11,$43,$42,$41
        db $81,$69,$08,$20,$50,$11,$A6,$A7
        db $B6,$B7,$A6,$A7,$81,$75,$01,$20
        db $50,$81,$43,$03,$50,$20,$62,$63
        db $81,$AC,$00,$71,$81,$58,$03,$71
        db $11,$50,$20,$83,$69,$04,$50,$11
        db $75,$B6,$B7,$81,$3F,$01,$B6,$B7
        db $81,$75,$01,$20,$69,$81,$3E,$0C
        db $69,$20,$42,$44,$43,$44,$43,$44
        db $43,$42,$41,$69,$20,$82,$69,$03
        db $50,$11,$A6,$A7,$85,$3F,$81,$75
        db $01,$20,$69,$81,$3E,$00,$69,$82
        db $20,$84,$69,$00,$20,$81,$69,$00
        db $20,$81,$69,$04,$50,$11,$75,$B6
        db $B7,$85,$3F,$81,$75,$01,$20,$69
        db $81,$3E,$03,$69,$20,$69,$20,$83
        db $69,$00,$20,$82,$69,$05,$20,$41
        db $42,$11,$A6,$A7,$87,$3F,$81,$75
        db $01,$20,$69,$81,$3E,$00,$69,$81
        db $20,$85,$69,$04,$20,$69,$50,$43
        db $11,$81,$75,$01,$B6,$B7,$87,$3F
        db $81,$75,$01,$20,$69,$81,$3E,$03
        db $69,$20,$41,$20,$83,$69,$03,$20
        db $41,$42,$11,$83,$75,$01,$A6,$A7
        db $87,$3F,$81,$75,$01,$20,$69,$81
        db $3E,$02,$69,$20,$11,$85,$43,$00
        db $11,$85,$75,$01,$B6,$B7,$87,$3F
        db $81,$75,$01,$20,$69,$81,$3E,$08
        db $69,$20,$03,$04,$03,$04,$03,$02
        db $01,$87,$75,$01,$A6,$A7,$86,$3F
        db $03,$75,$10,$20,$C2,$81,$C3,$03
        db $C2,$20,$56,$57,$82,$71,$02,$56
        db $57,$10,$86,$75,$03,$B6,$B7,$A6
        db $A7,$83,$3F,$04,$A6,$75,$4D,$50
        db $D2,$81,$D3,$03,$D2,$50,$9E,$9F
        db $82,$71,$02,$9E,$9F,$3D,$88,$75
        db $0A,$B6,$B7,$3F,$A6,$A7,$3F,$B6
        db $75,$3D,$11,$20,$81,$3E,$03,$20
        db $11,$9E,$9F,$82,$71,$02,$64,$65
        db $4D,$8B,$75,$01,$B6,$B7,$82,$75
        db $02,$4D,$11,$50,$81,$3E,$05,$50
        db $11,$9E,$9F,$56,$57,$81,$71,$01
        db $58,$3D,$90,$75,$02,$3D,$58,$11
        db $81,$43,$06,$11,$58,$64,$65,$9E
        db $9F,$71,$81,$58,$00,$3D,$83,$75
        db $81,$60,$8A,$75,$00,$00,$81,$43
        db $00,$11,$83,$71,$03,$58,$64,$65
        db $11,$81,$43,$00,$00,$83,$75,$02
        db $3D,$11,$60,$83,$75,$02,$60,$03
        db $60,$82,$75,$81,$20,$01,$69,$3D
        db $86,$71,$00,$3D,$81,$69,$00,$20
        db $83,$75,$00,$60,$81,$11,$00,$60
        db $81,$75,$03,$60,$11,$A6,$A7,$81
        db $03,$00,$75,$81,$20,$01,$69,$00
        db $81,$43,$05,$44,$43,$44,$43,$44
        db $00,$81,$69,$00,$20,$83,$75,$03
        db $20,$3D,$A6,$A7,$81,$03,$06,$11
        db $A6,$A9,$B7,$A6,$A7,$11,$81,$20
        db $00,$69,$81,$20,$84,$69,$81,$20
        db $81,$69,$01,$20,$11,$82,$75,$03
        db $60,$11,$B6,$B7,$82,$71,$08,$B6
        db $A8,$A7,$B6,$A8,$11,$50,$20,$69
        db $81,$20,$84,$69,$81,$20,$81,$69
        db $01,$50,$11,$81,$75,$01,$60,$11
        db $84,$71,$07,$A6,$A7,$B6,$B7,$71
        db $B6,$75,$11,$81,$43,$81,$20,$84
        db $69,$81,$20,$81,$43,$00,$11,$82
        db $75,$02,$60,$11,$58,$83,$71,$02
        db $B6,$B7,$58,$82,$71,$82,$75,$02
        db $11,$50,$20,$84,$69,$02,$20,$50
        db $11,$84,$75,$0C,$20,$3D,$58,$A6
        db $A7,$A6,$A7,$A6,$A7,$A6,$A7,$A6
        db $A7,$83,$75,$00,$11,$86,$43,$00
        db $11,$85,$75,$0C,$60,$11,$A6,$A9
        db $B7,$B6,$B7,$B6,$B7,$B6,$B7,$B6
        db $B7,$92,$75,$04,$60,$11,$B6,$A8
        db $A7,$81,$71,$05,$A6,$A7,$A6,$A7
        db $A6,$A7,$8D,$75,$11,$A6,$A7,$75
        db $A6,$A7,$20,$60,$11,$B6,$A8,$A7
        db $71,$B6,$B7,$B6,$B7,$B6,$B7,$8D
        db $75,$04,$B6,$B7,$A6,$A9,$B7,$81
        db $20,$05,$60,$11,$B6,$B7,$11,$43
        db $81,$11,$81,$43,$00,$11,$8C,$75
        db $05,$A6,$A7,$A6,$A9,$B7,$3F,$82
        db $20,$00,$60,$81,$43,$01,$60,$69
        db $81,$3D,$81,$69,$00,$3D,$89,$75
        db $08,$A6,$A7,$75,$B6,$B7,$B6,$B7
        db $A6,$A7,$83,$20,$81,$69,$01,$20
        db $69,$81,$60,$81,$69,$00,$60,$89
        db $75,$01,$B6,$B7,$84,$75,$02,$B6
        db $B7,$43,$82,$20,$81,$69,$01,$20
        db $69,$81,$20,$81,$69,$00,$20,$86
        db $75,$04,$10,$11,$71,$58,$6E,$82
        db $6B,$83,$AD,$01,$8E,$99,$81,$98
        db $00,$99,$81,$8F,$05,$99,$98,$89
        db $58,$3D,$50,$86,$75,$03,$3D,$71
        db $58,$71,$83,$68,$83,$AD,$01,$8E
        db $89,$81,$98,$00,$89,$81,$AC,$05
        db $89,$98,$99,$11,$00,$11,$86,$75
        db $04,$4D,$58,$71,$58,$5D,$81,$68
        db $00,$5D,$84,$89,$82,$98,$00,$99
        db $81,$AC,$81,$99,$02,$11,$50,$20
        db $87,$75,$03,$3D,$71,$00,$50,$81
        db $43,$81,$71,$87,$99,$02,$71,$9B
        db $8F,$81,$89,$02,$3D,$69,$20,$87
        db $75,$01,$4D,$3D,$81,$50,$81,$20
        db $02,$50,$71,$6E,$82,$6B,$83,$AD
        db $08,$AF,$AE,$89,$98,$99,$3D,$69
        db $20,$11,$86,$75,$03,$00,$11,$10
        db $11,$81,$43,$01,$50,$3D,$83,$68
        db $83,$AD,$0A,$8E,$89,$98,$99,$11
        db $00,$69,$50,$11,$A6,$A7,$84,$75
        db $03,$20,$50,$11,$10,$81,$3F,$02
        db $11,$3D,$5D,$81,$68,$01,$5D,$58
        db $82,$89,$00,$98,$81,$99,$07,$71
        db $3A,$20,$50,$11,$75,$B6,$B7,$84
        db $75,$04,$20,$69,$50,$11,$03,$81
        db $10,$01,$58,$71,$81,$AC,$01,$58
        db $89,$82,$98,$00,$99,$81,$71,$03
        db $11,$2A,$20,$11,$81,$75,$81,$3F
        db $01,$A6,$A7,$81,$75,$01,$11,$20
        db $81,$69,$00,$50,$82,$11,$01,$71
        db $58,$81,$AC,$00,$71,$83,$99,$03
        db $71,$11,$42,$41,$81,$20,$00,$11
        db $81,$75,$81,$3F,$01,$B6,$B7,$81
        db $75,$01,$11,$50,$82,$69,$01,$41
        db $42,$89,$43,$06,$42,$41,$69,$20
        db $69,$50,$11,$81,$75,$81,$3F,$01
        db $A6,$A7,$82,$75,$01,$11,$50,$83
        db $69,$00,$20,$87,$69,$00,$20,$82
        db $69,$02,$20,$2A,$11,$82,$75,$81
        db $3F,$01,$B6,$B7,$83,$75,$00,$60
        db $83,$43,$02,$50,$69,$50,$81,$43
        db $00,$50,$83,$69,$00,$20,$81,$69
        db $01,$20,$3A,$83,$75,$02,$3F,$A6
        db $A7,$84,$75,$00,$3D,$82,$71,$03
        db $AD,$DA,$69,$DA,$81,$8A,$00,$3D
        db $82,$69,$00,$20,$82,$69,$01,$50
        db $11,$83,$75,$02,$A7,$B6,$B7,$84
        db $75,$01,$3D,$58,$81,$71,$03,$AD
        db $DA,$69,$DA,$81,$8A,$00,$3D,$81
        db $69,$07,$50,$43,$50,$41,$42,$10
        db $03,$10,$82,$75,$00,$B7,$81,$75
        db $02,$60,$03,$60,$81,$75,$07,$60
        db $11,$A6,$A7,$58,$3D,$43,$00,$81
        db $43,$00,$00,$81,$43,$07,$00,$43
        db $00,$11,$75,$00,$43,$00,$85,$75
        db $0B,$3D,$71,$11,$03,$60,$20,$3D
        db $B6,$B7,$11,$60,$75,$83,$20,$81
        db $75,$82,$20,$81,$75,$02,$20,$69
        db $20,$85,$75,$0B,$3D,$A6,$A7,$A6
        db $A7,$43,$11,$A6,$A7,$3D,$20,$75
        db $83,$20,$81,$75,$82,$20,$81,$75
        db $02,$20,$69,$20,$82,$75,$00,$60
        db $81,$03,$0B,$A6,$A9,$A8,$A9,$B7
        db $71,$58,$B6,$B7,$3D,$20,$11,$83
        db $20,$01,$11,$75,$82,$20,$05,$75
        db $11,$20,$69,$20,$11,$81,$75,$0F
        db $3D,$A6,$A7,$B6,$B7,$B6,$A8,$A7
        db $A6,$A7,$A6,$A7,$3D,$20,$11,$50
        db $81,$20,$00,$50,$81,$11,$82,$20
        db $81,$11,$03,$50,$69,$50,$11,$81
        db $75,$0F,$11,$B6,$B7,$A6,$A7,$71
        db $B6,$A8,$A9,$B7,$B6,$B7,$11,$60
        db $75,$11,$81,$43,$0A,$11,$75,$11
        db $50,$20,$50,$11,$75,$11,$43,$11
        db $82,$75,$0D,$58,$A6,$A7,$B6,$A8
        db $A7,$A6,$A9,$A8,$A7,$A6,$A7,$71
        db $11,$81,$03,$00,$60,$83,$75,$02
        db $11,$43,$11,$87,$75,$11,$A7,$B6
        db $B7,$71,$B6,$B7,$B6,$B7,$B6,$A8
        db $A9,$A8,$A7,$71,$A6,$A7,$11,$60
        db $8D,$75,$13,$A8,$A7,$A6,$A7,$A6
        db $A7,$A6,$A7,$A6,$A9,$B7,$B6,$A8
        db $A7,$B6,$A8,$A7,$11,$03,$60,$8B
        db $75,$13,$B6,$B7,$B6,$B7,$B6,$B7
        db $B6,$B7,$B6,$B7,$A6,$A7,$B6,$B7
        db $71,$B6,$A8,$A7,$11,$60,$81,$75
        db $01,$A6,$A7,$87,$75,$17,$A6,$A7
        db $A6,$A7,$A6,$A7,$A6,$A7,$A6,$A7
        db $B6,$B7,$A6,$A7,$71,$A6,$A9,$B7
        db $3D,$20,$75,$A6,$A9,$B7,$87,$75
        db $16,$B6,$A8,$A9,$B7,$B6,$B7,$B6
        db $B7,$B6,$A8,$A7,$A6,$A9,$A8,$A7
        db $B6,$A8,$A7,$11,$60,$75,$B6,$B7
        db $88,$75,$13,$A6,$A9,$B7,$A6,$A7
        db $A6,$A7,$A6,$A7,$B6,$B7,$B6,$B7
        db $B6,$B7,$A6,$A9,$B7,$11,$60,$8B
        db $75,$09,$B6,$B7,$A6,$A9,$A8,$A9
        db $A8,$A9,$B7,$11,$83,$43,$07,$11
        db $B6,$B7,$11,$60,$20,$A6,$A7,$82
        db $75,$01,$A6,$A7,$84,$75,$09,$A6
        db $A7,$B6,$B7,$B6,$B7,$B6,$B7,$58
        db $3D,$83,$69,$00,$60,$81,$11,$00
        db $60,$81,$20,$06,$B6,$A8,$A7,$A6
        db $A7,$B6,$B7,$84,$75,$01,$B6,$B7
        db $81,$43,$81,$11,$03,$43,$11,$71
        db $3D,$83,$69,$00,$20,$81,$60,$82
        db $20,$04,$3F,$B6,$A8,$A9,$B7,$86
        db $75,$01,$43,$60,$81,$69,$81,$60
        db $03,$69,$3D,$58,$3D,$83,$69,$85
        db $20,$03,$A6,$A7,$B6,$B7,$87,$75
        db $01,$69,$20,$81,$69,$81,$20,$03
        db $69,$60,$43,$60,$83,$69,$84,$20
        db $02,$43,$B6,$B7,$89,$75,$83,$75
        db $03,$20,$69,$20,$B8,$81,$B9,$06
        db $B8,$20,$69,$20,$75,$54,$55,$8C
        db $75,$81,$4F,$83,$75,$03,$20,$69
        db $20,$B8,$81,$B9,$06,$B8,$20,$69
        db $20,$04,$9E,$9F,$82,$03,$04,$05
        db $06,$07,$54,$55,$84,$75,$81,$4F
        db $81,$75,$05,$54,$55,$20,$69,$20
        db $B8,$81,$B9,$07,$B8,$20,$69,$20
        db $71,$9E,$9F,$71,$81,$AC,$04,$71
        db $56,$57,$9E,$9F,$84,$75,$81,$4F
        db $81,$75,$05,$9E,$9F,$20,$C6,$C7
        db $C8,$81,$C9,$07,$C8,$C7,$C6,$20
        db $71,$9E,$9F,$71,$81,$AC,$04,$71
        db $64,$65,$9E,$9F,$84,$75,$81,$4F
        db $81,$75,$05,$9E,$9F,$20,$D6,$D7
        db $AA,$81,$AB,$07,$AA,$D7,$D6,$20
        db $11,$9E,$67,$57,$81,$AC,$82,$71
        db $02,$64,$67,$55,$83,$75,$81,$4F
        db $07,$75,$0A,$9E,$9F,$50,$E6,$E7
        db $AA,$81,$AB,$07,$AA,$E7,$E6,$50
        db $11,$64,$9E,$9F,$81,$71,$81,$BC
        db $04,$AE,$71,$64,$65,$0A,$82,$75
        db $81,$4F,$07,$75,$1A,$64,$65,$11
        db $50,$F7,$F8,$81,$F9,$10,$F8,$F7
        db $50,$11,$71,$56,$66,$9F,$71,$53
        db $52,$71,$9B,$8F,$52,$53,$1A,$82
        db $75,$81,$4F,$02,$75,$00,$11,$81
        db $71,$02,$11,$20,$B8,$81,$B9,$0B
        db $B8,$20,$11,$56,$57,$9E,$9F,$67
        db $57,$63,$51,$52,$81,$AC,$02,$62
        db $63,$3D,$82,$75,$81,$4F,$07,$75
        db $20,$3D,$56,$57,$11,$20,$B8,$81
        db $B9,$0B,$B8,$20,$11,$9E,$67,$66
        db $9F,$9E,$9F,$3C,$63,$62,$81,$8A
        db $02,$71,$11,$00,$82,$75,$81,$4F
        db $07,$75,$20,$3D,$64,$65,$11,$50
        db $B8,$81,$B9,$02,$B8,$50,$11,$81
        db $9E,$06,$9F,$67,$66,$9F,$58,$52
        db $53,$81,$8A,$02,$11,$50,$20,$82
        db $75,$81,$4F,$07,$11,$20,$3D,$71
        db $BF,$71,$11,$43,$81,$AC,$0B,$43
        db $56,$57,$64,$9E,$9F,$9E,$9F,$65
        db $58,$62,$63,$81,$AC,$02,$11,$50
        db $20,$82,$75,$81,$4F,$11,$11,$50
        db $3D,$BD,$BA,$BD,$BF,$71,$9B,$8F
        db $58,$64,$65,$71,$64,$65,$9E,$9F
        db $81,$58,$07,$3C,$58,$9B,$8F,$58
        db $3D,$20,$11,$81,$75,$81,$4F,$08
        db $75,$11,$3D,$BF,$BD,$BF,$71,$8F
        db $9B,$81,$58,$84,$2C,$01,$9E,$9F
        db $81,$8A,$07,$AD,$AF,$AE,$58,$3C
        db $3D,$50,$11,$81,$75,$81,$4F,$81
        db $75,$09,$4D,$BA,$BF,$BD,$71,$9B
        db $8F,$58,$71,$2C,$82,$71,$02,$2C
        db $9E,$9F,$81,$8A,$06,$AD,$8E,$58
        db $3C,$58,$4D,$11,$82,$75,$81,$43
        db $81,$75,$08,$40,$42,$43,$11,$8F
        db $9B,$56,$57,$2C,$83,$71,$02,$2C
        db $9E,$9F,$81,$AC,$81,$58,$03,$43
        db $44,$42,$40,$83,$75,$81,$69,$81
        db $75,$00,$20,$81,$69,$00,$3D,$81
        db $AC,$03,$64,$65,$6E,$5D,$81,$68
        db $03,$5D,$6E,$64,$65,$81,$AC,$01
        db $3C,$3D,$82,$69,$00,$20,$83,$75
        db $81,$69,$81,$75,$00,$20,$81,$69
        db $00,$3D,$81,$5D,$00,$6B,$81,$6D
        db $83,$6B,$81,$6D,$00,$6B,$81,$5D
        db $01,$58,$3D,$82,$69,$00,$20,$83
        db $75,$81,$69,$02,$75,$11,$20,$81
        db $69,$00,$3D,$81,$5D,$01,$6B,$6E
        db $84,$2C,$02,$71,$6E,$6B,$81,$5D
        db $01,$71,$3D,$82,$69,$01,$20,$11
        db $82,$75,$81,$69,$09,$75,$11,$42
        db $41,$69,$00,$43,$44,$43,$44,$81
        db $43,$81,$44,$81,$43,$05,$44,$43
        db $44,$43,$44,$00,$81,$69,$02,$41
        db $42,$11,$82,$75,$81,$69,$82,$75
        db $01,$11,$43,$81,$20,$8C,$69,$81
        db $20,$81,$43,$00,$11,$84,$75,$81
        db $69,$84,$75,$81,$20,$8C,$69,$81
        db $20,$87,$75,$82,$69,$81,$20,$00
        db $3D,$85,$71,$04,$3D,$69,$20,$69
        db $20,$84,$69,$02,$20,$69,$20,$81
        db $69,$81,$20,$82,$69,$81,$71,$81
        db $20,$01,$69,$3D,$85,$71,$02,$3D
        db $69,$20,$81,$69,$00,$00,$83,$43
        db $02,$46,$47,$48,$81,$20,$81,$69
        db $00,$20,$81,$69,$81,$71,$81,$20
        db $02,$2A,$00,$11,$83,$71,$06,$11
        db $00,$2A,$69,$20,$2A,$11,$85,$71
        db $02,$11,$42,$41,$81,$20,$82,$69
        db $81,$71,$81,$20,$03,$3A,$20,$40
        db $42,$81,$43,$07,$42,$40,$20,$3A
        db $20,$69,$3A,$71,$81,$8A,$83,$AD
        db $04,$8E,$71,$11,$50,$20,$82,$69
        db $81,$71,$02,$69,$00,$11,$82,$20
        db $81,$69,$82,$20,$04,$3D,$20,$69
        db $3D,$71,$81,$8A,$83,$AD,$81,$AF
        db $03,$8E,$11,$50,$20,$81,$69,$81
        db $71,$00,$43,$81,$11,$00,$50,$81
        db $20,$81,$69,$81,$20,$01,$50,$3D
        db $81,$43,$00,$3D,$87,$71,$04,$8E
        db $8A,$8F,$11,$0F,$81,$69,$81,$71
        db $05,$A6,$A7,$3C,$11,$42,$40,$81
        db $69,$03,$40,$42,$11,$00,$81,$71
        db $01,$40,$42,$83,$43,$00,$11,$82
        db $71,$81,$AC,$01,$71,$1F,$81,$69
        db $81,$71,$05,$B6,$B7,$A6,$A7,$3C
        db $11,$81,$43,$81,$11,$04,$00,$20
        db $71,$11,$20,$84,$69,$03,$40,$42
        db $11,$71,$81,$8A,$01,$71,$2F,$81
        db $69,$81,$71,$04,$A6,$A7,$B6,$B7
        db $11,$82,$43,$01,$42,$40,$81,$20
        db $02,$11,$50,$20,$83,$69,$04,$20
        db $69,$20,$50,$11,$81,$8A,$01,$71
        db $11,$83,$71,$04,$B6,$B7,$3C,$11
        db $00,$83,$69,$82,$20,$02,$3D,$50
        db $20,$84,$69,$03,$20,$69,$20,$3D
        db $81,$AC,$85,$71,$81,$3C,$02,$11
        db $50,$20,$84,$69,$05,$20,$00,$3D
        db $11,$42,$41,$82,$69,$04,$20,$69
        db $20,$69,$3D,$81,$AC,$85,$71,$03
        db $4F,$3C,$4F,$3C,$81,$4F,$00,$3D
        db $96,$3F,$81,$75,$83,$4F,$81,$3C
        db $01,$11,$0A,$95,$3F,$81,$75,$81
        db $8A,$81,$AD,$81,$4F,$01,$3C,$1A
        db $95,$3F,$81,$75,$81,$8A,$81,$AD
        db $03,$4F,$3C,$4F,$3D,$8E,$3F,$00
        db $0A,$81,$03,$01,$02,$01,$81,$3F
        db $81,$75,$81,$AC,$81,$4F,$03,$11
        db $43,$42,$40,$8E,$3F,$00,$1A,$81
        db $4F,$01,$3C,$11,$81,$23,$81,$75
        db $81,$AC,$81,$4F,$00,$3A,$82,$20
        db $8E,$43,$04,$3D,$4F,$3C,$4F,$3C
        db $81,$4F,$81,$75,$82,$4F,$01,$11
        db $2A,$82,$20,$00,$4F,$81,$3C,$01
        db $4F,$3C,$87,$4F,$81,$3C,$03,$00
        db $11,$4F,$3C,$82,$4F,$81,$75,$81
        db $4F,$01,$11,$50,$81,$20,$06,$69
        db $20,$3C,$4F,$3C,$4F,$3C,$88,$4F
        db $04,$3C,$20,$40,$42,$11,$82,$4F
        db $81,$75,$81,$4F,$01,$3D,$69,$81
        db $20,$05,$69,$20,$4F,$3C,$4F,$3C
        db $81,$4F,$81,$AC,$01,$4F,$3C,$81
        db $4F,$02,$3C,$11,$43,$81,$20,$01
        db $69,$50,$82,$43,$81,$75,$81,$4F
        db $01,$3D,$69,$81,$20,$03,$69,$20
        db $3C,$4F,$81,$3C,$01,$4F,$3C,$81
        db $AC,$00,$3C,$82,$4F,$02,$11,$50
        db $69,$81,$20,$84,$69,$81,$75,$03
        db $4F,$3C,$11,$50,$81,$20,$01,$69
        db $20,$81,$8A,$83,$AD,$81,$5D,$01
        db $4F,$3C,$81,$5D,$02,$3D,$50,$43
        db $81,$20,$84,$69,$81,$75,$03,$3C
        db $4F,$3C,$3D,$81,$20,$01,$69,$20
        db $81,$8A,$83,$AD,$81,$68,$01,$3C
        db $4F,$81,$68,$00,$3D,$81,$11,$01
        db $50,$20,$84,$69,$81,$75,$07,$4F
        db $3C,$11,$00,$69,$20,$40,$42,$81
        db $AC,$03,$3C,$4F,$3C,$4F,$81,$5D
        db $81,$3C,$81,$5D,$05,$11,$10,$3F
        db $10,$42,$41,$83,$69,$81,$75,$81
        db $43,$05,$50,$20,$2A,$43,$11,$3C
        db $81,$AC,$00,$4F,$84,$3C,$00,$4F
        db $83,$3C,$05,$11,$03,$11,$3C,$4F
        db $50,$82,$69,$81,$75,$81,$69,$81
        db $20,$00,$3A,$82,$3C,$81,$8A,$83
        db $AD,$81,$5D,$81,$AD,$81,$8A,$81
        db $AD,$81,$8A,$81,$AD,$00,$8E,$82
        db $43,$81,$75,$07,$69,$20,$69,$20
        db $43,$11,$3C,$4F,$81,$8A,$83,$AD
        db $81,$68,$81,$AD,$81,$8A,$81,$AD
        db $81,$8A,$81,$AD,$81,$AF,$01,$8E
        db $4F,$81,$75,$07,$69,$20,$69,$20
        db $69,$50,$11,$3C,$82,$4F,$00,$3C
        db $81,$4F,$81,$5D,$00,$3C,$83,$4F
        db $00,$3C,$81,$4F,$81,$3C,$03,$4F
        db $8E,$AF,$4F,$81,$75,$81,$69,$81
        db $20,$00,$43,$81,$50,$01,$43,$11
        db $81,$60,$82,$3C,$03,$4F,$3C,$4F
        db $3C,$81,$60,$81,$3C,$81,$60,$00
        db $3C,$81,$60,$82,$3C,$81,$75,$08
        db $69,$20,$69,$20,$3F,$11,$50,$69
        db $60,$81,$11,$00,$60,$81,$3C,$00
        db $60,$82,$23,$81,$11,$81,$23,$81
        db $11,$02,$23,$11,$3D,$82,$3C,$81
        db $75,$81,$69,$81,$20,$04,$11,$3F
        db $11,$60,$11,$81,$4F,$00,$11,$81
        db $23,$00,$11,$8A,$4F,$00,$11,$82
        db $23,$81,$75,$07,$69,$20,$69,$50
        db $11,$3F,$60,$11,$95,$4F,$81,$75
        db $9D,$71,$81,$69,$9D,$71,$81,$69
        db $9D,$71,$81,$69,$9D,$71,$81,$69
        db $9D,$71,$81,$69,$82,$71,$00,$7C
        db $81,$71,$81,$7C,$81,$71,$82,$7C
        db $81,$71,$00,$7C,$81,$71,$00,$7C
        db $81,$71,$00,$7C,$81,$71,$00,$7C
        db $84,$71,$81,$43,$81,$71,$08,$7C
        db $71,$7C,$71,$7C,$71,$7C,$71,$7C
        db $82,$71,$0A,$7C,$71,$7C,$71,$7C
        db $71,$7C,$71,$7C,$71,$7C,$88,$71
        db $00,$7C,$82,$71,$04,$7C,$71,$7C
        db $71,$7C,$82,$71,$00,$7C,$82,$71
        db $06,$7C,$71,$7C,$71,$7C,$71,$7C
        db $89,$71,$00,$7C,$81,$71,$03,$7C
        db $71,$7C,$71,$82,$7C,$01,$71,$7C
        db $82,$71,$01,$7C,$71,$82,$7C,$01
        db $71,$7C,$8A,$71,$01,$7C,$71,$81
        db $7C,$81,$71,$00,$7C,$82,$71,$00
        db $7C,$82,$71,$06,$7C,$71,$7C,$71
        db $7C,$71,$7C,$88,$71,$04,$7C,$71
        db $7C,$71,$7C,$82,$71,$00,$7C,$82
        db $71,$0A,$7C,$71,$7C,$71,$7C,$71
        db $7C,$71,$7C,$71,$7C,$86,$71,$81
        db $43,$02,$00,$69,$20,$83,$69,$06
        db $20,$50,$11,$71,$02,$01,$11,$83
        db $43,$03,$42,$41,$20,$3D,$81,$8A
        db $85,$71,$82,$69,$81,$20,$82,$69
        db $06,$41,$42,$A6,$A7,$A6,$A7,$3D
        db $85,$3F,$02,$11,$50,$3D,$81,$8A
        db $85,$71,$81,$43,$02,$60,$20,$50
        db $82,$43,$07,$11,$A6,$A9,$B7,$B6
        db $B7,$00,$11,$85,$3F,$01,$60,$11
        db $81,$AC,$87,$71,$04,$11,$60,$11
        db $A6,$A7,$81,$71,$01,$B6,$B7,$81
        db $71,$02,$3D,$50,$11,$85,$3F,$01
        db $3D,$71,$81,$AC,$88,$71,$06,$11
        db $60,$B6,$B7,$A6,$A7,$71,$81,$8A
        db $02,$AD,$3D,$11,$85,$3F,$02,$10
        db $3D,$71,$81,$AC,$89,$71,$05,$11
        db $60,$71,$B6,$B7,$71,$81,$8A,$01
        db $AD,$3D,$84,$3F,$04,$10,$03,$11
        db $3D,$5D,$81,$68,$00,$5D,$86,$71
        db $00,$3C,$81,$71,$01,$3D,$71,$81
        db $60,$00,$71,$81,$AC,$02,$71,$11
        db $10,$83,$3F,$00,$3D,$81,$71,$01
        db $3D,$5D,$81,$68,$00,$5D,$85,$71
        db $05,$3C,$71,$3C,$71,$11,$43,$81
        db $11,$00,$60,$81,$AC,$00,$71,$81
        db $60,$00,$10,$81,$3F,$00,$60,$82
        db $43,$03,$11,$71,$9B,$8F,$87,$71
        db $00,$3C,$85,$71,$00,$11,$82,$43
        db $81,$11,$00,$43,$81,$03,$00,$11
        db $81,$71,$81,$AD,$01,$AF,$AE,$9B
        db $71,$81,$AD,$00,$8E,$87,$71,$00
        db $87,$81,$88,$00,$97,$81,$86,$81
        db $85,$81,$86,$02,$85,$71,$85,$81
        db $86,$00,$85,$81,$89,$00,$87,$81
        db $88,$01,$87,$85,$81,$86,$00,$85
        db $81,$89,$81,$71,$81,$BB,$03,$58
        db $71,$58,$95,$81,$96,$81,$95,$81
        db $96,$02,$95,$71,$95,$81,$96,$00
        db $95,$81,$99,$00,$85,$81,$86,$01
        db $85,$95,$81,$96,$00,$95,$81,$99
        db $81,$71,$81,$BB,$00,$85,$81,$86
        db $00,$97,$81,$88,$81,$87,$81,$88
        db $02,$87,$58,$87,$81,$88,$00,$87
        db $81,$89,$00,$95,$81,$96,$01,$95
        db $87,$81,$88,$00,$97,$81,$86,$01
        db $85,$71,$81,$BB,$00,$95,$81,$96
        db $01,$95,$58,$81,$71,$00,$58,$81
        db $89,$85,$71,$81,$99,$00,$87,$81
        db $88,$04,$87,$71,$58,$71,$95,$81
        db $96,$01,$95,$71,$81,$BB,$00,$87
        db $81,$88,$01,$87,$85,$81,$86,$00
        db $85,$81,$99,$81,$71,$83,$89,$81
        db $5D,$81,$89,$81,$71,$00,$85,$81
        db $86,$00,$97,$81,$88,$01,$97,$71
        db $81,$BB,$00,$85,$81,$86,$01,$85
        db $95,$81,$96,$00,$95,$83,$71,$83
        db $99,$81,$5D,$81,$99,$81,$89,$00
        db $95,$81,$96,$00,$95,$81,$58,$81
        db $71,$81,$BB,$00,$95,$81,$96,$01
        db $95,$87,$81,$88,$00,$87,$81,$71
        db $83,$89,$02,$58,$71,$58,$82,$71
        db $81,$99,$00,$87,$81,$88,$01,$87
        db $85,$81,$86,$00,$71,$81,$BB,$00
        db $87,$81,$88,$01,$87,$85,$81,$86
        db $00,$85,$81,$71,$83,$99,$00,$85
        db $81,$86,$00,$85,$83,$89,$00,$85
        db $81,$86,$01,$85,$95,$81,$96,$00
        db $71,$81,$BB,$00,$85,$81,$86,$01
        db $85,$95,$81,$96,$00,$95,$81,$71
        db $83,$89,$00,$95,$81,$96,$00,$95
        db $83,$99,$00,$95,$81,$96,$01,$95
        db $87,$81,$88,$00,$71,$81,$BB,$00
        db $95,$81,$96,$01,$95,$87,$81,$88
        db $00,$87,$81,$71,$83,$99,$00,$87
        db $81,$88,$01,$87,$58,$82,$71,$00
        db $87,$81,$88,$00,$87,$83,$71,$81
        db $BB,$00,$87,$81,$88,$00,$97,$81
        db $86,$01,$85,$71,$81,$89,$81,$71
        db $83,$89,$00,$71,$81,$89,$00,$71
        db $81,$2B,$85,$89,$81,$71,$81,$BB
        db $00,$71,$81,$58,$00,$95,$81,$96
        db $01,$95,$71,$81,$99,$81,$71,$83
        db $99,$00,$58,$81,$99,$00,$58,$81
        db $2B,$85,$99,$81,$71,$81,$E8,$00
        db $85,$81,$86,$00,$97,$81,$88,$00
        db $87,$82,$71,$81,$89,$82,$71,$81
        db $89,$00,$71,$81,$89,$81,$71,$81
        db $89,$00,$85,$81,$86,$00,$85,$81
        db $71,$81,$3F,$00,$95,$81,$96,$00
        db $95,$81,$89,$83,$71,$81,$99,$00
        db $71,$81,$89,$81,$99,$00,$71,$81
        db $99,$81,$71,$81,$99,$00,$95,$81
        db $96,$00,$95,$81,$71,$81,$3F,$00
        db $87,$81,$88,$00,$87,$81,$99,$83
        db $89,$02,$58,$71,$58,$81,$99,$00
        db $71,$81,$89,$00,$71,$81,$89,$00
        db $85,$81,$86,$00,$97,$81,$88,$00
        db $87,$81,$71,$81,$D8,$81,$89,$00
        db $85,$81,$86,$00,$85,$83,$99,$00
        db $85,$81,$86,$00,$85,$81,$71,$81
        db $99,$00,$71,$81,$99,$00,$95,$81
        db $96,$01,$95,$71,$81,$89,$81,$71
        db $81,$3F,$81,$99,$00,$95,$81,$96
        db $00,$95,$83,$89,$00,$95,$81,$96
        db $00,$95,$83,$89,$00,$85,$81,$86
        db $00,$97,$81,$88,$01,$87,$58,$81
        db $99,$81,$71,$81,$3F,$81,$71,$00
        db $87,$81,$88,$00,$87,$83,$99,$00
        db $87,$81,$88,$00,$87,$83,$99,$00
        db $95,$81,$96,$00,$95,$81,$89,$00
        db $85,$81,$86,$00,$85,$81,$71,$81
        db $3F,$00,$71,$81,$89,$01,$71,$58
        db $83,$89,$00,$71,$81,$89,$00,$85
        db $81,$86,$00,$85,$81,$58,$00,$87
        db $81,$88,$00,$87,$81,$99,$00,$95
        db $81,$96,$00,$95,$81,$71,$81,$D9
        db $00,$71,$81,$99,$01,$58,$71,$83
        db $99,$00,$58,$81,$99,$00,$95,$81
        db $96,$00,$95,$81,$89,$00,$85,$81
        db $86,$00,$85,$81,$89,$00,$87,$81
        db $88,$00,$87,$81,$71,$81,$D8,$01
        db $71,$85,$81,$86,$03,$85,$71,$58
        db $85,$81,$86,$02,$85,$71,$87,$81
        db $88,$00,$87,$81,$99,$00,$95,$81
        db $96,$00,$95,$81,$99,$85,$71,$81
        db $3F,$83,$75,$03,$20,$69,$20,$B8
        db $81,$B9,$03,$B8,$20,$69,$20,$8F
        db $75,$81,$4F,$82,$71,$00,$7C,$81
        db $71,$00,$7C,$82,$71,$82,$7C,$81
        db $71,$00,$7C,$81,$71,$05,$7C,$71
        db $7C,$71,$7C,$71,$82,$7C,$82,$71
        db $81,$43,$9D,$71,$81,$69,$85,$71
        db $81,$7B,$83,$71,$81,$7B,$83,$71
        db $81,$7B,$83,$71,$81,$7B,$83,$71
        db $81,$43,$85,$71,$81,$7B,$83,$71
        db $81,$7B,$83,$71,$81,$7B,$83,$71
        db $81,$7B,$C7,$71,$81,$5D,$81,$6B
        db $81,$5D,$83,$71,$81,$7B,$83,$71
        db $81,$7B,$83,$71,$81,$7B,$87,$71
        db $81,$5D,$81,$6B,$81,$5D,$83,$71
        db $81,$7B,$83,$71,$81,$7B,$83,$71
        db $81,$7B,$C5,$71,$83,$BB,$00,$7C
        db $88,$BB,$81,$10,$81,$BB,$81,$7B
        db $89,$BB,$81,$71,$81,$BB,$01,$B0
        db $B1,$86,$BB,$02,$7C,$BB,$10,$81
        db $11,$01,$10,$BB,$81,$7B,$82,$BB
        db $00,$7C,$85,$BB,$81,$71,$03,$BB
        db $E0,$C0,$C1,$82,$BB,$81,$7B,$82
        db $BB,$01,$10,$11,$81,$5D,$01,$11
        db $10,$8B,$BB,$81,$71,$03,$BB,$E1
        db $D0,$D1,$82,$BB,$81,$7B,$82,$BB
        db $08,$3D,$4F,$5D,$68,$4F,$11,$10
        db $BB,$7C,$83,$BB,$81,$7B,$82,$BB
        db $81,$71,$8A,$BB,$00,$10,$82,$4F
        db $81,$6C,$01,$4F,$3D,$85,$BB,$81
        db $7B,$82,$BB,$81,$71,$82,$BB,$00
        db $10,$86,$03,$84,$4F,$81,$6C,$04
        db $11,$03,$04,$03,$04,$82,$03,$00
        db $10,$82,$BB,$81,$71,$81,$7B,$01
        db $BB,$3D,$81,$5D,$83,$6B,$81,$5D
        db $84,$4F,$02,$6C,$68,$5D,$83,$4F
        db $81,$5D,$00,$3D,$82,$BB,$81,$71
        db $81,$7B,$01,$BB,$3D,$81,$5D,$83
        db $6B,$81,$5D,$05,$4F,$12,$13,$14
        db $15,$4F,$81,$5D,$83,$4F,$02,$68
        db $5D,$3D,$82,$BB,$81,$71,$82,$BB
        db $00,$00,$87,$4F,$05,$58,$31,$32
        db $33,$34,$58,$84,$4F,$81,$6C,$01
        db $11,$00,$82,$BB,$81,$71,$04,$BB
        db $7C,$BB,$20,$50,$85,$4F,$07,$58
        db $4F,$35,$36,$37,$38,$4F,$58,$82
        db $4F,$81,$6C,$02,$11,$50,$20,$82
        db $BB,$81,$71,$82,$BB,$02,$20,$69
        db $00,$81,$4F,$81,$5D,$10,$4F,$58
        db $4F,$35,$36,$37,$38,$4F,$58,$4F
        db $5D,$68,$6C,$11,$00,$69,$20,$82
        db $BB,$81,$71,$02,$E8,$E9,$E8,$81
        db $20,$04,$69,$50,$4F,$68,$5D,$81
        db $4F,$05,$58,$49,$4A,$59,$5A,$58
        db $81,$4F,$81,$5D,$02,$4F,$3D,$69
        db $81,$20,$82,$E8,$81,$71,$82,$3F
        db $05,$20,$69,$20,$50,$4F,$68,$84
        db $4F,$81,$5D,$86,$4F,$03,$3D,$20
        db $69,$20,$82,$D8,$81,$71,$81,$3F
        db $04,$D8,$20,$69,$00,$11,$81,$6C
        db $84,$4F,$03,$5D,$68,$6D,$6E,$84
        db $4F,$03,$11,$00,$69,$20,$82,$3F
        db $81,$71,$05,$D8,$D9,$3F,$20,$50
        db $11,$81,$6C,$85,$4F,$81,$11,$00
        db $6E,$81,$6D,$00,$6E,$83,$4F,$02
        db $11,$50,$20,$82,$D9,$81,$71,$04
        db $3F,$D8,$D9,$00,$11,$81,$6C,$85
        db $4F,$05,$11,$00,$50,$43,$11,$6E
        db $81,$6D,$00,$6E,$83,$4F,$00,$00
        db $82,$3F,$81,$71,$81,$3F,$03,$10
        db $11,$5D,$68,$84,$4F,$09,$11,$43
        db $50,$69,$20,$69,$50,$11,$4F,$6E
        db $81,$6D,$00,$6E,$81,$5D,$01,$4F
        db $10,$81,$3F,$81,$71,$81,$3F,$01
        db $3D,$4F,$81,$5D,$81,$4F,$00,$11
        db $81,$43,$00,$00,$82,$69,$00,$20
        db $81,$69,$01,$00,$18,$81,$4F,$05
        db $6E,$6D,$68,$5D,$4F,$3D,$81,$3F
        db $81,$71,$02,$D9,$3F,$3D,$82,$4F
        db $02,$11,$43,$50,$82,$69,$00,$20
        db $81,$69,$08,$20,$69,$20,$69,$48
        db $47,$46,$45,$11,$82,$4F,$00,$00
        db $81,$3F,$81,$71,$03,$D8,$D9,$40
        db $42,$81,$43,$02,$50,$69,$20,$82
        db $69,$02,$20,$69,$20,$82,$69,$00
        db $20,$83,$69,$00,$00,$81,$43,$01
        db $50,$20,$81,$3F,$81,$71,$81,$3F
        db $02,$20,$69,$20,$81,$69,$00,$20
        db $83,$69,$00,$20,$81,$69,$02,$20
        db $69,$20,$84,$69,$04,$20,$69,$20
        db $69,$20,$81,$3F,$81,$71,$03,$4F
        db $3C,$4F,$3C,$81,$4F,$00,$3D,$96
        db $3F,$81,$75,$9B,$1C,$03,$58,$18
        db $1C,$58,$9B,$1C,$03,$58,$18,$1C
        db $58,$9A,$1C,$04,$10,$58,$18,$1C
        db $58,$94,$1C,$81,$10,$81,$50,$82
        db $10,$03,$50,$18,$14,$58,$90,$1C
        db $81,$5C,$84,$10,$00,$50,$82,$10
        db $03,$50,$10,$50,$90,$90,$1C,$00
        db $5C,$81,$10,$8B,$50,$89,$1C,$82
        db $10,$81,$50,$81,$1C,$00,$5C,$86
        db $10,$00,$50,$82,$10,$00,$50,$81
        db $D0,$89,$1C,$83,$10,$00,$50,$81
        db $1C,$00,$5C,$81,$10,$84,$90,$00
        db $D0,$82,$90,$02,$D0,$50,$18,$89
        db $1C,$00,$50,$81,$90,$81,$D0,$81
        db $1C,$01,$18,$50,$84,$90,$85,$10
        db $81,$50,$88,$1C,$01,$D4,$58,$82
        db $1C,$03,$18,$94,$1C,$18,$81,$58
        db $82,$5C,$00,$50,$82,$90,$84,$50
        db $88,$1C,$81,$54,$81,$1C,$82,$14
        db $01,$1C,$18,$81,$58,$81,$5C,$03
        db $18,$5C,$58,$18,$84,$90,$00,$D0
        db $89,$1C,$00,$54,$82,$14,$82,$1C
        db $00,$18,$81,$58,$82,$5C,$81,$58
        db $01,$5C,$58,$82,$5C,$01,$18,$14
        db $86,$1C,$81,$10,$87,$1C,$01,$58
        db $98,$83,$18,$81,$58,$00,$18,$83
        db $5C,$01,$18,$14,$86,$1C,$81,$10
        db $81,$50,$85,$10,$00,$58,$85,$98
        db $81,$18,$00,$58,$82,$5C,$01,$18
        db $14,$84,$1C,$84,$10,$81,$50,$06
        db $10,$50,$10,$50,$10,$58,$18,$83
        db $5C,$81,$98,$01,$18,$58,$82,$18
        db $01,$D8,$18,$84,$1C,$01,$10,$50
        db $81,$10,$02,$50,$10,$50,$81,$10
        db $05,$D0,$50,$D0,$58,$5C,$58,$83
        db $5C,$84,$98,$02,$D8,$18,$98,$84
        db $1C,$83,$10,$00,$50,$82,$10,$84
        db $50,$00,$18,$84,$5C,$00,$18,$82
        db $5C,$03,$18,$14,$58,$5C,$83,$1C
        db $85,$10,$00,$50,$81,$10,$81,$50
        db $00,$90,$82,$50,$00,$58,$84,$5C
        db $00,$58,$81,$5C,$03,$18,$14,$58
        db $5C,$82,$1C,$8A,$10,$83,$50,$84
        db $10,$01,$50,$18,$82,$5C,$03,$18
        db $14,$58,$5C,$82,$1C,$89,$10,$81
        db $50,$81,$90,$85,$10,$81,$50,$00
        db $58,$81,$5C,$03,$18,$14,$58,$5C
        db $82,$1C,$85,$10,$00,$50,$84,$10
        db $01,$50,$D0,$81,$10,$00,$50,$83
        db $10,$00,$50,$81,$10,$04,$50,$18
        db $14,$58,$5C,$82,$1C,$01,$50,$90
        db $81,$10,$01,$50,$10,$83,$18,$02
        db $10,$50,$D0,$82,$90,$00,$D0,$81
        db $90,$00,$10,$81,$50,$81,$10,$02
        db $50,$14,$58,$81,$14,$82,$1C,$00
        db $58,$81,$90,$03,$50,$90,$10,$D0
        db $82,$90,$04,$D0,$90,$10,$5C,$50
        db $81,$90,$02,$10,$D0,$10,$81,$50
        db $82,$10,$00,$50,$82,$58,$82,$1C
        db $00,$58,$82,$10,$02,$50,$10,$D0
        db $82,$90,$01,$10,$5C,$81,$14,$07
        db $54,$58,$18,$90,$10,$D0,$10,$50
        db $81,$18,$01,$10,$50,$82,$58,$82
        db $1C,$00,$D0,$82,$10,$00,$50,$81
        db $D0,$02,$58,$5C,$18,$82,$14,$01
        db $58,$54,$81,$14,$00,$54,$82,$10
        db $83,$18,$00,$10,$82,$50,$81,$1C
        db $84,$10,$81,$50,$84,$14,$85,$58
        db $81,$10,$01,$90,$10,$84,$18,$81
        db $10,$00,$90,$81,$1C,$84,$10,$82
        db $50,$87,$58,$01,$10,$50,$83,$10
        db $00,$D0,$82,$18,$02,$90,$D0,$10
        db $82,$1C,$83,$10,$03,$90,$D0,$10
        db $50,$86,$58,$01,$10,$50,$88,$10
        db $81,$D0,$01,$1C,$58,$81,$1C,$01
        db $50,$90,$82,$10,$03,$50,$D0,$10
        db $94,$84,$58,$83,$10,$00,$50,$83
        db $10,$01,$18,$10,$81,$D0,$01,$1C
        db $18,$82,$1C,$00,$58,$83,$10,$81
        db $50,$81,$14,$84,$58,$83,$10,$00
        db $D0,$84,$10,$81,$D0,$82,$1C,$00
        db $58,$81,$1C,$00,$58,$83,$10,$81
        db $50,$83,$58,$00,$10,$81,$50,$87
        db $10,$81,$D0,$00,$58,$82,$1C,$81
        db $14,$04,$1C,$D4,$58,$50,$90,$81
        db $10,$82,$50,$82,$58,$83,$10,$00
        db $18,$83,$10,$03,$18,$10,$D0,$18
        db $82,$1C,$81,$14,$01,$1C,$18,$9E
        db $1C,$00,$18,$9E,$1C,$01,$18,$50
        db $95,$1C,$83,$10,$83,$1C,$00,$10
        db $81,$50,$90,$1C,$87,$10,$83,$1C
        db $01,$90,$10,$81,$50,$8D,$1C,$89
        db $10,$01,$50,$5C,$81,$1C,$82,$90
        db $81,$50,$8B,$1C,$81,$10,$84,$50
        db $83,$10,$81,$50,$81,$1C,$81,$58
        db $02,$90,$10,$50,$8B,$1C,$82,$10
        db $84,$18,$00,$50,$82,$10,$00,$50
        db $81,$1C,$82,$58,$01,$10,$50,$8B
        db $1C,$01,$10,$90,$85,$18,$00,$58
        db $81,$50,$01,$D0,$10,$81,$1C,$81
        db $58,$02,$10,$D0,$10,$87,$1C,$83
        db $18,$00,$50,$81,$90,$84,$18,$01
        db $D0,$10,$81,$D0,$00,$18,$81,$1C
        db $01,$58,$10,$81,$D0,$01,$18,$58
        db $85,$1C,$84,$18,$00,$58,$87,$90
        db $81,$D0,$01,$5C,$18,$81,$1C,$05
        db $10,$90,$D0,$5C,$18,$58,$88,$18
        db $04,$58,$D8,$58,$5C,$58,$81,$1C
        db $85,$5C,$01,$58,$18,$81,$1C,$01
        db $58,$18,$81,$5C,$01,$18,$58,$86
        db $18,$81,$98,$00,$D8,$81,$58,$01
        db $18,$5C,$81,$1C,$84,$5C,$07,$18
        db $5C,$18,$50,$1C,$58,$5C,$58,$81
        db $18,$00,$58,$85,$1C,$82,$18,$01
        db $58,$18,$82,$58,$81,$1C,$85,$5C
        db $01,$58,$18,$81,$50,$00,$58,$82
        db $18,$01,$D8,$18,$83,$10,$81,$50
        db $81,$18,$00,$D8,$82,$18,$00,$58
        db $82,$18,$00,$58,$83,$5C,$04,$18
        db $5C,$18,$10,$50,$82,$18,$81,$D8
        db $01,$18,$D0,$83,$90,$04,$50,$58
        db $98,$18,$D8,$83,$18,$02,$98,$D8
        db $18,$84,$5C,$00,$58,$81,$10,$00
        db $50,$81,$98,$04,$18,$58,$5C,$18
        db $D0,$82,$5C,$81,$90,$00,$58,$87
        db $98,$01,$D8,$18,$83,$5C,$00,$18
        db $82,$10,$01,$50,$18,$81,$98,$02
        db $18,$5C,$18,$83,$14,$81,$54,$00
        db $58,$81,$5C,$00,$58,$84,$5C,$01
        db $58,$18,$82,$5C,$83,$10,$81,$50
        db $05,$5C,$58,$5C,$18,$5C,$18,$85
        db $1C,$02,$58,$5C,$18,$84,$5C,$02
        db $18,$5C,$18,$87,$10,$01,$50,$18
        db $81,$5C,$01,$18,$5C,$81,$14,$83
        db $58,$01,$D4,$58,$81,$5C,$00,$58
        db $84,$5C,$00,$58,$82,$10,$02,$50
        db $10,$50,$81,$10,$05,$D0,$10,$5C
        db $58,$5C,$18,$81,$14,$00,$18,$83
        db $58,$81,$54,$01,$5C,$18,$84,$5C
        db $00,$18,$81,$10,$05,$50,$10,$50
        db $10,$50,$10,$81,$50,$81,$18,$81
        db $5C,$01,$18,$94,$86,$58,$82,$54
        db $00,$58,$86,$10,$05,$50,$10,$50
        db $10,$50,$10,$81,$50,$03,$18,$14
        db $54,$5C,$81,$14,$01,$58,$18,$85
        db $58,$02,$18,$54,$14,$82,$10,$00
        db $50,$82,$10,$02,$50,$D0,$90,$81
        db $10,$82,$50,$02,$18,$58,$54,$81
        db $14,$81,$58,$84,$18,$83,$58,$83
        db $10,$02,$50,$10,$50,$81,$10,$07
        db $50,$10,$50,$10,$50,$10,$50,$14
        db $82,$58,$02,$10,$50,$58,$82,$18
        db $01,$10,$50,$82,$58,$82,$10,$00
        db $50,$81,$10,$81,$50,$02,$10,$50
        db $10,$81,$50,$04,$10,$50,$10,$50
        db $14,$82,$50,$81,$10,$00,$94,$81
        db $18,$81,$10,$01,$50,$10,$81,$50
        db $83,$10,$0D,$50,$10,$50,$10,$50
        db $10,$50,$10,$50,$10,$50,$10,$50
        db $1C,$82,$90,$00,$D0,$81,$14,$01
        db $18,$10,$83,$90,$82,$10,$01,$50
        db $10,$81,$50,$07,$10,$50,$10,$50
        db $10,$50,$10,$50,$81,$10,$82,$50
        db $81,$1C,$81,$18,$82,$14,$00,$58
        db $81,$1C,$00,$18,$81,$90,$81,$10
        db $00,$50,$81,$10,$00,$50,$81,$10
        db $0A,$50,$10,$50,$10,$50,$10,$50
        db $10,$50,$10,$50,$81,$1C,$81,$18
        db $82,$14,$00,$58,$82,$1C,$00,$58
        db $82,$90,$04,$10,$50,$10,$50,$10
        db $81,$50,$81,$10,$81,$50,$05,$10
        db $50,$10,$50,$10,$50,$81,$1C,$81
        db $18,$82,$14,$00,$58,$81,$1C,$00
        db $18,$82,$1C,$81,$10,$02,$50,$10
        db $50,$81,$10,$06,$50,$10,$50,$10
        db $50,$14,$10,$81,$50,$01,$D0,$10
        db $82,$1C,$81,$14,$02,$18,$D4,$58
        db $82,$1C,$00,$58,$81,$1C,$84,$10
        db $00,$50,$81,$10,$01,$50,$10,$81
        db $50,$02,$10,$50,$10,$81,$50,$02
        db $18,$14,$54,$81,$14,$01,$18,$58
        db $85,$54,$83,$10,$06,$50,$10,$50
        db $10,$50,$10,$50,$81,$10,$03,$50
        db $10,$50,$10,$81,$50,$00,$18,$87
        db $1C,$83,$50,$83,$10,$02,$50,$10
        db $50,$81,$10,$06,$50,$10,$50,$10
        db $50,$10,$50,$81,$10,$02,$50,$18
        db $1C,$81,$54,$00,$58,$82,$10,$01
        db $50,$10,$83,$50,$89,$10,$81,$D0
        db $02,$1C,$58,$1C,$81,$14,$83,$1C
        db $04,$54,$58,$50,$90,$D0,$86,$10
        db $81,$18,$00,$50,$84,$10,$81,$D0
        db $01,$58,$18,$82,$14,$85,$1C,$00
        db $D0,$81,$10,$01,$50,$D0,$82,$10
        db $02,$50,$10,$90,$81,$18,$00,$D0
        db $83,$10,$81,$D0,$01,$18,$1C,$81
        db $14,$86,$1C,$83,$10,$81,$50,$00
        db $D0,$81,$90,$00,$D0,$87,$10,$81
        db $D0,$81,$1C,$01,$58,$14,$81,$1C
        db $81,$14,$83,$1C,$01,$50,$90,$81
        db $10,$00,$D0,$83,$10,$00,$50,$84
        db $10,$01,$D0,$90,$81,$D0,$81,$1C
        db $00,$18,$87,$14,$81,$1C,$00,$58
        db $82,$90,$01,$D0,$18,$82,$10,$00
        db $50,$83,$10,$81,$D0,$00,$58,$83
        db $1C,$81,$14,$00,$1C,$81,$14,$81
        db $58,$81,$14,$81,$1C,$05,$58,$1C
        db $18,$58,$1C,$18,$86,$90,$81,$D0
        db $02,$1C,$58,$5C,$81,$1C,$83,$14
        db $85,$58,$81,$1C,$04,$58,$1C,$18
        db $58,$1C,$81,$18,$00,$58,$84,$1C
        db $00,$58,$81,$1C,$00,$58,$81,$1C
        db $81,$14,$00,$1C,$81,$14,$85,$58
        db $81,$1C,$07,$58,$1C,$18,$58,$1C
        db $18,$1C,$58,$83,$1C,$01,$18,$5C
        db $81,$1C,$00,$58,$84,$14,$87,$58
        db $81,$1C,$04,$58,$1C,$18,$58,$1C
        db $81,$18,$01,$1C,$5C,$83,$1C,$01
        db $58,$1C,$82,$14,$81,$1C,$81,$14
        db $87,$58,$81,$1C,$07,$58,$1C,$18
        db $58,$1C,$18,$54,$58,$83,$1C,$00
        db $18,$82,$14,$83,$1C,$81,$14,$87
        db $58,$81,$1C,$06,$58,$1C,$18,$58
        db $1C,$18,$54,$86,$14,$85,$1C,$81
        db $14,$87,$58,$81,$1C,$05,$58,$1C
        db $18,$58,$1C,$18,$84,$10,$81,$50
        db $87,$1C,$81,$14,$86,$58,$02,$1C
        db $10,$58,$81,$10,$81,$50,$00,$18
        db $86,$10,$00,$50,$86,$1C,$83,$14
        db $83,$58,$03,$14,$1C,$10,$50,$81
        db $10,$81,$50,$87,$10,$00,$50,$88
        db $1C,$81,$14,$00,$58,$81,$14,$09
        db $58,$14,$1C,$10,$D0,$58,$18,$58
        db $18,$90,$86,$10,$00,$50,$8B,$1C
        db $81,$14,$82,$1C,$00,$10,$81,$50
        db $01,$18,$58,$88,$10,$00,$50,$90
        db $1C,$81,$10,$00,$50,$8A,$10,$00
        db $50,$83,$1C,$01,$18,$58,$8A,$1C
        db $00,$50,$82,$90,$86,$10,$00,$D0
        db $81,$90,$00,$10,$83,$1C,$00,$18
        db $81,$58,$83,$1C,$81,$18,$00,$58
        db $82,$1C,$81,$58,$00,$1C,$87,$10
        db $00,$50,$81,$1C,$00,$18,$83,$1C
        db $81,$98,$81,$58,$81,$1C,$85,$18
        db $00,$1C,$81,$58,$01,$1C,$50,$86
        db $90,$00,$10,$81,$1C,$00,$18,$83
        db $1C,$00,$58,$8A,$18,$00,$D4,$81
        db $58,$00,$1C,$81,$58,$84,$1C,$81
        db $18,$81,$1C,$01,$18,$94,$82,$1C
        db $8B,$18,$81,$54,$01,$58,$1C,$81
        db $58,$84,$1C,$81,$18,$81,$1C,$81
        db $14,$81,$1C,$8C,$18,$01,$1C,$54
        db $81,$14,$81,$58,$84,$1C,$81,$18
        db $82,$14,$82,$1C,$81,$98,$8A,$18
        db $82,$1C,$81,$54,$00,$58,$84,$1C
        db $00,$18,$81,$14,$84,$1C,$00,$58
        db $8B,$18,$83,$1C,$00,$54,$87,$14
        db $85,$1C,$8C,$18,$92,$1C,$81,$98
        db $8A,$18,$8D,$1C,$81,$14,$00,$1C
        db $81,$14,$00,$58,$81,$98,$89,$18
        db $8D,$1C,$84,$14,$81,$58,$81,$98
        db $81,$18,$00,$D8,$81,$98,$00,$D8
        db $82,$98,$8C,$1C,$84,$14,$83,$58
        db $82,$98,$03,$D8,$1C,$18,$58,$81
        db $1C,$00,$18,$89,$1C,$81,$14,$00
        db $1C,$85,$14,$83,$58,$81,$1C,$03
        db $18,$1C,$98,$D8,$81,$1C,$00,$98
        db $89,$1C,$81,$14,$84,$1C,$82,$14
        db $82,$58,$81,$1C,$03,$18,$1C,$58
        db $18,$81,$1C,$00,$58,$86,$1C,$83
        db $10,$83,$50,$86,$10,$82,$50,$82
        db $10,$03,$50,$10,$50,$14,$86,$1C
        db $83,$10,$83,$18,$84,$90,$06,$10
        db $50,$10,$50,$10,$50,$10,$81,$50
        db $02,$D0,$10,$14,$86,$1C,$83,$10
        db $00,$90,$81,$18,$07,$D0,$10,$50
        db $10,$50,$10,$50,$10,$81,$50,$03
        db $10,$50,$10,$50,$81,$D0,$00,$18
        db $87,$1C,$82,$10,$82,$90,$82,$10
        db $0A,$50,$10,$50,$10,$50,$10,$50
        db $10,$50,$90,$10,$81,$50,$01,$1C
        db $18,$87,$1C,$07,$10,$50,$14,$54
        db $58,$18,$90,$10,$83,$50,$83,$10
        db $02,$50,$90,$10,$82,$50,$02,$1C
        db $18,$94,$86,$1C,$03,$50,$90,$50
        db $54,$81,$14,$01,$54,$10,$83,$18
        db $84,$90,$00,$10,$81,$50,$02,$D0
        db $10,$1C,$83,$14,$84,$1C,$00,$58
        db $81,$90,$00,$50,$81,$58,$02,$54
        db $10,$90,$81,$18,$00,$D0,$81,$10
        db $07,$50,$10,$50,$10,$50,$10,$D0
        db $18,$81,$14,$00,$1C,$81,$14,$84
        db $1C,$01,$58,$1C,$81,$90,$81,$50
        db $83,$10,$00,$50,$81,$10,$01,$50
        db $10,$81,$50,$81,$10,$81,$D0,$01
        db $18,$14,$81,$1C,$81,$58,$81,$14
        db $81,$1C,$01,$D4,$58,$81,$1C,$81
        db $90,$00,$50,$83,$10,$00,$50,$81
        db $10,$03,$50,$10,$50,$10,$82,$D0
        db $02,$58,$18,$94,$81,$1C,$81,$58
        db $81,$14,$81,$1C,$81,$54,$82,$1C
        db $8B,$90,$81,$D0,$02,$1C,$18,$1C
        db $81,$14,$81,$1C,$81,$58,$81,$14
        db $82,$1C,$81,$54,$83,$1C,$00,$58
        db $87,$1C,$00,$18,$82,$1C,$00,$18
        db $81,$14,$82,$1C,$81,$58,$81,$14
        db $83,$1C,$84,$18,$01,$58,$1C,$82
        db $10,$00,$50,$83,$1C,$00,$58,$81
        db $1C,$01,$18,$14,$83,$1C,$00,$58
        db $81,$14,$84,$1C,$84,$18,$01,$58
        db $1C,$81,$10,$81,$50,$82,$1C,$00
        db $18,$82,$1C,$81,$14,$83,$1C,$82
        db $14,$84,$1C,$83,$18,$02,$98,$D8
        db $1C,$81,$90,$01,$D0,$50,$81,$1C
        db $81,$18,$00,$58,$81,$14,$81,$10
        db $00,$50,$82,$1C,$00,$14,$81,$1C
        db $81,$18,$00,$58,$81,$1C,$81,$98
        db $82,$18,$02,$58,$14,$50,$81,$90
        db $00,$10,$81,$14,$07,$58,$98,$18
        db $14,$1C,$50,$90,$10,$85,$1C,$81
        db $18,$01,$58,$18,$81,$58,$82,$18
        db $81,$D8,$00,$1C,$81,$58,$81,$18
        db $81,$1C,$81,$58,$00,$18,$81,$1C
        db $02,$58,$1C,$18,$85,$1C,$88,$18
        db $02,$58,$18,$1C,$81,$58,$81,$18
        db $81,$1C,$81,$58,$00,$18,$81,$1C
        db $02,$58,$1C,$18,$82,$1C,$8B,$18
        db $02,$58,$18,$D4,$81,$58,$81,$18
        db $01,$94,$1C,$81,$58,$06,$18,$1C
        db $D4,$58,$1C,$18,$94,$81,$1C,$8B
        db $18,$01,$58,$18,$81,$54,$01,$58
        db $18,$81,$14,$00,$D4,$81,$58,$01
        db $18,$94,$81,$54,$00,$1C,$81,$14
        db $81,$1C,$8B,$18,$81,$58,$01,$1C
        db $54,$82,$14,$00,$1C,$81,$54,$00
        db $58,$81,$14,$01,$1C,$54,$81,$14
        db $82,$1C,$8C,$18,$00,$58,$81,$18
        db $00,$58,$83,$1C,$00,$54,$81,$14
        db $87,$1C,$8F,$18,$81,$58,$8D,$1C
        db $90,$18,$02,$58,$18,$58,$8B,$1C
        db $91,$18,$81,$D8,$81,$1C,$81,$14
        db $87,$1C,$91,$18,$02,$58,$18,$1C
        db $82,$14,$87,$1C,$91,$18,$81,$58
        db $00,$1C,$81,$14,$88,$1C,$91,$18
        db $81,$D8,$8B,$1C,$88,$18,$00,$D8
        db $84,$98,$81,$18,$81,$D8,$00,$18
        db $81,$14,$82,$1C,$81,$14,$84,$1C
        db $88,$18,$00,$58,$83,$1C,$81,$98
        db $81,$D8,$81,$18,$86,$14,$84,$1C
        db $81,$18,$82,$98,$00,$D8,$81,$98
        db $01,$18,$58,$83,$1C,$02,$58,$98
        db $D8,$82,$18,$00,$58,$83,$14,$86
        db $1C,$01,$98,$D8,$81,$1C,$02,$98
        db $D8,$1C,$81,$18,$00,$58,$83,$1C
        db $81,$58,$83,$18,$83,$14,$88,$1C
        db $00,$18,$81,$1C,$02,$58,$18,$1C
        db $81,$98,$00,$D8,$83,$1C,$81,$58
        db $82,$18,$82,$14,$89,$1C,$83,$14
        db $00,$50,$83,$10,$82,$50,$81,$10
        db $00,$14,$81,$18,$8C,$14,$81,$10
        db $83,$14,$00,$50,$83,$10,$82,$50
        db $82,$10,$81,$18,$85,$10,$81,$18
        db $84,$14,$81,$10,$81,$14,$81,$18
        db $00,$50,$83,$10,$82,$50,$82,$10
        db $81,$18,$81,$10,$01,$50,$10,$83
        db $18,$84,$14,$81,$10,$81,$14,$81
        db $18,$00,$50,$83,$10,$83,$50,$81
        db $10,$81,$18,$81,$10,$01,$50,$10
        db $83,$18,$84,$14,$81,$10,$81,$14
        db $81,$18,$00,$50,$83,$10,$81,$50
        db $03,$10,$50,$10,$90,$82,$18,$01
        db $10,$50,$82,$10,$82,$18,$83,$14
        db $81,$10,$01,$14,$10,$81,$18,$00
        db $50,$81,$10,$81,$90,$81,$D0,$81
        db $50,$81,$10,$82,$18,$85,$10,$81
        db $18,$00,$50,$82,$14,$81,$10,$01
        db $14,$10,$81,$18,$81,$50,$82,$10
        db $82,$50,$82,$10,$82,$18,$00,$10
        db $81,$50,$01,$10,$D0,$82,$10,$00
        db $50,$82,$14,$81,$10,$02,$14,$50
        db $90,$81,$10,$81,$50,$81,$10,$81
        db $50,$81,$10,$85,$18,$82,$50,$01
        db $10,$50,$81,$10,$00,$50,$82,$14
        db $81,$10,$02,$14,$54,$10,$81,$18
        db $01,$D0,$50,$81,$10,$81,$50,$01
        db $10,$90,$86,$18,$81,$50,$04,$10
        db $50,$10,$D0,$10,$82,$14,$81,$10
        db $02,$14,$54,$10,$81,$18,$81,$50
        db $81,$10,$81,$50,$81,$10,$85,$18
        db $82,$10,$00,$90,$82,$D0,$83,$14
        db $81,$10,$01,$D4,$54,$83,$10,$00
        db $50,$81,$10,$01,$50,$10,$87,$18
        db $83,$10,$82,$50,$83,$14,$81,$10
        db $81,$54,$82,$10,$00,$50,$81,$10
        db $02,$50,$90,$10,$81,$18,$00,$10
        db $83,$18,$81,$10,$07,$18,$10,$50
        db $90,$10,$50,$14,$94,$81,$14,$81
        db $10,$08,$14,$54,$10,$50,$10,$90
        db $10,$50,$90,$81,$10,$84,$50,$81
        db $18,$07,$10,$50,$10,$50,$90,$10
        db $18,$50,$83,$14,$81,$10,$81,$14
        db $81,$10,$04,$90,$50,$10,$50,$90
        db $85,$10,$00,$50,$81,$18,$01,$90
        db $D0,$81,$90,$03,$10,$18,$10,$50
        db $83,$14,$81,$D0,$81,$14,$83,$90
        db $01,$50,$90,$81,$18,$00,$50,$84
        db $10,$81,$18,$01,$10,$50,$81,$10
        db $81,$90,$81,$D0,$83,$14,$81,$50
        db $81,$14,$00,$54,$81,$14,$81,$10
        db $00,$50,$81,$18,$00,$50,$82,$10
        db $01,$50,$10,$81,$18,$03,$10,$50
        db $18,$50,$87,$14,$81,$50,$81,$14
        db $00,$54,$81,$14,$81,$10,$05,$50
        db $10,$50,$90,$D0,$90,$82,$D0,$05
        db $10,$50,$10,$50,$10,$50,$87,$14
        db $81,$50,$02,$14,$D4,$54,$81,$14
        db $02,$10,$90,$D0,$81,$90,$85,$10
        db $81,$D0,$03,$90,$D0,$10,$50,$83
        db $14,$00,$94,$82,$14,$81,$50,$00
        db $14,$82,$54,$01,$14,$50,$8E,$90
        db $00,$10,$87,$14,$81,$50,$82,$14
        db $01,$54,$14,$81,$50,$8E,$10,$87
        db $14,$81,$50,$84,$14,$81,$50,$8E
        db $10,$87,$14,$81,$50,$00,$10,$81
        db $50,$86,$10,$00,$50,$88,$10,$00
        db $50,$83,$10,$00,$50,$81,$10,$81
        db $50,$8B,$10,$00,$50,$83,$10,$00
        db $D0,$86,$10,$00,$50,$82,$10,$82
        db $50,$84,$10,$01,$50,$90,$83,$10
        db $04,$D0,$10,$50,$10,$50,$87,$10
        db $83,$50,$81,$10,$81,$50,$84,$10
        db $00,$50,$83,$90,$81,$D0,$01,$10
        db $50,$84,$10,$00,$50,$85,$10,$81
        db $50,$81,$10,$81,$50,$82,$10,$01
        db $D0,$10,$81,$50,$82,$10,$00,$50
        db $81,$10,$00,$50,$83,$10,$01,$90
        db $D0,$83,$90,$00,$D0,$81,$10,$84
        db $50,$83,$10,$82,$50,$82,$10,$00
        db $50,$81,$10,$00,$50,$81,$18,$88
        db $10,$02,$D0,$90,$10,$83,$50,$84
        db $10,$82,$50,$85,$10,$81,$18,$86
        db $90,$83,$10,$01,$50,$10,$82,$50
        db $86,$10,$00,$50,$82,$10,$00,$D0
        db $81,$10,$02,$18,$D8,$50,$84,$10
        db $82,$90,$81,$10,$01,$50,$10,$82
        db $50,$85,$10,$00,$D0,$82,$90,$81
        db $D0,$81,$10,$81,$D8,$00,$50,$86
        db $10,$82,$90,$02,$D0,$10,$50,$86
        db $10,$00,$D0,$87,$10,$02,$58,$14
        db $50,$84,$10,$02,$50,$10,$50,$81
        db $10,$00,$50,$87,$10,$81,$D0,$85
        db $10,$03,$50,$D8,$58,$14,$81,$54
        db $88,$10,$00,$50,$8B,$10,$00,$50
        db $96,$10,$81,$14,$85,$10,$81,$50
        db $95,$10,$81,$14,$01,$10,$50,$84
        db $10,$00,$50,$95,$10,$81,$14,$01
        db $90,$D0,$81,$90,$82,$10,$00,$50
        db $91,$10,$81,$50,$81,$10,$81,$14
        db $01,$10,$50,$81,$10,$83,$D0,$92
        db $10,$00,$50,$81,$10,$81,$14,$01
        db $10,$50,$81,$10,$00,$D0,$81,$50
        db $00,$10,$8E,$18,$86,$10,$81,$14
        db $82,$10,$81,$D0,$81,$50,$00,$10
        db $8E,$18,$01,$50,$90,$84,$10,$81
        db $14,$81,$10,$81,$D0,$81,$10,$01
        db $50,$10,$8E,$18,$00,$50,$82,$90
        db $82,$10,$81,$14,$81,$10,$81,$50
        db $81,$10,$01,$50,$10,$86,$18,$00
        db $58,$84,$18,$01,$D8,$98,$82,$50
        db $00,$90,$82,$D0,$81,$14,$81,$10
        db $81,$50,$81,$10,$01,$50,$10,$86
        db $18,$00,$58,$83,$18,$81,$D8,$87
        db $50,$81,$14,$81,$10,$81,$50,$81
        db $10,$03,$50,$10,$18,$58,$84,$18
        db $00,$58,$82,$18,$81,$58,$81,$14
        db $86,$50,$81,$14,$82,$10,$00,$50
        db $81,$10,$03,$50,$10,$98,$D8,$83
        db $98,$85,$18,$01,$58,$14,$81,$54
        db $85,$50,$81,$14,$81,$10,$01,$D0
        db $10,$81,$50,$82,$18,$00,$58,$83
        db $18,$01,$98,$D8,$81,$18,$01,$98
        db $D8,$81,$58,$81,$18,$81,$58,$83
        db $50,$81,$14,$82,$D0,$00,$10,$84
        db $18,$00,$58,$8A,$18,$00,$58,$83
        db $18,$00,$58,$82,$50,$81,$14,$82
        db $50,$00,$10,$84,$18,$00,$58,$84
        db $18,$00,$58,$82,$18,$00,$58,$82
        db $18,$00,$58,$85,$18,$81,$14,$03
        db $50,$10,$50,$10,$81,$98,$81,$18
        db $01,$98,$D8,$83,$98,$81,$18,$82
        db $98,$00,$D8,$82,$98,$00,$D8,$81
        db $98,$00,$D8,$82,$18,$81,$14,$04
        db $50,$10,$50,$10,$50,$81,$98,$86
        db $18,$01,$98,$D8,$8A,$18,$81,$D8
        db $00,$18,$81,$14,$82,$50,$02,$10
        db $14,$54,$82,$98,$01,$10,$50,$86
        db $18,$01,$10,$50,$81,$18,$04,$10
        db $50,$18,$10,$50,$82,$18,$81,$14
        db $04,$50,$10,$50,$10,$18,$81,$54
        db $00,$50,$81,$10,$81,$50,$81,$18
        db $84,$10,$00,$50,$82,$10,$00,$50
        db $81,$10,$00,$50,$82,$18,$81,$14
        db $82,$50,$03,$10,$94,$18,$54,$83
        db $10,$00,$50,$8D,$10,$00,$50,$82
        db $10,$81,$14,$02,$50,$10,$50,$81
        db $14,$00,$18,$97,$10,$81,$14,$9D
        db $10,$81,$50,$9D,$10,$81,$50,$9D
        db $10,$81,$50,$9D,$10,$81,$50,$9D
        db $10,$81,$50,$82,$10,$00,$14,$81
        db $10,$81,$14,$81,$10,$82,$14,$81
        db $10,$00,$14,$81,$10,$00,$14,$81
        db $10,$00,$14,$81,$10,$00,$14,$88
        db $10,$08,$14,$10,$14,$10,$14,$10
        db $14,$10,$14,$82,$10,$0A,$14,$10
        db $14,$10,$14,$10,$14,$10,$14,$10
        db $14,$88,$10,$00,$14,$82,$10,$04
        db $14,$10,$14,$10,$14,$82,$10,$00
        db $14,$82,$10,$06,$14,$10,$14,$10
        db $14,$10,$14,$89,$10,$00,$14,$81
        db $10,$03,$14,$10,$14,$10,$82,$14
        db $01,$10,$14,$82,$10,$01,$14,$10
        db $82,$14,$01,$10,$14,$8A,$10,$01
        db $14,$10,$81,$14,$81,$10,$00,$14
        db $82,$10,$00,$14,$82,$10,$06,$14
        db $10,$14,$10,$14,$10,$14,$88,$10
        db $04,$14,$10,$14,$10,$14,$82,$10
        db $00,$14,$82,$10,$0A,$14,$10,$14
        db $10,$14,$10,$14,$10,$14,$10,$14
        db $86,$10,$81,$90,$87,$10,$82,$18
        db $81,$58,$00,$54,$83,$14,$81,$54
        db $00,$50,$81,$10,$00,$50,$88,$10
        db $00,$50,$83,$10,$85,$18,$00,$58
        db $85,$18,$81,$54,$02,$10,$90,$D0
        db $87,$10,$81,$50,$8A,$18,$00,$94
        db $85,$18,$82,$10,$00,$50,$87,$10
        db $81,$50,$88,$18,$00,$58,$81,$14
        db $85,$18,$82,$10,$00,$50,$88,$10
        db $81,$50,$85,$18,$03,$58,$18,$58
        db $14,$86,$18,$82,$10,$00,$50,$89
        db $10,$81,$50,$83,$18,$03,$98,$D8
        db $98,$58,$87,$18,$83,$10,$00,$50
        db $89,$10,$03,$50,$18,$10,$50,$81
        db $18,$01,$58,$18,$81,$58,$86,$18
        db $01,$10,$90,$81,$10,$00,$D0,$89
        db $10,$00,$50,$81,$10,$81,$50,$05
        db $18,$58,$18,$10,$50,$58,$81,$18
        db $85,$10,$01,$50,$90,$8E,$10,$00
        db $50,$83,$10,$00,$50,$87,$10,$01
        db $50,$90,$9B,$10,$82,$90,$87,$10
        db $81,$1C,$00,$5C,$81,$1C,$81,$5C
        db $81,$1C,$81,$5C,$00,$10,$81,$1C
        db $81,$5C,$01,$10,$50,$81,$1C,$81
        db $5C,$81,$1C,$81,$5C,$01,$10,$50
        db $81,$10,$81,$1C,$82,$10,$81,$1C
        db $81,$5C,$81,$1C,$81,$5C,$00,$10
        db $81,$1C,$81,$5C,$01,$10,$50,$81
        db $1C,$81,$5C,$81,$1C,$81,$5C,$01
        db $10,$50,$81,$10,$83,$1C,$81,$5C
        db $00,$1C,$81,$5C,$81,$1C,$81,$5C
        db $00,$10,$81,$1C,$81,$5C,$01,$10
        db $50,$81,$1C,$81,$5C,$81,$1C,$00
        db $5C,$81,$1C,$81,$5C,$00,$10,$83
        db $1C,$81,$5C,$84,$10,$00,$50,$86
        db $10,$00,$50,$81,$1C,$81,$5C,$82
        db $10,$81,$1C,$81,$5C,$00,$10,$83
        db $1C,$81,$5C,$81,$1C,$81,$5C,$01
        db $10,$50,$82,$10,$06,$50,$10,$50
        db $10,$50,$10,$50,$81,$10,$81,$1C
        db $81,$5C,$03,$1C,$5C,$1C,$10,$83
        db $1C,$81,$5C,$81,$1C,$81,$5C,$84
        db $10,$08,$50,$10,$50,$90,$D0,$10
        db $50,$10,$50,$81,$1C,$81,$5C,$83
        db $10,$83,$1C,$81,$5C,$81,$1C,$81
        db $5C,$82,$10,$02,$50,$10,$50,$86
        db $10,$00,$50,$81,$1C,$81,$5C,$81
        db $1C,$01,$5C,$10,$83,$1C,$81,$5C
        db $81,$1C,$81,$5C,$82,$10,$02,$50
        db $10,$50,$81,$1C,$81,$5C,$03,$10
        db $50,$10,$50,$81,$1C,$81,$5C,$81
        db $1C,$01,$5C,$10,$83,$1C,$81,$5C
        db $81,$1C,$81,$5C,$82,$10,$02,$50
        db $10,$50,$81,$1C,$81,$5C,$03,$10
        db $50,$10,$50,$81,$1C,$81,$5C,$81
        db $1C,$01,$5C,$10,$83,$1C,$81,$5C
        db $81,$1C,$81,$5C,$82,$10,$02,$50
        db $10,$50,$81,$1C,$81,$5C,$83,$10
        db $81,$1C,$81,$5C,$83,$10,$83,$1C
        db $00,$5C,$81,$1C,$81,$5C,$81,$10
        db $00,$50,$82,$10,$02,$50,$10,$50
        db $81,$10,$09,$50,$10,$14,$54,$10
        db $50,$10,$50,$10,$50,$81,$10,$81
        db $1C,$82,$10,$81,$1C,$81,$5C,$81
        db $10,$00,$50,$82,$10,$02,$50,$10
        db $50,$81,$10,$09,$50,$10,$94,$D4
        db $10,$50,$10,$50,$10,$50,$81,$10
        db $81,$18,$81,$1C,$81,$5C,$00,$1C
        db $81,$5C,$83,$10,$00,$50,$83,$10
        db $00,$50,$81,$10,$00,$50,$82,$10
        db $00,$50,$81,$1C,$81,$5C,$83,$10
        db $81,$1C,$81,$5C,$01,$10,$50,$84
        db $10,$00,$50,$81,$10,$02,$50,$10
        db $50,$81,$10,$00,$50,$82,$10,$00
        db $50,$81,$1C,$81,$5C,$83,$10,$81
        db $1C,$81,$5C,$05,$10,$50,$10,$50
        db $10,$50,$83,$10,$00,$50,$81,$10
        db $00,$50,$81,$10,$00,$50,$81,$1C
        db $81,$5C,$00,$1C,$81,$5C,$81,$10
        db $81,$18,$01,$10,$50,$81,$1C,$81
        db $5C,$03,$10,$50,$10,$50,$81,$1C
        db $81,$5C,$82,$10,$00,$50,$81,$10
        db $00,$50,$81,$1C,$81,$5C,$81,$10
        db $00,$50,$84,$10,$00,$50,$81,$1C
        db $81,$5C,$03,$10,$50,$10,$50,$81
        db $1C,$81,$5C,$03,$10,$50,$10,$50
        db $81,$1C,$81,$5C,$00,$1C,$81,$5C
        db $81,$10,$00,$50,$85,$10,$81,$1C
        db $81,$5C,$03,$10,$50,$10,$50,$81
        db $1C,$81,$5C,$03,$10,$50,$10,$50
        db $81,$1C,$81,$5C,$01,$10,$50,$81
        db $1C,$81,$5C,$85,$10,$00,$50,$82
        db $10,$02,$50,$10,$50,$81,$10,$00
        db $50,$81,$1C,$81,$5C,$81,$10,$81
        db $1C,$81,$5C,$01,$10,$50,$81,$1C
        db $81,$5C,$81,$10,$81,$18,$81,$10
        db $00,$50,$82,$10,$02,$50,$10,$50
        db $81,$10,$00,$50,$81,$1C,$81,$5C
        db $01,$10,$50,$81,$1C,$81,$5C,$01
        db $10,$50,$81,$1C,$81,$5C,$81,$10
        db $81,$18,$00,$10,$81,$1C,$81,$5C
        db $81,$10,$81,$1C,$81,$5C,$00,$10
        db $81,$1C,$81,$5C,$01,$10,$50,$81
        db $1C,$81,$5C,$01,$10,$50,$87,$10
        db $83,$14,$00,$50,$83,$10,$82,$50
        db $81,$10,$8F,$14,$84,$10,$00,$14
        db $81,$10,$00,$14,$82,$10,$82,$14
        db $81,$10,$00,$14,$81,$10,$05,$14
        db $10,$14,$10,$14,$10,$82,$14,$82
        db $10,$81,$90,$A5,$10,$01,$54,$14
        db $83,$10,$01,$54,$14,$83,$10,$01
        db $54,$14,$83,$10,$01,$54,$14,$8B
        db $10,$01,$D4,$94,$83,$10,$01,$D4
        db $94,$83,$10,$01,$D4,$94,$83,$10
        db $01,$D4,$94,$C8,$10,$82,$50,$01
        db $10,$50,$83,$10,$01,$54,$14,$83
        db $10,$01,$54,$14,$83,$10,$01,$54
        db $14,$87,$10,$00,$90,$82,$D0,$01
        db $90,$D0,$83,$10,$01,$D4,$94,$83
        db $10,$01,$D4,$94,$83,$10,$01,$D4
        db $94,$C5,$10,$83,$1C,$00,$14,$88
        db $1C,$01,$18,$58,$81,$1C,$01,$54
        db $14,$89,$1C,$81,$10,$81,$1C,$81
        db $14,$86,$1C,$08,$14,$1C,$18,$10
        db $50,$58,$1C,$D4,$94,$82,$1C,$00
        db $14,$85,$1C,$81,$10,$00,$1C,$82
        db $14,$82,$1C,$01,$54,$14,$82,$1C
        db $00,$18,$81,$10,$81,$50,$00,$58
        db $8B,$1C,$81,$10,$00,$1C,$82,$14
        db $82,$1C,$01,$D4,$94,$82,$1C,$81
        db $10,$00,$90,$81,$10,$03,$50,$58
        db $1C,$14,$83,$1C,$01,$54,$14,$82
        db $1C,$81,$10,$8A,$1C,$00,$18,$82
        db $10,$00,$D0,$81,$10,$00,$50,$85
        db $1C,$01,$D4,$94,$82,$1C,$81,$10
        db $82,$1C,$87,$18,$84,$10,$02,$D0
        db $10,$50,$86,$18,$00,$58,$82,$1C
        db $81,$10,$02,$54,$14,$1C,$81,$10
        db $00,$50,$84,$10,$00,$50,$84,$10
        db $02,$D0,$10,$50,$84,$10,$81,$50
        db $82,$1C,$81,$10,$05,$D4,$94,$1C
        db $10,$90,$D0,$84,$90,$00,$D0,$85
        db $10,$01,$90,$D0,$84,$10,$01,$D0
        db $50,$82,$1C,$81,$10,$82,$1C,$00
        db $50,$87,$10,$00,$18,$83,$10,$00
        db $18,$84,$10,$02,$50,$90,$D0,$83
        db $1C,$81,$10,$04,$1C,$14,$1C,$50
        db $90,$85,$10,$00,$18,$85,$10,$00
        db $18,$82,$10,$03,$50,$90,$D0,$DC
        db $83,$1C,$81,$10,$82,$1C,$02,$50
        db $10,$50,$82,$10,$02,$50,$10,$18
        db $85,$10,$00,$18,$82,$10,$01,$90
        db $D0,$85,$1C,$81,$10,$82,$18,$00
        db $50,$81,$10,$00,$90,$81,$10,$00
        db $D0,$81,$10,$00,$18,$83,$10,$00
        db $18,$81,$10,$06,$90,$D0,$10,$5C
        db $1C,$5C,$1C,$82,$18,$84,$10,$02
        db $50,$10,$50,$88,$10,$00,$50,$83
        db $10,$00,$50,$81,$10,$00,$5C,$82
        db $1C,$82,$18,$83,$10,$06,$18,$50
        db $10,$D0,$10,$50,$90,$84,$10,$00
        db $90,$84,$10,$00,$50,$81,$10,$01
        db $50,$9C,$81,$1C,$84,$10,$81,$18
        db $01,$10,$50,$81,$10,$01,$50,$90
        db $85,$10,$01,$D0,$90,$81,$D0,$85
        db $10,$02,$50,$5C,$1C,$82,$18,$82
        db $10,$81,$18,$03,$D0,$10,$50,$90
        db $85,$10,$01,$D0,$1C,$82,$90,$81
        db $D0,$85,$10,$00,$9C,$8F,$10,$05
        db $D0,$9C,$DC,$1C,$50,$10,$81,$90
        db $00,$10,$81,$D0,$82,$10,$02,$50
        db $10,$50,$87,$10,$01,$90,$D0,$81
        db $10,$00,$D0,$81,$9C,$83,$1C,$00
        db $50,$81,$10,$01,$50,$D0,$81,$10
        db $81,$D0,$03,$10,$D0,$10,$50,$83
        db $10,$00,$18,$84,$10,$02,$D0,$9C
        db $DC,$82,$1C,$00,$5C,$81,$1C,$00
        db $50,$82,$10,$83,$D0,$00,$90,$82
        db $10,$00,$1C,$83,$10,$81,$18,$81
        db $90,$81,$9C,$02,$DC,$1C,$5C,$82
        db $1C,$00,$5C,$81,$1C,$82,$10,$00
        db $50,$83,$10,$00,$50,$81,$90,$01
        db $DC,$1C,$85,$10,$02,$50,$10,$5C
        db $86,$1C,$00,$5C,$81,$1C,$00,$50
        db $86,$10,$00,$50,$81,$10,$81,$1C
        db $89,$10,$00,$50,$96,$10,$81,$14
DATA_04D678:
        db $00,$C0,$C0,$C0,$30,$C0,$C0,$00
        db $C0,$20,$30,$C0,$C0,$C0,$C0,$D0
        db $40,$40,$40,$D0,$40,$80,$80,$00
        db $00,$00,$00,$40,$00,$80,$20,$80
        db $40,$40,$80,$60,$90,$00,$00,$C0
        db $00,$00,$00,$C0,$40,$20,$40,$C0
        db $E0,$C0,$00,$C0,$00,$00,$C0,$20
        db $80,$80,$80,$80,$30,$40,$E0,$00
        db $40,$E0,$E0,$D0,$70,$FF,$40,$90
        db $55,$80,$80,$80,$80,$00,$C0,$C0
        db $C0,$C0,$40,$00,$80,$A0,$30,$AA
        db $60,$D0,$80,$00,$55,$55,$00,$00
        db $AA,$55,$FF,$FF,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00

CODE_04D6E9:
        REP #$30
        STZ $1C                                 ;$04D6EB        |
        LDA.w #$FFFF                            ;$04D6ED        |
        STA $4D                                 ;$04D6F0        |
        STA $4F                                 ;$04D6F2        |
        LDA.w #$0202                            ;$04D6F4        |
        STA $55                                 ;$04D6F7        |
        LDA.w $0DD6                             ;$04D6F9        |
        LSR                                     ;$04D6FC        |
        LSR                                     ;$04D6FD        |
        AND.w #$00FF                            ;$04D6FE        |
        TAX                                     ;$04D701        |
        LDA.w $1F11,X                           ;$04D702        |
        AND.w #$000F                            ;$04D705        |
        BEQ CODE_04D714                         ;$04D708        |
        LDA.w #$0020                            ;$04D70A        |
        STA $47                                 ;$04D70D        |
        LDA.w #$0200                            ;$04D70F        |
        STA $1C                                 ;$04D712        |
CODE_04D714:
        JSL CODE_05881A
        JSL generic_layer_1_and_2_upload        ;$04D718        |
        REP #$30                                ;$04D71C        |
        INC $47                                 ;$04D71E        |
        LDA $1C                                 ;$04D720        |
        CLC                                     ;$04D722        |
        ADC.w #$0010                            ;$04D723        |
        STA $1C                                 ;$04D726        |
        AND.w #$01FF                            ;$04D728        |
        BNE CODE_04D714                         ;$04D72B        |
        LDA $20                                 ;$04D72D        |
        STA $1C                                 ;$04D72F        |
        STZ $47                                 ;$04D731        |
        STZ.w $1925                             ;$04D733        |
        STZ $5B                                 ;$04D736        |
        LDA.w #$FFFF                            ;$04D738        |
        STA $4D                                 ;$04D73B        |
        STA $4F                                 ;$04D73D        |
        SEP #$30                                ;$04D73F        |
        LDA.b #$80                              ;$04D741        |
        STA.w $2115                             ;$04D743        |
        STZ.w $2116                             ;$04D746        |
        LDA.b #$30                              ;$04D749        |
        STA.w $2117                             ;$04D74B        |
        LDX.b #$06                              ;$04D74E        |
CODE_04D750:
        LDA.l DATA_04DAB3,X
        STA.w $4310,X                           ;$04D754        |
        DEX                                     ;$04D757        |
        BPL CODE_04D750                         ;$04D758        |
        LDA.w $0DD6                             ;$04D75A        |
        LSR                                     ;$04D75D        |
        LSR                                     ;$04D75E        |
        TAX                                     ;$04D75F        |
        LDA.w $1F11,X                           ;$04D760        |
        BEQ CODE_04D76A                         ;$04D763        |
        LDA.b #$60                              ;$04D765        |
        STA.w $4313                             ;$04D767        |
CODE_04D76A:
        LDA.b #$02
        STA.w $420B                             ;$04D76C        |
        RTL                                     ;$04D76F        |

CODE_04D770:
        STA.l $7FC800,X
        STA.l $7FC9B0,X                         ;$04D774        |
        STA.l $7FCB60,X                         ;$04D778        |
        STA.l $7FCD10,X                         ;$04D77C        |
        STA.l $7FCEC0,X                         ;$04D780        |
        STA.l $7FD070,X                         ;$04D784        |
        STA.l $7FD220,X                         ;$04D788        |
        STA.l $7FD3D0,X                         ;$04D78C        |
        STA.l $7FD580,X                         ;$04D790        |
        STA.l $7FD730,X                         ;$04D794        |
        STA.l $7FD8E0,X                         ;$04D798        |
        STA.l $7FDA90,X                         ;$04D79C        |
        STA.l $7FDC40,X                         ;$04D7A0        |
        STA.l $7FDDF0,X                         ;$04D7A4        |
        STA.l $7FDFA0,X                         ;$04D7A8        |
        STA.l $7FE150,X                         ;$04D7AC        |
        STA.l $7FE300,X                         ;$04D7B0        |
        STA.l $7FE4B0,X                         ;$04D7B4        |
        STA.l $7FE660,X                         ;$04D7B8        |
        STA.l $7FE810,X                         ;$04D7BC        |
        STA.l $7FE9C0,X                         ;$04D7C0        |
        STA.l $7FEB70,X                         ;$04D7C4        |
        STA.l $7FED20,X                         ;$04D7C8        |
        STA.l $7FEED0,X                         ;$04D7CC        |
        STA.l $7FF080,X                         ;$04D7D0        |
        STA.l $7FF230,X                         ;$04D7D4        |
        STA.l $7FF3E0,X                         ;$04D7D8        |
        STA.l $7FF590,X                         ;$04D7DC        |
        STA.l $7FF740,X                         ;$04D7E0        |
        STA.l $7FF8F0,X                         ;$04D7E4        |
        STA.l $7FFAA0,X                         ;$04D7E8        |
        STA.l $7FFC50,X                         ;$04D7EC        |
        INX                                     ;$04D7F0        |
        RTS                                     ;$04D7F1        |

CODE_04D7F2:
        REP #$30
        LDA.w #$0000                            ;$04D7F4        |
        SEP #$20                                ;$04D7F7        |
        LDA.b #$00                              ;$04D7F9        |
        STA $0D                                 ;$04D7FB        |
        LDA.b #$D0                              ;$04D7FD        |
        STA $0E                                 ;$04D7FF        |
        LDA.b #$7E                              ;$04D801        |
        STA $0F                                 ;$04D803        |
        LDA.b #$00                              ;$04D805        |
        STA $0A                                 ;$04D807        |
        LDA.b #$D8                              ;$04D809        |
        STA $0B                                 ;$04D80B        |
        LDA.b #$7E                              ;$04D80D        |
        STA $0C                                 ;$04D80F        |
        LDA.b #$00                              ;$04D811        |
        STA $04                                 ;$04D813        |
        LDA.b #$C8                              ;$04D815        |
        STA $05                                 ;$04D817        |
        LDA.b #$7E                              ;$04D819        |
        STA $06                                 ;$04D81B        |
        LDY.w #$0001                            ;$04D81D        |
        STY $00                                 ;$04D820        |
        LDY.w #$07FF                            ;$04D822        |
        LDA.b #$00                              ;$04D825        |
CODE_04D827:
        STA [$0A],Y
        STA [$0D],Y                             ;$04D829        |
        DEY                                     ;$04D82B        |
        BPL CODE_04D827                         ;$04D82C        |
        LDY.w #$0000                            ;$04D82E        |
        TYX                                     ;$04D831        |
CODE_04D832:
        LDA [$04],Y
        CMP.b #$56                              ;$04D834        |
        BCC CODE_04D849                         ;$04D836        |
        CMP.b #$81                              ;$04D838        |
        BCS CODE_04D849                         ;$04D83A        |
        LDA $00                                 ;$04D83C        |
        STA [$0D],Y                             ;$04D83E        |
        TAX                                     ;$04D840        |
        LDA.l DATA_04D678,X                     ;$04D841        |
        STA [$0A],Y                             ;$04D845        |
        INC $00                                 ;$04D847        |
CODE_04D849:
        INY
        CPY.w #$0800                            ;$04D84A        |
        BNE CODE_04D832                         ;$04D84D        |
        STZ $0F                                 ;$04D84F        |
CODE_04D851:
        JSR CODE_04DA49
        INC $0F                                 ;$04D854        |
        LDA $0F                                 ;$04D856        |
        CMP.b #$6F                              ;$04D858        |
        BNE CODE_04D851                         ;$04D85A        |
        RTS                                     ;$04D85C        |

DATA_04D85D:
        db $00,$00,$00,$00,$00,$00,$69,$04
        db $4B,$04,$29,$04,$09,$04,$D3,$00
        db $E5,$00,$A5,$00,$D1,$00,$85,$00
        db $A9,$00,$CB,$00,$BD,$00,$9D,$00
        db $A5,$00,$07,$02,$00,$00,$27,$02
        db $12,$05,$08,$06,$E3,$04,$C8,$04
        db $2A,$06,$EC,$04,$0C,$06,$1C,$06
        db $4A,$06,$00,$00,$E0,$04,$3E,$00
        db $30,$01,$34,$01,$36,$01,$3A,$01
        db $00,$00,$57,$01,$84,$01,$3A,$01
        db $00,$00,$00,$00,$AA,$06,$76,$06
        db $C8,$06,$AC,$06,$76,$06,$00,$00
        db $00,$00,$A4,$06,$AA,$06,$C4,$06
        db $00,$00,$04,$03,$00,$00,$00,$00
        db $79,$05,$77,$05,$59,$05,$74,$05
        db $00,$00,$54,$05,$00,$00,$34,$05
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$B3,$03,$00,$00
        db $00,$00,$00,$00,$DF,$02,$DC,$02
        db $00,$00,$7E,$02,$00,$00,$00,$00
        db $00,$00,$E0,$04,$E0,$04,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$34,$05,$34,$05
        db $00,$00,$00,$00,$87,$07,$00,$00
        db $F0,$01,$68,$03,$65,$03,$B5,$03
        db $00,$00,$36,$07,$39,$07,$3C,$07
        db $1C,$07,$19,$07,$16,$07,$13,$07
        db $11,$07,$00,$00,$00,$00,$00,$00
DATA_04D93D:
        db $00,$00,$00,$00,$00,$00,$21,$92
        db $21,$16,$20,$92,$20,$12,$23,$46
        db $23,$8A,$22,$8A,$23,$42,$22,$0A
        db $22,$92,$23,$16,$22,$DA,$22,$5A
        db $22,$8A,$28,$0E,$00,$00,$28,$8E
        db $24,$04,$28,$10,$23,$86,$23,$10
        db $28,$94,$23,$98,$28,$18,$28,$58
        db $29,$14,$00,$00,$23,$80,$20,$DC
        db $24,$C0,$24,$C8,$24,$CC,$24,$D4
        db $00,$00,$25,$4E,$26,$08,$24,$D4
        db $00,$00,$00,$00,$2A,$94,$29,$CC
        db $2B,$10,$2A,$98,$29,$CC,$00,$00
        db $00,$00,$2A,$88,$2A,$94,$2B,$08
        db $00,$00,$2C,$08,$00,$00,$00,$00
        db $25,$D2,$25,$CE,$25,$52,$25,$C8
        db $00,$00,$25,$48,$00,$00,$24,$C8
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$2E,$C6,$00,$00
        db $00,$00,$00,$00,$2B,$5E,$2B,$58
        db $00,$00,$29,$DC,$00,$00,$00,$00
        db $00,$00,$23,$80,$23,$80,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$24,$C8,$24,$C8
        db $00,$00,$00,$00,$2E,$0E,$00,$00
        db $27,$C0,$2D,$90,$2D,$8A,$2E,$CA
        db $00,$00,$2C,$CC,$2C,$D2,$2C,$D8
        db $2C,$58,$2C,$52,$2C,$4C,$2C,$46
        db $2C,$42,$00,$00,$00,$00,$00,$00
DATA_04DA1D:
        db $6E,$6F,$70,$71,$72,$73,$74,$75
        db $59,$53,$52,$83,$4D,$57,$5A,$76
        db $78,$7A,$7B,$7D,$7F,$54

DATA_04DA33:
        db $66,$67,$68,$69,$6A,$6B,$6C,$6D
        db $58,$43,$44,$45,$25,$5E,$5F,$77
        db $79,$63,$7C,$7E,$80,$23

CODE_04DA49:
        REP #$30
        LDA $0F                                 ;$04DA4B        |
        AND.w #$00F8                            ;$04DA4D        |
        LSR                                     ;$04DA50        |
        LSR                                     ;$04DA51        |
        LSR                                     ;$04DA52        |
        TAY                                     ;$04DA53        |
        LDA $0F                                 ;$04DA54        |
        AND.w #$0007                            ;$04DA56        |
        TAX                                     ;$04DA59        |
        SEP #$20                                ;$04DA5A        |
        LDA.w $1F02,Y                           ;$04DA5C        |
        AND.l DATA_04E44B,X                     ;$04DA5F        |
        BEQ Return04DAAC                        ;$04DA63        |
        REP #$20                                ;$04DA65        |
        LDA.w #$C800                            ;$04DA67        |
        STA $04                                 ;$04DA6A        |
        LDA $0F                                 ;$04DA6C        |
        AND.w #$00FF                            ;$04DA6E        |
        ASL                                     ;$04DA71        |
        TAX                                     ;$04DA72        |
        LDA.l DATA_04D85D,X                     ;$04DA73        |
        TAY                                     ;$04DA77        |
        LDX.w #$0015                            ;$04DA78        |
        SEP #$20                                ;$04DA7B        |
        LDA.b #$7E                              ;$04DA7D        |
        STA $06                                 ;$04DA7F        |
        LDA [$04],Y                             ;$04DA81        |
CODE_04DA83:
        CMP.l DATA_04DA1D,X
        BEQ CODE_04DA8F                         ;$04DA87        |
        DEX                                     ;$04DA89        |
        BPL CODE_04DA83                         ;$04DA8A        |
        JMP CODE_04DA9D                         ;$04DA8C        |

CODE_04DA8F:
        LDA.l DATA_04DA33,X
        STA [$04],Y                             ;$04DA93        |
        CPX.w #$0015                            ;$04DA95        |
        BNE CODE_04DA9D                         ;$04DA98        |
        INY                                     ;$04DA9A        |
        STA [$04],Y                             ;$04DA9B        |
CODE_04DA9D:
        LDA $0F
        JSR CODE_04E677                         ;$04DA9F        |
        SEP #$10                                ;$04DAA2        |
        STZ.w $1B86                             ;$04DAA4        |
        LDA $0F                                 ;$04DAA7        |
        JSR CODE_04E9F1                         ;$04DAA9        |
Return04DAAC:
        RTS

CODE_04DAAD:
        PHP
        JSR CODE_04DC6A                         ;$04DAAE        |
        PLP                                     ;$04DAB1        |
        RTL                                     ;$04DAB2        |

DATA_04DAB3:
        db $01,$18,$00,$40,$7F,$00,$20

CODE_04DABA:
        SEP #$20
        REP #$10                                ;$04DABC        |
        LDA [$00],Y                             ;$04DABE        |
        STA $03                                 ;$04DAC0        |
        AND.b #$80                              ;$04DAC2        |
        BNE CODE_04DAD6                         ;$04DAC4        |
CODE_04DAC6:
        INY
        LDA [$00],Y                             ;$04DAC7        |
        STA.l $7F4000,X                         ;$04DAC9        |
        INX                                     ;$04DACD        |
        INX                                     ;$04DACE        |
        DEC $03                                 ;$04DACF        |
        BPL CODE_04DAC6                         ;$04DAD1        |
        JMP CODE_04DAE9                         ;$04DAD3        |

CODE_04DAD6:
        LDA $03
        AND.b #$7F                              ;$04DAD8        |
        STA $03                                 ;$04DADA        |
        INY                                     ;$04DADC        |
        LDA [$00],Y                             ;$04DADD        |
CODE_04DADF:
        STA.l $7F4000,X
        INX                                     ;$04DAE3        |
        INX                                     ;$04DAE4        |
        DEC $03                                 ;$04DAE5        |
        BPL CODE_04DADF                         ;$04DAE7        |
CODE_04DAE9:
        INY
        CPX $0E                                 ;$04DAEA        |
        BCC CODE_04DABA                         ;$04DAEC        |
        RTS                                     ;$04DAEE        |

CODE_04DAEF:
        SEP #$30
        LDA.w $1DE8                             ;$04DAF1        |
        JSL execute_pointer                     ;$04DAF4        |

Ptrs04DAF8:
        dw CODE_04DB18
        dw CODE_04DCB6
        dw CODE_04DCB6
        dw CODE_04DCB6
        dw CODE_04DCB6
        dw CODE_04DB9D
        dw CODE_04DB18
        dw CODE_04DBCF

DATA_04DB08:
        db $00,$F9,$00,$07

DATA_04DB0C:
        db $00,$00,$00,$70

DATA_04DB10:
        db $C0,$FA,$40,$05

DATA_04DB14:
        db $00,$00,$00,$54

CODE_04DB18:
        REP #$20
        LDX.w $1B8C                             ;$04DB1A        |
        LDA.w $1B8D                             ;$04DB1D        |
        CLC                                     ;$04DB20        |
        ADC.w DATA_04DB08,X                     ;$04DB21        |
        STA.w $1B8D                             ;$04DB24        |
        SEC                                     ;$04DB27        |
        SBC.w DATA_04DB0C,X                     ;$04DB28        |
        EOR.w DATA_04DB08,X                     ;$04DB2B        |
        BPL CODE_04DB43                         ;$04DB2E        |
        LDA.w $1B8F                             ;$04DB30        |
        CLC                                     ;$04DB33        |
        ADC.w DATA_04DB10,X                     ;$04DB34        |
        STA.w $1B8F                             ;$04DB37        |
        SEC                                     ;$04DB3A        |
        SBC.w DATA_04DB14,X                     ;$04DB3B        |
        EOR.w DATA_04DB10,X                     ;$04DB3E        |
        BMI CODE_04DB5F                         ;$04DB41        |
CODE_04DB43:
        LDA.w DATA_04DB0C,X
        STA.w $1B8D                             ;$04DB46        |
        LDA.w DATA_04DB14,X                     ;$04DB49        |
        STA.w $1B8F                             ;$04DB4C        |
        INC.w $1DE8                             ;$04DB4F        |
        TXA                                     ;$04DB52        |
        EOR.w #$0002                            ;$04DB53        |
        TAX                                     ;$04DB56        |
        STX.w $1B8C                             ;$04DB57        |
        BEQ CODE_04DB5F                         ;$04DB5A        |
        JSR CODE_049A93                         ;$04DB5C        |
CODE_04DB5F:
        SEP #$20
        LDA.w $1B90                             ;$04DB61        |
        ASL                                     ;$04DB64        |
        STA $00                                 ;$04DB65        |
        LDA.w $1B8E                             ;$04DB67        |
        CLC                                     ;$04DB6A        |
        ADC.b #$80                              ;$04DB6B        |
        XBA                                     ;$04DB6D        |
        LDA.b #$80                              ;$04DB6E        |
        SEC                                     ;$04DB70        |
        SBC.w $1B8E                             ;$04DB71        |
        REP #$20                                ;$04DB74        |
        LDX.b #$00                              ;$04DB76        |
        LDY.b #$A8                              ;$04DB78        |
CODE_04DB7A:
        CPX $00
        BCC CODE_04DB81                         ;$04DB7C        |
        LDA.w #$00FF                            ;$04DB7E        |
CODE_04DB81:
        STA.w $04EE,Y
        STA.w $0598,X                           ;$04DB84        |
        INX                                     ;$04DB87        |
        INX                                     ;$04DB88        |
        DEY                                     ;$04DB89        |
        DEY                                     ;$04DB8A        |
        BNE CODE_04DB7A                         ;$04DB8B        |
        SEP #$20                                ;$04DB8D        |
        LDA.b #$33                              ;$04DB8F        |
        STA $41                                 ;$04DB91        |
        LDA.b #$33                              ;$04DB93        |
CODE_04DB95:
        STA $43
        LDA.b #$80                              ;$04DB97        |
        STA.w $0D9F                             ;$04DB99        |
        RTS                                     ;$04DB9C        |

CODE_04DB9D:
        LDA.w $0DD6
        LSR                                     ;$04DBA0        |
        LSR                                     ;$04DBA1        |
        TAX                                     ;$04DBA2        |
        LDA.w $1F11,X                           ;$04DBA3        |
        TAX                                     ;$04DBA6        |
        LDA.l DATA_04DC02,X                     ;$04DBA7        |
        STA.w $1931                             ;$04DBAB        |
        JSL CODE_00A594                         ;$04DBAE        |
        LDA.b #$FE                              ;$04DBB2        |
        STA.w $0703                             ;$04DBB4        |
        LDA.b #$01                              ;$04DBB7        |
        STA.w $0704                             ;$04DBB9        |
        STZ.w $0803                             ;$04DBBC        |
        LDA.b #$06                              ;$04DBBF        |
        STA.w $0680                             ;$04DBC1        |
        INC.w $1DE8                             ;$04DBC4        |
        RTS                                     ;$04DBC7        |

DATA_04DBC8:
        db $02,$03,$04,$06,$07,$09,$05

CODE_04DBCF:
        STZ.w $1DE8
        LDA.b #$04                              ;$04DBD2        |
        STA.w $13D9                             ;$04DBD4        |
        LDA.w $0DD6                             ;$04DBD7        |
        LSR                                     ;$04DBDA        |
        LSR                                     ;$04DBDB        |
        TAY                                     ;$04DBDC        |
        LDA.w $0DB2                             ;$04DBDD        |
        BEQ CODE_04DBF3                         ;$04DBE0        |
        LDA.w $1B9E                             ;$04DBE2        |
        BNE CODE_04DBF3                         ;$04DBE5        |
        TYA                                     ;$04DBE7        |
        EOR.b #$01                              ;$04DBE8        |
        TAX                                     ;$04DBEA        |
        LDA.w $1F11,Y                           ;$04DBEB        |
        CMP.w $1F11,X                           ;$04DBEE        |
        BEQ Return04DC01                        ;$04DBF1        |
CODE_04DBF3:
        LDA.w $1F11,Y
        TAX                                     ;$04DBF6        |
        LDA.l DATA_04DBC8,X                     ;$04DBF7        |
        STA.w $1DFB                             ;$04DBFB        |
        STZ.w $1B9E                             ;$04DBFE        |
Return04DC01:
        RTS

DATA_04DC02:
        db $11,$12,$13,$14,$15,$16,$17

CODE_04DC09:
        SEP #$30
        LDA.w $0DD6                             ;$04DC0B        |
        LSR                                     ;$04DC0E        |
        LSR                                     ;$04DC0F        |
        TAX                                     ;$04DC10        |
        LDA.w $1F11,X                           ;$04DC11        |
        TAX                                     ;$04DC14        |
        LDA.l DATA_04DC02,X                     ;$04DC15        |
        STA.w $1931                             ;$04DC19        |
        LDA.b #$11                              ;$04DC1C        |
        STA.w $192B                             ;$04DC1E        |
        LDA.b #$07                              ;$04DC21        |
        STA.w $1925                             ;$04DC23        |
        LDA.b #$03                              ;$04DC26        |
        STA $5B                                 ;$04DC28        |
        REP #$10                                ;$04DC2A        |
        LDX.w #$0000                            ;$04DC2C        |
        TXA                                     ;$04DC2F        |
CODE_04DC30:
        JSR CODE_04D770
        CPX.w #$01B0                            ;$04DC33        |
        BNE CODE_04DC30                         ;$04DC36        |
        REP #$30                                ;$04DC38        |
        LDA.w #$D000                            ;$04DC3A        |
        STA $00                                 ;$04DC3D        |
        LDX.w #$0000                            ;$04DC3F        |
CODE_04DC42:
        LDA $00
        STA.w $0FBE,X                           ;$04DC44        |
        LDA $00                                 ;$04DC47        |
        CLC                                     ;$04DC49        |
        ADC.w #$0008                            ;$04DC4A        |
        STA $00                                 ;$04DC4D        |
        INX                                     ;$04DC4F        |
        INX                                     ;$04DC50        |
        CPX.w #$0400                            ;$04DC51        |
        BNE CODE_04DC42                         ;$04DC54        |
        PHB                                     ;$04DC56        |
        LDA.w #$07FF                            ;$04DC57        |
        LDX.w #$F7DF                            ;$04DC5A        |
        LDY.w #$C800                            ;$04DC5D        |
        MVN $7E,$0C                             ;$04DC60        |
        PLB                                     ;$04DC63        |
        JSR CODE_04D7F2                         ;$04DC64        |
        SEP #$30                                ;$04DC67        |
        RTL                                     ;$04DC69        |

CODE_04DC6A:
        SEP #$30
        JSR CODE_04DD40                         ;$04DC6C        |
        REP #$20                                ;$04DC6F        |
        LDA.w #$A533                            ;$04DC71        |
        STA $00                                 ;$04DC74        |
        SEP #$30                                ;$04DC76        |
        LDA.b #$04                              ;$04DC78        |
        STA $02                                 ;$04DC7A        |
        REP #$10                                ;$04DC7C        |
        LDY.w #$4000                            ;$04DC7E        |
        STY $0E                                 ;$04DC81        |
        LDY.w #$0000                            ;$04DC83        |
        TYX                                     ;$04DC86        |
        JSR CODE_04DABA                         ;$04DC87        |
        REP #$20                                ;$04DC8A        |
        LDA.w #$C02B                            ;$04DC8C        |
        STA $00                                 ;$04DC8F        |
        SEP #$20                                ;$04DC91        |
        LDX.w #$0001                            ;$04DC93        |
        LDY.w #$0000                            ;$04DC96        |
        JSR CODE_04DABA                         ;$04DC99        |
        SEP #$30                                ;$04DC9C        |
        LDA.b #$00                              ;$04DC9E        |
        STA $0F                                 ;$04DCA0        |
CODE_04DCA2:
        JSR CODE_04E453
        INC $0F                                 ;$04DCA5        |
        LDA $0F                                 ;$04DCA7        |
        CMP.b #$6F                              ;$04DCA9        |
        BNE CODE_04DCA2                         ;$04DCAB        |
        RTS                                     ;$04DCAD        |

DATA_04DCAE:
        db $80,$40,$20,$10,$08,$04,$02,$01

CODE_04DCB6:
        PHP
        REP #$10                                ;$04DCB7        |
        SEP #$20                                ;$04DCB9        |
        LDX.w #$D000                            ;$04DCBB        |
        STX $65                                 ;$04DCBE        |
        LDA.b #$05                              ;$04DCC0        |
        STA $67                                 ;$04DCC2        |
        LDX.w #$0000                            ;$04DCC4        |
        STX $00                                 ;$04DCC7        |
        LDA.w $1DE8                             ;$04DCC9        |
        DEC A                                   ;$04DCCC        |
        STA $01                                 ;$04DCCD        |
        REP #$20                                ;$04DCCF        |
        LDA.w $0DD6                             ;$04DCD1        |
        LSR                                     ;$04DCD4        |
        LSR                                     ;$04DCD5        |
        AND.w #$00FF                            ;$04DCD6        |
        TAX                                     ;$04DCD9        |
        SEP #$20                                ;$04DCDA        |
        LDA.w $1F11,X                           ;$04DCDC        |
        BEQ CODE_04DCE8                         ;$04DCDF        |
        LDA $01                                 ;$04DCE1        |
        CLC                                     ;$04DCE3        |
        ADC.b #$04                              ;$04DCE4        |
        STA $01                                 ;$04DCE6        |
CODE_04DCE8:
        LDX $00
        LDA.l $7EC800,X                         ;$04DCEA        |
        STA $02                                 ;$04DCEE        |
        REP #$20                                ;$04DCF0        |
        LDA.l $7FC800,X                         ;$04DCF2        |
        STA $03                                 ;$04DCF6        |
        LDA $02                                 ;$04DCF8        |
        ASL                                     ;$04DCFA        |
        ASL                                     ;$04DCFB        |
        ASL                                     ;$04DCFC        |
        TAY                                     ;$04DCFD        |
        LDA $00                                 ;$04DCFE        |
        AND.w #$00FF                            ;$04DD00        |
        ASL                                     ;$04DD03        |
        ASL                                     ;$04DD04        |
        PHA                                     ;$04DD05        |
        AND.w #$003F                            ;$04DD06        |
        STA $02                                 ;$04DD09        |
        PLA                                     ;$04DD0B        |
        ASL                                     ;$04DD0C        |
        AND.w #$0F80                            ;$04DD0D        |
        ORA $02                                 ;$04DD10        |
        TAX                                     ;$04DD12        |
        LDA [$65],Y                             ;$04DD13        |
        STA.l $7EE400,X                         ;$04DD15        |
        INY                                     ;$04DD19        |
        INY                                     ;$04DD1A        |
        LDA [$65],Y                             ;$04DD1B        |
        STA.l $7EE440,X                         ;$04DD1D        |
        INY                                     ;$04DD21        |
        INY                                     ;$04DD22        |
        LDA [$65],Y                             ;$04DD23        |
        STA.l $7EE402,X                         ;$04DD25        |
        INY                                     ;$04DD29        |
        INY                                     ;$04DD2A        |
        LDA [$65],Y                             ;$04DD2B        |
        STA.l $7EE442,X                         ;$04DD2D        |
        SEP #$20                                ;$04DD31        |
        INC $00                                 ;$04DD33        |
        LDA $00                                 ;$04DD35        |
        AND.b #$FF                              ;$04DD37        |
        BNE CODE_04DCE8                         ;$04DD39        |
        INC.w $1DE8                             ;$04DD3B        |
        PLP                                     ;$04DD3E        |
        RTS                                     ;$04DD3F        |

CODE_04DD40:
        REP #$10
        SEP #$20                                ;$04DD42        |
        LDY.w #$8D00                            ;$04DD44        |
        STY $02                                 ;$04DD47        |
        LDA.b #$0C                              ;$04DD49        |
        STA $04                                 ;$04DD4B        |
        LDX.w #$0000                            ;$04DD4D        |
        TXY                                     ;$04DD50        |
        JSR CODE_04DD57                         ;$04DD51        |
        SEP #$30                                ;$04DD54        |
        RTS                                     ;$04DD56        |

CODE_04DD57:
        SEP #$20
        LDA [$02],Y                             ;$04DD59        |
        INY                                     ;$04DD5B        |
        STA $05                                 ;$04DD5C        |
        AND.b #$80                              ;$04DD5E        |
        BNE CODE_04DD71                         ;$04DD60        |
CODE_04DD62:
        LDA [$02],Y
        STA.l $7F0000,X                         ;$04DD64        |
        INY                                     ;$04DD68        |
        INX                                     ;$04DD69        |
        DEC $05                                 ;$04DD6A        |
        BPL CODE_04DD62                         ;$04DD6C        |
        JMP CODE_04DD83                         ;$04DD6E        |

CODE_04DD71:
        LDA $05
        AND.b #$7F                              ;$04DD73        |
        STA $05                                 ;$04DD75        |
        LDA [$02],Y                             ;$04DD77        |
CODE_04DD79:
        STA.l $7F0000,X
        INX                                     ;$04DD7D        |
        DEC $05                                 ;$04DD7E        |
        BPL CODE_04DD79                         ;$04DD80        |
        INY                                     ;$04DD82        |
CODE_04DD83:
        REP #$20
        LDA [$02],Y                             ;$04DD85        |
        CMP.w #$FFFF                            ;$04DD87        |
        BNE CODE_04DD57                         ;$04DD8A        |
        RTS                                     ;$04DD8C        |

DATA_04DD8D:
        db $00,$09

DATA_04DD8F:
        db $CC,$23,$04,$09,$8C,$23,$08,$09
        db $4E,$23,$0C,$09,$0E,$23,$10,$09
        db $D0,$22,$14,$09,$90,$22,$8C,$01
        db $02,$22,$B0,$01,$02,$22,$D4,$01
        db $02,$22,$44,$0A,$C6,$21,$48,$0A
        db $44,$20,$4C,$0A,$86,$21,$48,$0A
        db $04,$20,$00,$09,$E4,$23,$38,$09
        db $A4,$23,$28,$09,$24,$23,$18,$09
        db $26,$23,$1C,$09,$28,$23,$20,$09
        db $EC,$22,$24,$09,$AC,$22,$0C,$0B
        db $2C,$22,$10,$0B,$EC,$21,$30,$09
        db $6C,$21,$34,$09,$68,$21,$38,$09
        db $E4,$20,$38,$09,$A4,$20,$3C,$09
        db $90,$10,$40,$09,$4C,$10,$44,$09
        db $0C,$10,$38,$09,$8C,$07,$38,$09
        db $0C,$07,$28,$09,$8C,$06,$48,$09
        db $14,$10,$4C,$09,$94,$07,$50,$09
        db $54,$07,$38,$09,$0C,$06,$04,$09
        db $8C,$05,$54,$09,$0E,$05,$E8,$09
        db $48,$06,$E8,$09,$C8,$06,$98,$09
        db $88,$06,$EC,$09,$12,$05,$F0,$09
        db $D2,$04,$F4,$09,$92,$04,$00,$00
        db $D8,$04,$24,$00,$98,$04,$48,$00
        db $D8,$03,$6C,$00,$56,$03,$90,$00
        db $56,$03,$B4,$00,$56,$03,$10,$05
        db $18,$05,$28,$09,$24,$05,$38,$0B
        db $14,$07,$60,$09,$28,$05,$64,$09
        db $6A,$05,$68,$09,$AC,$05,$6C,$09
        db $2C,$06,$70,$09,$30,$06,$74,$09
        db $B2,$05,$78,$09,$32,$05,$68,$01
        db $FC,$07,$50,$0A,$C0,$0F,$D8,$00
        db $7C,$07,$FC,$00,$7C,$07,$20,$01
        db $7C,$07,$44,$01,$7C,$07,$50,$09
        db $D4,$06,$4C,$09,$94,$06,$7C,$09
        db $14,$06,$80,$09,$94,$05,$84,$09
        db $18,$07,$88,$09,$1A,$07,$48,$09
        db $9C,$07,$8C,$09,$1C,$10,$90,$09
        db $60,$10,$94,$09,$64,$10,$38,$09
        db $DC,$10,$98,$09,$84,$28,$A4,$09
        db $18,$31,$84,$09,$1C,$31,$A8,$09
        db $E0,$30,$4C,$09,$60,$30,$A0,$09
        db $CA,$30,$A0,$09,$0E,$31,$B0,$09
        db $10,$31,$B4,$09,$CC,$30,$B8,$09
        db $8C,$30,$BC,$09,$0C,$30,$BC,$09
        db $8C,$27,$BC,$09,$A0,$27,$BC,$09
        db $20,$27,$AC,$09,$A0,$26,$28,$09
        db $20,$26,$00,$0A,$64,$30,$04,$0A
        db $A8,$30,$08,$0A,$28,$31,$18,$09
        db $22,$26,$98,$09,$26,$26,$C0,$09
        db $2A,$26,$C4,$09,$6C,$26,$C8,$09
        db $70,$26,$CC,$09,$B0,$26,$28,$09
        db $30,$27,$D0,$09,$70,$27,$38,$09
        db $B0,$27,$28,$09,$30,$30,$38,$09
        db $B0,$30,$38,$09,$F0,$30,$D4,$09
        db $B0,$31,$D8,$09,$2E,$32,$98,$09
        db $2A,$32,$E0,$09,$CC,$26,$BC,$09
        db $8C,$26,$E4,$09,$0C,$26,$DC,$09
        db $04,$27,$DC,$09,$C0,$26,$DC,$09
        db $40,$27,$98,$09,$B4,$01,$0C,$0B
        db $B8,$01,$30,$0B,$88,$09,$34,$0B
        db $A0,$09,$10,$0A,$8A,$09,$10,$0A
        db $9E,$09,$0C,$0A,$8C,$09,$0C,$0A
        db $9C,$09,$10,$0A,$8E,$09,$10,$0A
        db $9A,$09,$0C,$0A,$90,$09,$0C,$0A
        db $98,$09,$10,$0A,$92,$09,$10,$0A
        db $96,$09,$14,$0A,$A4,$09,$A8,$03
        db $30,$08,$18,$0A,$AC,$09,$1C,$0A
        db $F0,$09,$9C,$09,$70,$0A,$20,$0A
        db $F0,$0A,$20,$0A,$70,$0B,$20,$0A
        db $F0,$0B,$24,$0A,$70,$0C,$38,$09
        db $F0,$0C,$28,$0A,$30,$0D,$2C,$0A
        db $98,$0A,$30,$0A,$9C,$0A,$14,$0B
        db $10,$0B,$18,$0B,$90,$0B,$34,$0A
        db $1C,$0B,$38,$0A,$5E,$0B,$3C,$0A
        db $62,$0B,$40,$0A,$66,$0B,$20,$0A
        db $E8,$0A,$9C,$09,$68,$0A,$7C,$0A
        db $A4,$33,$7C,$0A,$E8,$33,$7C,$0A
        db $68,$34,$18,$09,$A2,$33,$C0,$09
        db $A4,$33,$30,$09,$E8,$33,$54,$0A
        db $28,$34,$38,$09,$A8,$34,$7C,$0A
        db $98,$33,$7C,$0A,$9C,$33,$58,$0A
        db $9E,$33,$98,$09,$9C,$33,$28,$09
        db $98,$33,$7C,$0A,$26,$36,$7C,$0A
        db $20,$36,$5C,$0A,$68,$35,$14,$09
        db $A8,$35,$D8,$09,$26,$36,$1C,$09
        db $24,$36,$28,$09,$20,$36,$7C,$0A
        db $2C,$35,$7C,$0A,$30,$35,$60,$0A
        db $2A,$35,$98,$09,$2C,$35,$98,$09
        db $2E,$35,$98,$09,$30,$35,$7C,$0A
        db $DA,$35,$7C,$0A,$98,$34,$7C,$0A
        db $18,$34,$58,$0A,$1E,$36,$3C,$09
        db $1C,$36,$64,$0A,$D8,$35,$44,$09
        db $98,$35,$28,$09,$18,$35,$38,$09
        db $98,$34,$38,$09,$18,$34,$28,$09
        db $98,$33,$7C,$0A,$A0,$36,$7C,$0A
        db $60,$37,$D0,$09,$60,$36,$38,$09
        db $E0,$36,$38,$09,$60,$37,$7C,$0A
        db $9C,$33,$18,$09,$9A,$33,$98,$09
        db $9C,$33,$7C,$0A,$10,$35,$58,$0A
        db $96,$33,$6C,$0A,$92,$33,$70,$0A
        db $D0,$33,$74,$0A,$10,$34,$38,$09
        db $90,$34,$28,$09,$10,$35,$7C,$0A
        db $1C,$35,$7C,$0A,$22,$35,$98,$09
        db $14,$35,$28,$09,$18,$35,$98,$09
        db $1C,$35,$98,$09,$20,$35,$98,$09
        db $24,$35,$7C,$0A,$10,$36,$D0,$09
        db $50,$35,$38,$09,$90,$35,$28,$09
        db $10,$36,$7C,$0A,$90,$36,$7C,$0A
        db $0E,$37,$7C,$0A,$0A,$37,$7C,$0A
        db $02,$37,$D0,$09,$50,$36,$78,$0A
        db $D0,$36,$1C,$09,$0C,$37,$98,$09
        db $08,$37,$98,$09,$04,$37,$98,$09
        db $00,$37,$90,$0A,$12,$18,$94,$0A
        db $AA,$2B,$98,$0A,$A8,$2B,$9C,$0A
        db $A4,$2B,$94,$0A,$A2,$2B,$98,$0A
        db $A0,$2B,$A0,$0A,$64,$2B,$A4,$0A
        db $9A,$2B,$98,$0A,$98,$2B,$98,$0A
        db $96,$2B,$98,$0A,$94,$2B,$9C,$0A
        db $90,$2B,$A0,$0A,$5C,$2B,$A0,$0A
        db $50,$2B,$A8,$0A,$10,$2B,$9C,$0A
        db $90,$2A,$AC,$0A,$92,$2A,$98,$0A
        db $94,$2A,$98,$0A,$96,$2A,$98,$0A
        db $98,$2A,$A0,$0A,$50,$2A,$A8,$0A
        db $10,$2A,$3C,$0B,$90,$29,$40,$0B
        db $94,$29,$40,$0B,$98,$29,$A0,$0A
        db $5C,$2A,$A8,$0A,$1C,$2A,$A8,$0A
        db $DC,$29,$A0,$0A,$64,$2A,$A8,$0A
        db $24,$2A,$A8,$0A,$E4,$29,$B0,$0A
        db $90,$1D,$A0,$09,$8C,$1D,$B0,$0A
        db $56,$1E,$B4,$0A,$5A,$1E,$B8,$0A
        db $5C,$1D,$A0,$09,$18,$1D,$BC,$0A
        db $90,$1C,$BC,$0A,$0C,$1C,$A0,$09
        db $0C,$1E,$C0,$0A,$8A,$1E,$C0,$0A
        db $86,$1E,$BC,$0A,$04,$1E,$A0,$09
        db $84,$1D,$B8,$0A,$C6,$1C,$B0,$0A
        db $0C,$1D,$A0,$09,$88,$1D,$A0,$09
        db $84,$1D,$B4,$0A,$80,$1D,$A0,$09
        db $3C,$16,$A0,$09,$BC,$16,$A0,$09
        db $B8,$16,$A0,$09,$B4,$16,$A0,$09
        db $30,$16,$A8,$0A,$70,$15,$C4,$0A
        db $30,$15,$D8,$0A,$B8,$13,$4C,$09
        db $B0,$14,$C8,$0A,$32,$14,$CC,$0A
        db $F4,$13,$D0,$0A,$B8,$13,$D4,$0A
        db $B8,$12,$F8,$01,$F4,$11,$1C,$02
        db $F4,$11,$40,$02,$F4,$11,$64,$02
        db $F4,$11,$88,$02,$F4,$11,$AC,$02
        db $F4,$11,$D0,$02,$F4,$11,$F4,$02
        db $F4,$11,$18,$03,$F4,$11,$3C,$03
        db $B4,$11,$60,$03,$B4,$11,$3C,$03
        db $B4,$11,$DC,$0A,$10,$3D,$E0,$0A
        db $CE,$3C,$E4,$0A,$8C,$3C,$E8,$0A
        db $48,$3C,$EC,$0A,$14,$3C,$F0,$0A
        db $D6,$3B,$F4,$0A,$98,$3B,$F8,$0A
        db $5A,$3B,$18,$09,$26,$3C,$98,$09
        db $28,$3C,$98,$09,$2A,$3C,$98,$09
        db $2C,$3C,$6C,$09,$28,$3D,$FC,$0A
        db $68,$3D,$00,$0B,$AA,$3D,$E4,$0A
        db $EC,$3D,$E4,$0A,$2E,$3E,$DC,$0A
        db $B0,$3E,$3C,$0B,$90,$29,$40,$0B
        db $94,$29,$40,$0B,$98,$29,$04,$0B
        db $9C,$3D,$08,$0B,$D8,$3D,$08,$0B
        db $14,$3E,$08,$0B,$50,$3E,$08,$0B
        db $8C,$3E,$6C,$09,$88,$3E,$44,$01
        db $7C,$07,$38,$09,$E0,$19,$1C,$0B
        db $20,$1A,$CC,$03,$DC,$1A,$F0,$03
        db $DC,$1A,$14,$04,$DC,$1A,$38,$04
        db $9C,$1B,$5C,$04,$9C,$1B,$80,$04
        db $5C,$1B,$A4,$04,$1C,$1B,$C8,$04
        db $DC,$1A,$EC,$04,$9C,$1A,$58,$0A
        db $1E,$1B,$20,$0B,$1C,$1B,$24,$0B
        db $1A,$1B,$28,$0B,$18,$1B,$A0,$09
        db $94,$1B,$A0,$09,$14,$1C,$A0,$09
        db $94,$1C,$C0,$0A,$14,$1D,$2C,$0B
        db $56,$1D,$A0,$09,$D4,$1D,$98,$09
        db $90,$39,$98,$09,$94,$39,$28,$09
        db $98,$39,$98,$09,$9C,$39,$98,$09
        db $A0,$39,$28,$09,$A4,$39,$98,$09
        db $A8,$39,$98,$09,$AC,$39,$28,$09
        db $B0,$39,$98,$09,$B4,$39,$98,$09
        db $B4,$38,$28,$09,$B0,$38,$98,$09
        db $AC,$38,$98,$09,$A8,$38,$28,$09
        db $A4,$38,$98,$09,$A0,$38,$98,$09
        db $9C,$38,$28,$09,$98,$38,$98,$09
        db $94,$38,$98,$09,$90,$38,$28,$09
        db $8C,$38,$98,$09,$88,$38,$28,$09
        db $84,$38

DATA_04E359:
        db $00,$00

DATA_04E35B:
        db $00,$00,$0D,$00,$0D,$00,$10,$00
        db $15,$00,$18,$00,$1A,$00,$20,$00
        db $23,$00,$26,$00,$29,$00,$2C,$00
        db $35,$00,$39,$00,$3A,$00,$42,$00
        db $46,$00,$4A,$00,$4C,$00,$4D,$00
        db $4E,$00,$52,$00,$59,$00,$5D,$00
        db $60,$00,$67,$00,$6A,$00,$6C,$00
        db $6F,$00,$72,$00,$75,$00,$77,$00
        db $77,$00,$83,$00,$83,$00,$84,$00
        db $8E,$00,$90,$00,$92,$00,$98,$00
        db $98,$00,$98,$00,$A0,$00,$A5,$00
        db $AC,$00,$B2,$00,$BD,$00,$C2,$00
        db $C5,$00,$CC,$00,$D3,$00,$D7,$00
        db $E1,$00,$E2,$00,$E2,$00,$E2,$00
        db $E5,$00,$E7,$00,$E8,$00,$ED,$00
        db $EE,$00,$F1,$00,$F5,$00,$FA,$00
        db $FD,$00,$00,$01,$00,$01,$00,$01
        db $00,$01,$00,$01,$02,$01,$08,$01
        db $0F,$01,$12,$01,$14,$01,$16,$01
        db $17,$01,$1E,$01,$2B,$01,$2B,$01
        db $2B,$01,$2B,$01,$2F,$01,$2F,$01
        db $2F,$01,$33,$01,$33,$01,$33,$01
        db $37,$01,$37,$01,$37,$01,$40,$01
        db $40,$01,$46,$01,$46,$01,$46,$01
        db $47,$01,$52,$01,$56,$01,$5C,$01
        db $5C,$01,$5F,$01,$62,$01,$65,$01
        db $68,$01,$6B,$01,$6E,$01,$71,$01
        db $73,$01,$73,$01,$73,$01,$73,$01
        db $73,$01,$73,$01,$73,$01,$73,$01
        db $73,$01,$73,$01,$73,$01,$73,$01
DATA_04E44B:
        db $80,$40,$20,$10,$08,$04,$02,$01

CODE_04E453:
        SEP #$30
        LDA $0F                                 ;$04E455        |
        AND.b #$07                              ;$04E457        |
        TAX                                     ;$04E459        |
        LDA $0F                                 ;$04E45A        |
        LSR                                     ;$04E45C        |
        LSR                                     ;$04E45D        |
        LSR                                     ;$04E45E        |
        TAY                                     ;$04E45F        |
        LDA.w $1F02,Y                           ;$04E460        |
        AND.l DATA_04E44B,X                     ;$04E463        |
        BNE CODE_04E46A                         ;$04E467        |
        RTS                                     ;$04E469        |

CODE_04E46A:
        LDA $0F
        ASL                                     ;$04E46C        |
        TAX                                     ;$04E46D        |
        REP #$20                                ;$04E46E        |
        LDA.l DATA_04E359,X                     ;$04E470        |
        STA.w $1DEB                             ;$04E474        |
        LDA.l DATA_04E35B,X                     ;$04E477        |
        STA.w $1DED                             ;$04E47B        |
        CMP.w $1DEB                             ;$04E47E        |
        BEQ CODE_04E493                         ;$04E481        |
CODE_04E483:
        JSR CODE_04E496
        REP #$20                                ;$04E486        |
        INC.w $1DEB                             ;$04E488        |
        LDA.w $1DEB                             ;$04E48B        |
        CMP.w $1DED                             ;$04E48E        |
        BNE CODE_04E483                         ;$04E491        |
CODE_04E493:
        SEP #$30
        RTS                                     ;$04E495        |

CODE_04E496:
        REP #$30
        LDA.w $1DEB                             ;$04E498        |
        ASL                                     ;$04E49B        |
        ASL                                     ;$04E49C        |
        TAX                                     ;$04E49D        |
        LDA.l DATA_04DD8D,X                     ;$04E49E        |
        TAY                                     ;$04E4A2        |
        LDA.l DATA_04DD8F,X                     ;$04E4A3        |
        STA $04                                 ;$04E4A7        |
CODE_04E4A9:
        SEP #$20
        LDA.b #$7F                              ;$04E4AB        |
        STA $08                                 ;$04E4AD        |
        LDA.b #$0C                              ;$04E4AF        |
        STA $0B                                 ;$04E4B1        |
        REP #$20                                ;$04E4B3        |
        LDA.w #$0000                            ;$04E4B5        |
        STA $06                                 ;$04E4B8        |
        LDA.w #$8000                            ;$04E4BA        |
        STA $09                                 ;$04E4BD        |
        CPY.w #$0900                            ;$04E4BF        |
        BCC CODE_04E4CA                         ;$04E4C2        |
        JSR CODE_04E4D0                         ;$04E4C4        |
        JMP CODE_04E4CD                         ;$04E4C7        |

CODE_04E4CA:
        JSR CODE_04E520
CODE_04E4CD:
        SEP #$30
        RTS                                     ;$04E4CF        |

CODE_04E4D0:
        LDA.w #$0001
        STA $00                                 ;$04E4D3        |
CODE_04E4D5:
        LDX $04
        LDA.w #$0001                            ;$04E4D7        |
        STA $0C                                 ;$04E4DA        |
CODE_04E4DC:
        SEP #$20
        LDA [$09],Y                             ;$04E4DE        |
        STA.l $7F4000,X                         ;$04E4E0        |
        INX                                     ;$04E4E4        |
        LDA [$06],Y                             ;$04E4E5        |
        STA.l $7F4000,X                         ;$04E4E7        |
        INY                                     ;$04E4EB        |
        INX                                     ;$04E4EC        |
        REP #$20                                ;$04E4ED        |
        TXA                                     ;$04E4EF        |
        AND.w #$003F                            ;$04E4F0        |
        BNE CODE_04E4FF                         ;$04E4F3        |
        DEX                                     ;$04E4F5        |
        TXA                                     ;$04E4F6        |
        AND.w #$FFC0                            ;$04E4F7        |
        CLC                                     ;$04E4FA        |
        ADC.w #$0800                            ;$04E4FB        |
        TAX                                     ;$04E4FE        |
CODE_04E4FF:
        DEC $0C
        BPL CODE_04E4DC                         ;$04E501        |
        LDA $04                                 ;$04E503        |
        TAX                                     ;$04E505        |
        CLC                                     ;$04E506        |
        ADC.w #$0040                            ;$04E507        |
        STA $04                                 ;$04E50A        |
        AND.w #$07C0                            ;$04E50C        |
        BNE CODE_04E51B                         ;$04E50F        |
        TXA                                     ;$04E511        |
        AND.w #$F83F                            ;$04E512        |
        CLC                                     ;$04E515        |
        ADC.w #$1000                            ;$04E516        |
        STA $04                                 ;$04E519        |
CODE_04E51B:
        DEC $00
        BPL CODE_04E4D5                         ;$04E51D        |
        RTS                                     ;$04E51F        |

CODE_04E520:
        LDA.w #$0005
        STA $00                                 ;$04E523        |
CODE_04E525:
        LDX $04
        LDA.w #$0005                            ;$04E527        |
        STA $0C                                 ;$04E52A        |
CODE_04E52C:
        SEP #$20
        LDA [$09],Y                             ;$04E52E        |
        STA.l $7F4000,X                         ;$04E530        |
        INX                                     ;$04E534        |
        LDA [$06],Y                             ;$04E535        |
        STA.l $7F4000,X                         ;$04E537        |
        INY                                     ;$04E53B        |
        INX                                     ;$04E53C        |
        REP #$20                                ;$04E53D        |
        TXA                                     ;$04E53F        |
        AND.w #$003F                            ;$04E540        |
        BNE CODE_04E54F                         ;$04E543        |
        DEX                                     ;$04E545        |
        TXA                                     ;$04E546        |
        AND.w #$FFC0                            ;$04E547        |
        CLC                                     ;$04E54A        |
        ADC.w #$0800                            ;$04E54B        |
        TAX                                     ;$04E54E        |
CODE_04E54F:
        DEC $0C
        BPL CODE_04E52C                         ;$04E551        |
        LDA $04                                 ;$04E553        |
        TAX                                     ;$04E555        |
        CLC                                     ;$04E556        |
        ADC.w #$0040                            ;$04E557        |
        STA $04                                 ;$04E55A        |
        AND.w #$07C0                            ;$04E55C        |
        BNE CODE_04E56B                         ;$04E55F        |
        TXA                                     ;$04E561        |
        AND.w #$F83F                            ;$04E562        |
        CLC                                     ;$04E565        |
        ADC.w #$1000                            ;$04E566        |
        STA $04                                 ;$04E569        |
CODE_04E56B:
        DEC $00
        BPL CODE_04E525                         ;$04E56D        |
        RTS                                     ;$04E56F        |

CODE_04E570:
        LDA.w $1B86
        JSL execute_pointer                     ;$04E573        |

Ptrs04E577:
        dw CODE_04E5EE
        dw CODE_04EBEB
        dw CODE_04E6D3
        dw CODE_04E6F9
        dw CODE_04EAA4
        dw CODE_04EC78
        dw CODE_04EBEB
        dw CODE_04E9EC

DATA_04E587:
        db $20,$52,$22,$DA,$28,$58,$24,$C0
        db $24,$94,$23,$42,$28,$94,$2A,$98
        db $25,$0E,$25,$52,$25,$C4,$2A,$DE
        db $2A,$98,$28,$44,$2C,$50,$2C,$0C
DATA_04E5A7:
        db $77,$79,$58,$4C,$A6

DATA_04E5AC:
        db $85,$86,$00,$10,$00

DATA_04E5B1:
        db $85,$86,$81,$81,$81

DATA_04E5B6:
        db $19,$04,$BD,$00,$1C,$06,$30,$01
        db $2A,$01,$D1,$00,$2A,$06,$AC,$06
        db $47,$05,$59,$05,$72,$05,$BF,$02
        db $AC,$02,$12,$02,$18,$03,$06,$03
DATA_04E5D6:
        db $06,$0F,$1C,$21,$24,$28,$29,$37
        db $40,$41,$43,$4A,$4D,$02,$61,$35
DATA_04E5E6:
        db $58,$59,$5D,$63,$77,$79,$7E,$80

CODE_04E5EE:
        LDA.w $0DD5
        CMP.b #$02                              ;$04E5F1        |
        BNE CODE_04E5F8                         ;$04E5F3        |
        INC.w $1DEA                             ;$04E5F5        |
CODE_04E5F8:
        LDA.w $1DE9
        BEQ CODE_04E61A                         ;$04E5FB        |
        LDA.w $1DEA                             ;$04E5FD        |
        CMP.b #$FF                              ;$04E600        |
        BEQ CODE_04E61A                         ;$04E602        |
        LDA.w $1DEA                             ;$04E604        |
        AND.b #$07                              ;$04E607        |
        TAX                                     ;$04E609        |
        LDA.w $1DEA                             ;$04E60A        |
        LSR                                     ;$04E60D        |
        LSR                                     ;$04E60E        |
        LSR                                     ;$04E60F        |
        TAY                                     ;$04E610        |
        LDA.w $1F02,Y                           ;$04E611        |
        AND.l DATA_04E44B,X                     ;$04E614        |
        BEQ CODE_04E640                         ;$04E618        |
CODE_04E61A:
        LDX.b #$07
CODE_04E61C:
        LDA.w DATA_04E5E6,X
        CMP.w $13C1                             ;$04E61F        |
        BNE CODE_04E632                         ;$04E622        |
        INC.w $13D9                             ;$04E624        |
        LDA.b #$E0                              ;$04E627        |
        STA.w $0DD5                             ;$04E629        |
        LDA.b #$0F                              ;$04E62C        |
        STA.w $0DB1                             ;$04E62E        |
        RTS                                     ;$04E631        |

CODE_04E632:
        DEX
        BPL CODE_04E61C                         ;$04E633        |
        LDA.b #$05                              ;$04E635        |
        STA.w $13D9                             ;$04E637        |
        LDA.b #$80                              ;$04E63A        |
        STA.w $0DD5                             ;$04E63C        |
        RTS                                     ;$04E63F        |

CODE_04E640:
        INC.w $1B86
        LDA.w $1DEA                             ;$04E643        |
        JSR CODE_04E677                         ;$04E646        |
        TYA                                     ;$04E649        |
        ASL                                     ;$04E64A        |
        ASL                                     ;$04E64B        |
        ASL                                     ;$04E64C        |
        ASL                                     ;$04E64D        |
        STA.w $1B82                             ;$04E64E        |
        TYA                                     ;$04E651        |
        AND.b #$F0                              ;$04E652        |
        STA.w $1B83                             ;$04E654        |
        LDA.b #$28                              ;$04E657        |
        STA.w $1B84                             ;$04E659        |
        LDA.w $13BF                             ;$04E65C        |
        CMP.b #$18                              ;$04E65F        |
        BNE CODE_04E668                         ;$04E661        |
        LDA.b #$FF                              ;$04E663        |
        STA.w $1BA0                             ;$04E665        |
CODE_04E668:
        LDA.w $1B86
        CMP.b #$02                              ;$04E66B        |
        BEQ CODE_04E674                         ;$04E66D        |
        LDA.b #$16                              ;$04E66F        |
        STA.w $1DFC                             ;$04E671        |
CODE_04E674:
        SEP #$30
        RTS                                     ;$04E676        |

CODE_04E677:
        SEP #$30
        LDX.b #$17                              ;$04E679        |
CODE_04E67B:
        CMP.l DATA_04E5D6,X
        BEQ CODE_04E68A                         ;$04E67F        |
        DEX                                     ;$04E681        |
        BPL CODE_04E67B                         ;$04E682        |
CODE_04E684:
        LDA.b #$02
        STA.w $1B86                             ;$04E686        |
        RTS                                     ;$04E689        |

CODE_04E68A:
        STX.w $13D1
        TXA                                     ;$04E68D        |
        ASL                                     ;$04E68E        |
        TAX                                     ;$04E68F        |
        LDA.b #$7E                              ;$04E690        |
        STA $0C                                 ;$04E692        |
        REP #$30                                ;$04E694        |
        LDA.w #$C800                            ;$04E696        |
        STA $0A                                 ;$04E699        |
        LDA.l DATA_04E5B6,X                     ;$04E69B        |
        TAY                                     ;$04E69F        |
        SEP #$20                                ;$04E6A0        |
        LDX.w #$0004                            ;$04E6A2        |
        LDA [$0A],Y                             ;$04E6A5        |
CODE_04E6A7:
        CMP.l DATA_04E5A7,X
        BEQ CODE_04E6B3                         ;$04E6AB        |
        DEX                                     ;$04E6AD        |
        BPL CODE_04E6A7                         ;$04E6AE        |
        JMP CODE_04E684                         ;$04E6B0        |

CODE_04E6B3:
        TXA
        STA.w $13D0                             ;$04E6B4        |
        CPX.w #$0003                            ;$04E6B7        |
        BMI CODE_04E6CA                         ;$04E6BA        |
        LDA.l DATA_04E5AC,X                     ;$04E6BC        |
        STA [$0A],Y                             ;$04E6C0        |
        REP #$20                                ;$04E6C2        |
        TYA                                     ;$04E6C4        |
        CLC                                     ;$04E6C5        |
        ADC.w #$0010                            ;$04E6C6        |
        TAY                                     ;$04E6C9        |
CODE_04E6CA:
        SEP #$20
        LDA.l DATA_04E5B1,X                     ;$04E6CC        |
        STA [$0A],Y                             ;$04E6D0        |
        RTS                                     ;$04E6D2        |

CODE_04E6D3:
        INC.w $1B86
        LDA.w $1DEA                             ;$04E6D6        |
        ASL                                     ;$04E6D9        |
        TAX                                     ;$04E6DA        |
        REP #$20                                ;$04E6DB        |
        LDA.l DATA_04E359,X                     ;$04E6DD        |
        STA.w $1DEB                             ;$04E6E1        |
        LDA.l DATA_04E35B,X                     ;$04E6E4        |
        STA.w $1DED                             ;$04E6E8        |
        CMP.w $1DEB                             ;$04E6EB        |
        SEP #$20                                ;$04E6EE        |
        BNE Return04E6F8                        ;$04E6F0        |
        INC.w $1B86                             ;$04E6F2        |
        INC.w $1B86                             ;$04E6F5        |
Return04E6F8:
        RTS

CODE_04E6F9:
        JSR CODE_04EA62
        LDA.b #$7F                              ;$04E6FC        |
        STA $0E                                 ;$04E6FE        |
        REP #$30                                ;$04E700        |
        LDA.w $1DEB                             ;$04E702        |
        ASL                                     ;$04E705        |
        ASL                                     ;$04E706        |
        TAX                                     ;$04E707        |
        LDA.l DATA_04DD8D,X                     ;$04E708        |
        STA.w $1B84                             ;$04E70C        |
        LDA.l DATA_04DD8F,X                     ;$04E70F        |
        STA $00                                 ;$04E713        |
        AND.w #$1FFF                            ;$04E715        |
        LSR                                     ;$04E718        |
        CLC                                     ;$04E719        |
        ADC.w #$3000                            ;$04E71A        |
        XBA                                     ;$04E71D        |
        STA $02                                 ;$04E71E        |
        LDA $00                                 ;$04E720        |
        LSR                                     ;$04E722        |
        LSR                                     ;$04E723        |
        LSR                                     ;$04E724        |
        SEP #$20                                ;$04E725        |
        AND.b #$F8                              ;$04E727        |
        STA.w $1B83                             ;$04E729        |
        LDA $00                                 ;$04E72C        |
        AND.b #$3E                              ;$04E72E        |
        ASL                                     ;$04E730        |
        ASL                                     ;$04E731        |
        STA.w $1B82                             ;$04E732        |
        REP #$20                                ;$04E735        |
        LDA.w #$4000                            ;$04E737        |
        STA $0C                                 ;$04E73A        |
        LDA.w #$EFFF                            ;$04E73C        |
        STA $0A                                 ;$04E73F        |
        LDA.w $1B84                             ;$04E741        |
        CMP.w #$0900                            ;$04E744        |
        BCC CODE_04E74F                         ;$04E747        |
        JSR CODE_04E76C                         ;$04E749        |
        JMP CODE_04E752                         ;$04E74C        |

CODE_04E74F:
        JSR CODE_04E824
CODE_04E752:
        LDA.w #$00FF
        STA.l $7F837D,X                         ;$04E755        |
        TXA                                     ;$04E759        |
        STA.l $7F837B                           ;$04E75A        |
        JSR CODE_04E496                         ;$04E75E        |
        SEP #$30                                ;$04E761        |
        LDA.b #$15                              ;$04E763        |
        STA.w $1DFC                             ;$04E765        |
        INC.w $1B86                             ;$04E768        |
        RTS                                     ;$04E76B        |

CODE_04E76C:
        LDA.w #$0001
        STA $06                                 ;$04E76F        |
        LDA.l $7F837B                           ;$04E771        |
        TAX                                     ;$04E775        |
CODE_04E776:
        LDA $02
        STA.l $7F837D,X                         ;$04E778        |
        INX                                     ;$04E77C        |
        INX                                     ;$04E77D        |
        LDY.w #$0300                            ;$04E77E        |
        LDA $03                                 ;$04E781        |
        AND.w #$001F                            ;$04E783        |
        STA $08                                 ;$04E786        |
        LDA.w #$0020                            ;$04E788        |
        SEC                                     ;$04E78B        |
        SBC $08                                 ;$04E78C        |
        STA $08                                 ;$04E78E        |
        CMP.w #$0001                            ;$04E790        |
        BNE CODE_04E79B                         ;$04E793        |
        LDA $08                                 ;$04E795        |
        ASL                                     ;$04E797        |
        DEC A                                   ;$04E798        |
        XBA                                     ;$04E799        |
        TAY                                     ;$04E79A        |
CODE_04E79B:
        TYA
        STA.l $7F837D,X                         ;$04E79C        |
        INX                                     ;$04E7A0        |
        INX                                     ;$04E7A1        |
        LDA.w #$0001                            ;$04E7A2        |
        STA $04                                 ;$04E7A5        |
        LDY $00                                 ;$04E7A7        |
CODE_04E7A9:
        LDA [$0C],Y
        AND $0A                                 ;$04E7AB        |
        STA.l $7F837D,X                         ;$04E7AD        |
        INX                                     ;$04E7B1        |
        INX                                     ;$04E7B2        |
        INY                                     ;$04E7B3        |
        INY                                     ;$04E7B4        |
        TYA                                     ;$04E7B5        |
        AND.w #$003F                            ;$04E7B6        |
        BNE CODE_04E7E5                         ;$04E7B9        |
        LDA $04                                 ;$04E7BB        |
        BEQ CODE_04E7E5                         ;$04E7BD        |
        DEY                                     ;$04E7BF        |
        TYA                                     ;$04E7C0        |
        AND.w #$FFC0                            ;$04E7C1        |
        CLC                                     ;$04E7C4        |
        ADC.w #$0800                            ;$04E7C5        |
        TAY                                     ;$04E7C8        |
        LDA $02                                 ;$04E7C9        |
        XBA                                     ;$04E7CB        |
        AND.w #$3BE0                            ;$04E7CC        |
        CLC                                     ;$04E7CF        |
        ADC.w #$0400                            ;$04E7D0        |
        XBA                                     ;$04E7D3        |
        STA.l $7F837D,X                         ;$04E7D4        |
        INX                                     ;$04E7D8        |
        INX                                     ;$04E7D9        |
        LDA $08                                 ;$04E7DA        |
        ASL                                     ;$04E7DC        |
        DEC A                                   ;$04E7DD        |
        XBA                                     ;$04E7DE        |
        STA.l $7F837D,X                         ;$04E7DF        |
        INX                                     ;$04E7E3        |
        INX                                     ;$04E7E4        |
CODE_04E7E5:
        DEC $04
        BPL CODE_04E7A9                         ;$04E7E7        |
        LDA $02                                 ;$04E7E9        |
        XBA                                     ;$04E7EB        |
        CLC                                     ;$04E7EC        |
        ADC.w #$0020                            ;$04E7ED        |
        XBA                                     ;$04E7F0        |
        STA $02                                 ;$04E7F1        |
        LDA $00                                 ;$04E7F3        |
        TAY                                     ;$04E7F5        |
        CLC                                     ;$04E7F6        |
        ADC.w #$0040                            ;$04E7F7        |
        STA $00                                 ;$04E7FA        |
        AND.w #$07C0                            ;$04E7FC        |
        BNE CODE_04E81C                         ;$04E7FF        |
        TYA                                     ;$04E801        |
        AND.w #$F83F                            ;$04E802        |
        CLC                                     ;$04E805        |
        ADC.w #$1000                            ;$04E806        |
        STA $00                                 ;$04E809        |
        LDA $02                                 ;$04E80B        |
        XBA                                     ;$04E80D        |
        SEC                                     ;$04E80E        |
        SBC.w #$0020                            ;$04E80F        |
        AND.w #$341F                            ;$04E812        |
        CLC                                     ;$04E815        |
        ADC.w #$0800                            ;$04E816        |
        XBA                                     ;$04E819        |
        STA $02                                 ;$04E81A        |
CODE_04E81C:
        DEC $06
        BMI Return04E823                        ;$04E81E        |
        JMP CODE_04E776                         ;$04E820        |

Return04E823:
        RTS

CODE_04E824:
        LDA.w #$0005
        STA $06                                 ;$04E827        |
        LDA.l $7F837B                           ;$04E829        |
        TAX                                     ;$04E82D        |
CODE_04E82E:
        LDA $02
        STA.l $7F837D,X                         ;$04E830        |
        INX                                     ;$04E834        |
        INX                                     ;$04E835        |
        LDY.w #$0B00                            ;$04E836        |
        LDA $03                                 ;$04E839        |
        AND.w #$001F                            ;$04E83B        |
        STA $08                                 ;$04E83E        |
        LDA.w #$0020                            ;$04E840        |
        SEC                                     ;$04E843        |
        SBC $08                                 ;$04E844        |
        STA $08                                 ;$04E846        |
        CMP.w #$0006                            ;$04E848        |
        BCS CODE_04E85B                         ;$04E84B        |
        LDA $08                                 ;$04E84D        |
        ASL                                     ;$04E84F        |
        DEC A                                   ;$04E850        |
        XBA                                     ;$04E851        |
        TAY                                     ;$04E852        |
        LDA.w #$0006                            ;$04E853        |
        SEC                                     ;$04E856        |
        SBC $08                                 ;$04E857        |
        STA $08                                 ;$04E859        |
CODE_04E85B:
        TYA
        STA.l $7F837D,X                         ;$04E85C        |
        INX                                     ;$04E860        |
        INX                                     ;$04E861        |
        LDA.w #$0005                            ;$04E862        |
        STA $04                                 ;$04E865        |
        LDY $00                                 ;$04E867        |
CODE_04E869:
        LDA [$0C],Y
        AND $0A                                 ;$04E86B        |
        STA.l $7F837D,X                         ;$04E86D        |
        INX                                     ;$04E871        |
        INX                                     ;$04E872        |
        INY                                     ;$04E873        |
        INY                                     ;$04E874        |
        TYA                                     ;$04E875        |
        AND.w #$003F                            ;$04E876        |
        BNE CODE_04E8A5                         ;$04E879        |
        LDA $04                                 ;$04E87B        |
        BEQ CODE_04E8A5                         ;$04E87D        |
        DEY                                     ;$04E87F        |
        TYA                                     ;$04E880        |
        AND.w #$FFC0                            ;$04E881        |
        CLC                                     ;$04E884        |
        ADC.w #$0800                            ;$04E885        |
        TAY                                     ;$04E888        |
        LDA $02                                 ;$04E889        |
        XBA                                     ;$04E88B        |
        AND.w #$3BE0                            ;$04E88C        |
        CLC                                     ;$04E88F        |
        ADC.w #$0400                            ;$04E890        |
        XBA                                     ;$04E893        |
        STA.l $7F837D,X                         ;$04E894        |
        INX                                     ;$04E898        |
        INX                                     ;$04E899        |
        LDA $08                                 ;$04E89A        |
        ASL                                     ;$04E89C        |
        DEC A                                   ;$04E89D        |
        XBA                                     ;$04E89E        |
        STA.l $7F837D,X                         ;$04E89F        |
        INX                                     ;$04E8A3        |
        INX                                     ;$04E8A4        |
CODE_04E8A5:
        DEC $04
        BPL CODE_04E869                         ;$04E8A7        |
        LDA $02                                 ;$04E8A9        |
        XBA                                     ;$04E8AB        |
        CLC                                     ;$04E8AC        |
        ADC.w #$0020                            ;$04E8AD        |
        XBA                                     ;$04E8B0        |
        STA $02                                 ;$04E8B1        |
        LDA $00                                 ;$04E8B3        |
        TAY                                     ;$04E8B5        |
        CLC                                     ;$04E8B6        |
        ADC.w #$0040                            ;$04E8B7        |
        STA $00                                 ;$04E8BA        |
        AND.w #$07C0                            ;$04E8BC        |
        BNE CODE_04E8DC                         ;$04E8BF        |
        TYA                                     ;$04E8C1        |
        AND.w #$F83F                            ;$04E8C2        |
        CLC                                     ;$04E8C5        |
        ADC.w #$1000                            ;$04E8C6        |
        STA $00                                 ;$04E8C9        |
        LDA $02                                 ;$04E8CB        |
        XBA                                     ;$04E8CD        |
        SEC                                     ;$04E8CE        |
        SBC.w #$0020                            ;$04E8CF        |
        AND.w #$341F                            ;$04E8D2        |
        CLC                                     ;$04E8D5        |
        ADC.w #$0800                            ;$04E8D6        |
        XBA                                     ;$04E8D9        |
        STA $02                                 ;$04E8DA        |
CODE_04E8DC:
        DEC $06
        BMI Return04E8E3                        ;$04E8DE        |
        JMP CODE_04E82E                         ;$04E8E0        |

Return04E8E3:
        RTS

DATA_04E8E4:
        db $06,$06,$06,$06,$06,$06,$06,$06
        db $14,$14,$14,$14,$14,$1D,$1D,$1D
        db $1D,$12,$12,$12,$1C,$2F,$2F,$2F
        db $2F,$2F,$34,$34,$34,$47,$4E,$4E
        db $01,$0F,$24,$24,$6C,$0F,$0F,$54
        db $55,$57,$58,$5D

DATA_04E910:
        db $00,$00,$00,$00,$00,$00,$01,$01
        db $00,$01,$01,$01,$01,$01,$01,$01
        db $00,$01,$01,$00,$00,$01,$01,$01
        db $01,$01,$01,$01,$01,$00,$01,$00
        db $00,$01,$01,$01,$01,$01,$00,$00
        db $00,$00,$00,$00

DATA_04E93C:
        db $15,$02,$35,$02,$45,$02,$55,$02
        db $65,$02,$75,$02,$14,$11,$94,$10
        db $A9,$00,$A4,$05,$24,$05,$28,$07
        db $A4,$06,$A8,$01,$AC,$01,$B0,$01
        db $3C,$00,$00,$29,$80,$28,$10,$05
        db $54,$01,$30,$18,$B0,$18,$2E,$19
        db $2A,$19,$26,$19,$24,$18,$20,$18
        db $1C,$18,$97,$05,$EC,$2A,$7B,$05
        db $12,$02,$94,$31,$A0,$32,$20,$33
        db $16,$1D,$14,$31,$25,$06,$F0,$01
        db $F0,$01,$04,$03,$04,$03,$27,$02
DATA_04E994:
        db $68,$00,$24,$00,$24,$00,$25,$00
        db $00,$00,$81,$00,$38,$09,$28,$09
        db $66,$00,$9C,$09,$28,$09,$F8,$09
        db $FC,$09,$98,$09,$98,$09,$28,$09
        db $66,$00,$38,$09,$28,$09,$66,$00
        db $68,$00,$80,$0A,$84,$0A,$88,$0A
        db $98,$09,$98,$09,$94,$09,$98,$09
        db $8C,$0A,$66,$00,$84,$03,$66,$00
        db $79,$00,$A8,$0A,$38,$09,$38,$09
        db $A0,$09,$30,$0A,$69,$00,$5F,$00
        db $5F,$00,$5F,$00,$5F,$00,$5F,$00

CODE_04E9EC:
        LDA.w $1DEA
        STA $0F                                 ;$04E9EF        |
CODE_04E9F1:
        LDX.b #$2B
CODE_04E9F3:
        CMP.l DATA_04E8E4,X
        BEQ CODE_04EA25                         ;$04E9F7        |
CODE_04E9F9:
        DEX
        BPL CODE_04E9F3                         ;$04E9FA        |
        LDA.w $1B86                             ;$04E9FC        |
        BEQ Return04EA24                        ;$04E9FF        |
        STZ.w $1B86                             ;$04EA01        |
        INC.w $13D9                             ;$04EA04        |
        LDA.w $1DEA                             ;$04EA07        |
        AND.b #$07                              ;$04EA0A        |
        TAX                                     ;$04EA0C        |
        LDA.w $1DEA                             ;$04EA0D        |
        LSR                                     ;$04EA10        |
        LSR                                     ;$04EA11        |
        LSR                                     ;$04EA12        |
        TAY                                     ;$04EA13        |
        LDA.w $1F02,Y                           ;$04EA14        |
        ORA.l DATA_04E44B,X                     ;$04EA17        |
        STA.w $1F02,Y                           ;$04EA1B        |
        INC.w $1F2E                             ;$04EA1E        |
        STZ.w $1DE9                             ;$04EA21        |
Return04EA24:
        RTS

CODE_04EA25:
        PHX
        LDA.l DATA_04E910,X                     ;$04EA26        |
        STA $02                                 ;$04EA2A        |
        TXA                                     ;$04EA2C        |
        ASL                                     ;$04EA2D        |
        TAX                                     ;$04EA2E        |
        REP #$20                                ;$04EA2F        |
        LDA.l DATA_04E994,X                     ;$04EA31        |
        STA $00                                 ;$04EA35        |
        LDA.l DATA_04E93C,X                     ;$04EA37        |
        STA $04                                 ;$04EA3B        |
        LDA $02                                 ;$04EA3D        |
        AND.w #$0001                            ;$04EA3F        |
        BEQ CODE_04EA4E                         ;$04EA42        |
        REP #$10                                ;$04EA44        |
        LDY $00                                 ;$04EA46        |
        JSR CODE_04E4A9                         ;$04EA48        |
        JMP CODE_04EA5A                         ;$04EA4B        |

CODE_04EA4E:
        SEP #$20
        REP #$10                                ;$04EA50        |
        LDX $04                                 ;$04EA52        |
        LDA $00                                 ;$04EA54        |
        STA.l $7EC800,X                         ;$04EA56        |
CODE_04EA5A:
        SEP #$30
        PLX                                     ;$04EA5C        |
        LDA $0F                                 ;$04EA5D        |
        JMP CODE_04E9F9                         ;$04EA5F        |

CODE_04EA62:
        STZ.w $1495
        STZ.w $1494                             ;$04EA65        |
        LDX.b #$6F                              ;$04EA68        |
CODE_04EA6A:
        LDA.w $0703,X
        STA.w $0907,X                           ;$04EA6D        |
        STZ.w $0979,X                           ;$04EA70        |
        DEX                                     ;$04EA73        |
        BPL CODE_04EA6A                         ;$04EA74        |
        LDX.b #$6F                              ;$04EA76        |
CODE_04EA78:
        LDY.b #$10
CODE_04EA7A:
        LDA.w $0783,X
        STA.w $0907,X                           ;$04EA7D        |
        DEX                                     ;$04EA80        |
        DEY                                     ;$04EA81        |
        BNE CODE_04EA7A                         ;$04EA82        |
        TXA                                     ;$04EA84        |
        SEC                                     ;$04EA85        |
        SBC.b #$10                              ;$04EA86        |
        TAX                                     ;$04EA88        |
        BPL CODE_04EA78                         ;$04EA89        |
CODE_04EA8B:
        REP #$20
        LDA.w #$0070                            ;$04EA8D        |
        STA.w $0905                             ;$04EA90        |
        LDA.w #$C070                            ;$04EA93        |
        STA.w $0977                             ;$04EA96        |
        SEP #$20                                ;$04EA99        |
        STZ.w $09E9                             ;$04EA9B        |
        LDA.b #$03                              ;$04EA9E        |
        STA.w $0680                             ;$04EAA0        |
        RTS                                     ;$04EAA3        |

CODE_04EAA4:
        LDA.w $1495
        CMP.b #$40                              ;$04EAA7        |
        BCC CODE_04EAC9                         ;$04EAA9        |
        INC.w $1B86                             ;$04EAAB        |
        JSR CODE_04EE30                         ;$04EAAE        |
        JSR CODE_04E496                         ;$04EAB1        |
        REP #$20                                ;$04EAB4        |
        INC.w $1DEB                             ;$04EAB6        |
        LDA.w $1DEB                             ;$04EAB9        |
        CMP.w $1DED                             ;$04EABC        |
        SEP #$20                                ;$04EABF        |
        BCS Return04EAC8                        ;$04EAC1        |
        LDA.b #$03                              ;$04EAC3        |
        STA.w $1B86                             ;$04EAC5        |
Return04EAC8:
        RTS

CODE_04EAC9:
        JSR CODE_04EC67
        REP #$30                                ;$04EACC        |
        LDY.w #$008C                            ;$04EACE        |
        LDX.w #$0006                            ;$04EAD1        |
        LDA.w $1B84                             ;$04EAD4        |
        CMP.w #$0900                            ;$04EAD7        |
        BCC CODE_04EAE2                         ;$04EADA        |
        LDY.w #$000C                            ;$04EADC        |
        LDX.w #$0002                            ;$04EADF        |
CODE_04EAE2:
        STX $05
        TAX                                     ;$04EAE4        |
        SEP #$20                                ;$04EAE5        |
CODE_04EAE7:
        LDA $05
        STA $03                                 ;$04EAE9        |
        LDA $00                                 ;$04EAEB        |
CODE_04EAED:
        STA $02
        LDA $01                                 ;$04EAEF        |
        STA.w $0351,Y                           ;$04EAF1        |
        LDA.l DATA_0C8000,X                     ;$04EAF4        |
        STA.w $0352,Y                           ;$04EAF8        |
        LDA.l $7F0000,X                         ;$04EAFB        |
        AND.b #$C0                              ;$04EAFF        |
        STA $04                                 ;$04EB01        |
        LDA.l $7F0000,X                         ;$04EB03        |
        AND.b #$1C                              ;$04EB07        |
        LSR                                     ;$04EB09        |
        ORA $04                                 ;$04EB0A        |
        ORA.b #$11                              ;$04EB0C        |
        STA.w $0353,Y                           ;$04EB0E        |
        LDA $02                                 ;$04EB11        |
        STA.w $0350,Y                           ;$04EB13        |
        CLC                                     ;$04EB16        |
        ADC.b #$08                              ;$04EB17        |
        INX                                     ;$04EB19        |
        DEY                                     ;$04EB1A        |
        DEY                                     ;$04EB1B        |
        DEY                                     ;$04EB1C        |
        DEY                                     ;$04EB1D        |
        DEC $03                                 ;$04EB1E        |
        BNE CODE_04EAED                         ;$04EB20        |
        LDA $01                                 ;$04EB22        |
        CLC                                     ;$04EB24        |
        ADC.b #$08                              ;$04EB25        |
        STA $01                                 ;$04EB27        |
        CPY.w #$FFFC                            ;$04EB29        |
        BNE CODE_04EAE7                         ;$04EB2C        |
        SEP #$10                                ;$04EB2E        |
        LDX.b #$23                              ;$04EB30        |
CODE_04EB32:
        STZ.w $0474,X
        DEX                                     ;$04EB35        |
        BPL CODE_04EB32                         ;$04EB36        |
        LDY.b #$08                              ;$04EB38        |
        LDX.w $0DB3                             ;$04EB3A        |
        LDA.w $1F11,X                           ;$04EB3D        |
        CMP.b #$03                              ;$04EB40        |
        BNE CODE_04EB46                         ;$04EB42        |
        LDY.b #$01                              ;$04EB44        |
CODE_04EB46:
        STY $8A
CODE_04EB48:
        LDA.w $1495
        JSL CODE_00B006                         ;$04EB4B        |
        DEC $8A                                 ;$04EB4F        |
        BNE CODE_04EB48                         ;$04EB51        |
        JMP CODE_04EA8B                         ;$04EB53        |

DATA_04EB56:
        db $F5,$11,$F2,$15,$F5,$11,$F3,$14
        db $F5,$11,$F3,$14,$F6,$10,$F4,$13
        db $F7,$0F,$F5,$12,$F8,$0E,$F7,$11
        db $FA,$0D,$F9,$10,$FC,$0C,$FB,$0D
        db $FF,$0A,$FE,$0B,$01,$07,$01,$07
        db $00,$08,$00,$08

DATA_04EB82:
        db $F8,$F8,$11,$12,$F8,$F8,$10,$11
        db $F8,$F8,$10,$11,$F9,$F9,$0F,$10
        db $FA,$FA,$0E,$0F,$FB,$FB,$0C,$0D
        db $FC,$FC,$0B,$0B,$FE,$FE,$0A,$0A
        db $00,$00,$08,$08,$01,$01,$07,$07
        db $00,$00,$08,$08

DATA_04EBAE:
        db $F6,$B6,$76,$36,$F6,$B6,$76,$36
        db $36,$76,$B6,$F6,$36,$76,$B6,$F6
        db $36,$36,$36,$36,$36,$36,$36,$36
        db $36,$36,$36,$36,$36,$36,$36,$36
        db $36,$36,$36,$36,$36,$36,$36,$36
        db $30,$70,$B0,$F0

DATA_04EBDA:
        db $22,$23,$32,$33,$32,$23,$22

DATA_04EBE1:
        db $73,$73,$72,$72,$5F,$5F,$28,$28
        db $28,$28

CODE_04EBEB:
        DEC.w $1B84
        BPL CODE_04EBF4                         ;$04EBEE        |
        INC.w $1B86                             ;$04EBF0        |
        RTS                                     ;$04EBF3        |

CODE_04EBF4:
        LDA.w $1B84
        LDY.w $1B86                             ;$04EBF7        |
        CPY.b #$01                              ;$04EBFA        |
        BEQ CODE_04EC17                         ;$04EBFC        |
        CMP.b #$10                              ;$04EBFE        |
        BNE CODE_04EC07                         ;$04EC00        |
        PHA                                     ;$04EC02        |
        JSR CODE_04ED83                         ;$04EC03        |
        PLA                                     ;$04EC06        |
CODE_04EC07:
        LSR
        LSR                                     ;$04EC08        |
        TAX                                     ;$04EC09        |
        LDA.w DATA_04EBDA,X                     ;$04EC0A        |
        STA $02                                 ;$04EC0D        |
        JSR CODE_04EC67                         ;$04EC0F        |
        LDX.b #$28                              ;$04EC12        |
        JMP CODE_04EC2E                         ;$04EC14        |

CODE_04EC17:
        CMP.b #$18
        BNE CODE_04EC20                         ;$04EC19        |
        PHA                                     ;$04EC1B        |
        JSR CODE_04EEAA                         ;$04EC1C        |
        PLA                                     ;$04EC1F        |
CODE_04EC20:
        AND.b #$FC
        TAX                                     ;$04EC22        |
        LSR                                     ;$04EC23        |
        LSR                                     ;$04EC24        |
        TAY                                     ;$04EC25        |
        LDA.w DATA_04EBE1,Y                     ;$04EC26        |
        STA $02                                 ;$04EC29        |
        JSR CODE_04EC67                         ;$04EC2B        |
CODE_04EC2E:
        LDA.b #$03
        STA $03                                 ;$04EC30        |
        LDY.b #$00                              ;$04EC32        |
CODE_04EC34:
        LDA $00
        CLC                                     ;$04EC36        |
        ADC.w DATA_04EB56,X                     ;$04EC37        |
        STA.w $0280,Y                           ;$04EC3A        |
        LDA $01                                 ;$04EC3D        |
        CLC                                     ;$04EC3F        |
        ADC.w DATA_04EB82,X                     ;$04EC40        |
        STA.w $0281,Y                           ;$04EC43        |
        LDA $02                                 ;$04EC46        |
        STA.w $0282,Y                           ;$04EC48        |
        LDA.w DATA_04EBAE,X                     ;$04EC4B        |
        STA.w $0283,Y                           ;$04EC4E        |
        INY                                     ;$04EC51        |
        INY                                     ;$04EC52        |
        INY                                     ;$04EC53        |
        INY                                     ;$04EC54        |
        INX                                     ;$04EC55        |
        DEC $03                                 ;$04EC56        |
        BPL CODE_04EC34                         ;$04EC58        |
        STZ.w $0440                             ;$04EC5A        |
        STZ.w $0441                             ;$04EC5D        |
        STZ.w $0442                             ;$04EC60        |
        STZ.w $0443                             ;$04EC63        |
        RTS                                     ;$04EC66        |

CODE_04EC67:
        LDA.w $1B82
        SEC                                     ;$04EC6A        |
        SBC $1E                                 ;$04EC6B        |
        STA $00                                 ;$04EC6D        |
        LDA.w $1B83                             ;$04EC6F        |
        CLC                                     ;$04EC72        |
        SBC $20                                 ;$04EC73        |
        STA $01                                 ;$04EC75        |
        RTS                                     ;$04EC77        |

CODE_04EC78:
        LDA.b #$7E
        STA $0F                                 ;$04EC7A        |
        REP #$30                                ;$04EC7C        |
        LDA.w #$C800                            ;$04EC7E        |
        STA $0D                                 ;$04EC81        |
        LDA.w $1DEA                             ;$04EC83        |
        AND.w #$00FF                            ;$04EC86        |
        ASL                                     ;$04EC89        |
        TAX                                     ;$04EC8A        |
        LDA.l DATA_04D85D,X                     ;$04EC8B        |
        TAY                                     ;$04EC8F        |
        LDX.w #$0015                            ;$04EC90        |
        SEP #$20                                ;$04EC93        |
        LDA [$0D],Y                             ;$04EC95        |
CODE_04EC97:
        CMP.l DATA_04DA1D,X
        BEQ CODE_04ECA8                         ;$04EC9B        |
        DEX                                     ;$04EC9D        |
        BPL CODE_04EC97                         ;$04EC9E        |
        SEP #$10                                ;$04ECA0        |
        LDA.b #$07                              ;$04ECA2        |
        STA.w $1B86                             ;$04ECA4        |
        RTS                                     ;$04ECA7        |

CODE_04ECA8:
        SEP #$30
        LDA.b #$01                              ;$04ECAA        |
        STA.w $1DFC                             ;$04ECAC        |
        INC.w $1B86                             ;$04ECAF        |
        LDA.w $1DEA                             ;$04ECB2        |
        AND.b #$FF                              ;$04ECB5        |
        ASL                                     ;$04ECB7        |
        TAX                                     ;$04ECB8        |
        LDA.l DATA_04D85D,X                     ;$04ECB9        |
        ASL                                     ;$04ECBD        |
        ASL                                     ;$04ECBE        |
        ASL                                     ;$04ECBF        |
        ASL                                     ;$04ECC0        |
        STA.w $1B82                             ;$04ECC1        |
        LDA.l DATA_04D85D,X                     ;$04ECC4        |
        AND.b #$F0                              ;$04ECC8        |
        STA.w $1B83                             ;$04ECCA        |
        LDA.b #$1C                              ;$04ECCD        |
        STA.w $1B84                             ;$04ECCF        |
        RTS                                     ;$04ECD2        |

DATA_04ECD3:
        db $86,$99,$86,$19,$86,$D9,$86,$59
        db $96,$99,$96,$19,$96,$D9,$96,$59
        db $86,$9D,$86,$1D,$86,$DD,$86,$5D
        db $96,$9D,$96,$1D,$96,$DD,$96,$5D
        db $86,$99,$86,$19,$86,$D9,$86,$59
        db $96,$99,$96,$19,$96,$D9,$96,$59
        db $86,$9D,$86,$1D,$86,$DD,$86,$5D
        db $96,$9D,$96,$1D,$96,$DD,$96,$5D
        db $88,$15,$98,$15,$89,$15,$99,$15
        db $A4,$11,$B4,$11,$A5,$11,$B5,$11
        db $22,$11,$90,$11,$22,$11,$91,$11
        db $C2,$11,$D2,$11,$C3,$11,$D3,$11
        db $A6,$11,$B6,$11,$A7,$11,$B7,$11
        db $82,$19,$92,$19,$83,$19,$93,$19
        db $C8,$19,$F8,$19,$C9,$19,$F9,$19
        db $80,$1C,$90,$1C,$81,$1C,$90,$5C
        db $80,$14,$90,$14,$81,$14,$90,$54
        db $A2,$11,$B2,$11,$A3,$11,$B3,$11
        db $82,$1D,$92,$1D,$83,$1D,$93,$1D
        db $86,$99,$86,$19,$86,$D9,$86,$59
        db $86,$99,$86,$19,$86,$D9,$86,$59
        db $A8,$11,$B8,$11,$A9,$11,$B9,$11

CODE_04ED83:
        LDA.b #$7E
        STA $0F                                 ;$04ED85        |
        REP #$30                                ;$04ED87        |
        LDA.w #$C800                            ;$04ED89        |
        STA $0D                                 ;$04ED8C        |
        LDA.w $1DEA                             ;$04ED8E        |
        AND.w #$00FF                            ;$04ED91        |
        ASL                                     ;$04ED94        |
        TAX                                     ;$04ED95        |
        LDA.l DATA_04D85D,X                     ;$04ED96        |
        TAY                                     ;$04ED9A        |
        LDX.w #$0015                            ;$04ED9B        |
        SEP #$20                                ;$04ED9E        |
        LDA [$0D],Y                             ;$04EDA0        |
CODE_04EDA2:
        CMP.l DATA_04DA1D,X
        BEQ CODE_04EDAB                         ;$04EDA6        |
        DEX                                     ;$04EDA8        |
        BNE CODE_04EDA2                         ;$04EDA9        |
CODE_04EDAB:
        REP #$30
        STX $0E                                 ;$04EDAD        |
        LDA.w $1DEA                             ;$04EDAF        |
        AND.w #$00FF                            ;$04EDB2        |
        ASL                                     ;$04EDB5        |
        TAX                                     ;$04EDB6        |
        LDA.l DATA_04D93D,X                     ;$04EDB7        |
        STA $00                                 ;$04EDBB        |
        LDA.l DATA_04D85D,X                     ;$04EDBD        |
        TAX                                     ;$04EDC1        |
        PHX                                     ;$04EDC2        |
        LDX $0E                                 ;$04EDC3        |
        SEP #$20                                ;$04EDC5        |
        LDA.l DATA_04DA33,X                     ;$04EDC7        |
        PLX                                     ;$04EDCB        |
        STA.l $7EC800,X                         ;$04EDCC        |
        LDA.b #$04                              ;$04EDD0        |
        STA $0C                                 ;$04EDD2        |
        REP #$20                                ;$04EDD4        |
        LDA.w #$ECD3                            ;$04EDD6        |
        STA $0A                                 ;$04EDD9        |
        LDA $0E                                 ;$04EDDB        |
        ASL                                     ;$04EDDD        |
        ASL                                     ;$04EDDE        |
        ASL                                     ;$04EDDF        |
        TAY                                     ;$04EDE0        |
        LDA.l $7F837B                           ;$04EDE1        |
        TAX                                     ;$04EDE5        |
CODE_04EDE6:
        LDA $00
        STA.l $7F837D,X                         ;$04EDE8        |
        CLC                                     ;$04EDEC        |
        ADC.w #$2000                            ;$04EDED        |
        STA.l $7F8385,X                         ;$04EDF0        |
        LDA.w #$0300                            ;$04EDF4        |
        STA.l $7F837F,X                         ;$04EDF7        |
        STA.l $7F8387,X                         ;$04EDFB        |
        LDA [$0A],Y                             ;$04EDFF        |
        STA.l $7F8381,X                         ;$04EE01        |
        INY                                     ;$04EE05        |
        INY                                     ;$04EE06        |
        LDA [$0A],Y                             ;$04EE07        |
        STA.l $7F8389,X                         ;$04EE09        |
        INY                                     ;$04EE0D        |
        INY                                     ;$04EE0E        |
        LDA [$0A],Y                             ;$04EE0F        |
        STA.l $7F8383,X                         ;$04EE11        |
        INY                                     ;$04EE15        |
        INY                                     ;$04EE16        |
        LDA [$0A],Y                             ;$04EE17        |
        STA.l $7F838B,X                         ;$04EE19        |
        LDA.w #$00FF                            ;$04EE1D        |
        STA.l $7F838D,X                         ;$04EE20        |
        TXA                                     ;$04EE24        |
        CLC                                     ;$04EE25        |
        ADC.w #$0010                            ;$04EE26        |
        STA.l $7F837B                           ;$04EE29        |
        SEP #$30                                ;$04EE2D        |
        RTS                                     ;$04EE2F        |

CODE_04EE30:
        SEP #$20
        LDA.b #$7F                              ;$04EE32        |
        STA $0E                                 ;$04EE34        |
        REP #$30                                ;$04EE36        |
        LDA.w $1DEB                             ;$04EE38        |
        ASL                                     ;$04EE3B        |
        ASL                                     ;$04EE3C        |
        TAX                                     ;$04EE3D        |
        LDA.l DATA_04DD8F,X                     ;$04EE3E        |
        STA $00                                 ;$04EE42        |
        AND.w #$1FFF                            ;$04EE44        |
        LSR                                     ;$04EE47        |
        CLC                                     ;$04EE48        |
        ADC.w #$3000                            ;$04EE49        |
        XBA                                     ;$04EE4C        |
        STA $02                                 ;$04EE4D        |
        LDA.w #$4000                            ;$04EE4F        |
        STA $0C                                 ;$04EE52        |
        LDA.w #$FFFF                            ;$04EE54        |
        STA $0A                                 ;$04EE57        |
        LDA.l DATA_04DD8D,X                     ;$04EE59        |
        CMP.w #$0900                            ;$04EE5D        |
        BCC CODE_04EE68                         ;$04EE60        |
        JSR CODE_04E76C                         ;$04EE62        |
        JMP CODE_04EE6B                         ;$04EE65        |

CODE_04EE68:
        JSR CODE_04E824
CODE_04EE6B:
        LDA.w #$00FF
        STA.l $7F837D,X                         ;$04EE6E        |
        TXA                                     ;$04EE72        |
        STA.l $7F837B                           ;$04EE73        |
        SEP #$30                                ;$04EE77        |
        RTS                                     ;$04EE79        |

DATA_04EE7A:
        db $22,$01,$82,$1C,$22,$01,$83,$1C
        db $22,$01,$82,$14,$22,$01,$83,$14
        db $EA,$01,$EA,$01,$EA,$C1,$EA,$C1
        db $EA,$01,$EA,$01,$EA,$C1,$EA,$C1
        db $22,$01,$22,$01,$22,$01,$22,$01
        db $8A,$15,$9A,$15,$8B,$15,$9B,$15

CODE_04EEAA:
        SEP #$30
        LDA.b #$7E                              ;$04EEAC        |
        STA $0F                                 ;$04EEAE        |
        LDA.b #$04                              ;$04EEB0        |
        STA $0C                                 ;$04EEB2        |
        REP #$30                                ;$04EEB4        |
        LDA.w #$C800                            ;$04EEB6        |
        STA $0D                                 ;$04EEB9        |
        LDA.w #$EE7A                            ;$04EEBB        |
        STA $0A                                 ;$04EEBE        |
        LDA.w $13D1                             ;$04EEC0        |
        AND.w #$00FF                            ;$04EEC3        |
        ASL                                     ;$04EEC6        |
        TAX                                     ;$04EEC7        |
        LDA.l DATA_04E587,X                     ;$04EEC8        |
        STA $00                                 ;$04EECC        |
        LDA.l $7F837B                           ;$04EECE        |
        TAX                                     ;$04EED2        |
        LDA.w $13D0                             ;$04EED3        |
        AND.w #$00FF                            ;$04EED6        |
        CMP.w #$0003                            ;$04EED9        |
        BMI CODE_04EF27                         ;$04EEDC        |
        ASL                                     ;$04EEDE        |
        ASL                                     ;$04EEDF        |
        ASL                                     ;$04EEE0        |
        TAY                                     ;$04EEE1        |
        LDA $00                                 ;$04EEE2        |
        STA.l $7F837D,X                         ;$04EEE4        |
        CLC                                     ;$04EEE8        |
        ADC.w #$2000                            ;$04EEE9        |
        STA.l $7F8385,X                         ;$04EEEC        |
        XBA                                     ;$04EEF0        |
        CLC                                     ;$04EEF1        |
        ADC.w #$0020                            ;$04EEF2        |
        XBA                                     ;$04EEF5        |
        STA $00                                 ;$04EEF6        |
        LDA.w #$0300                            ;$04EEF8        |
        STA.l $7F837F,X                         ;$04EEFB        |
        STA.l $7F8387,X                         ;$04EEFF        |
        LDA [$0A],Y                             ;$04EF03        |
        STA.l $7F8381,X                         ;$04EF05        |
        INY                                     ;$04EF09        |
        INY                                     ;$04EF0A        |
        LDA [$0A],Y                             ;$04EF0B        |
        STA.l $7F8389,X                         ;$04EF0D        |
        INY                                     ;$04EF11        |
        INY                                     ;$04EF12        |
        LDA [$0A],Y                             ;$04EF13        |
        STA.l $7F8383,X                         ;$04EF15        |
        INY                                     ;$04EF19        |
        INY                                     ;$04EF1A        |
        LDA [$0A],Y                             ;$04EF1B        |
        STA.l $7F838B,X                         ;$04EF1D        |
        TXA                                     ;$04EF21        |
        CLC                                     ;$04EF22        |
        ADC.w #$0010                            ;$04EF23        |
        TAX                                     ;$04EF26        |
CODE_04EF27:
        LDA.w $13D0
        AND.w #$00FF                            ;$04EF2A        |
        CMP.w #$0002                            ;$04EF2D        |
        BPL CODE_04EF38                         ;$04EF30        |
        ASL                                     ;$04EF32        |
        ASL                                     ;$04EF33        |
        ASL                                     ;$04EF34        |
        TAY                                     ;$04EF35        |
        BRA CODE_04EF3B                         ;$04EF36        |

CODE_04EF38:
        LDY.w #$0028
CODE_04EF3B:
        JMP CODE_04EDE6

DATA_04EF3E:
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF

DATA_04F280:
        db $00,$D8,$28,$D0,$30,$D8,$28,$00
DATA_04F288:
        db $D0,$D8,$D8,$00,$00,$28,$28,$30

CODE_04F290:
        LDY.w $1439
        CPY.b #$0C                              ;$04F293        |
        BCC CODE_04F29B                         ;$04F295        |
        STZ.w $13D2                             ;$04F297        |
        RTS                                     ;$04F29A        |

CODE_04F29B:
        LDA.w $1437
        BNE CODE_04F314                         ;$04F29E        |
        CPY.b #$08                              ;$04F2A0        |
        BCS CODE_04F30C                         ;$04F2A2        |
        LDA.b #$1C                              ;$04F2A4        |
        STA.w $1DFC                             ;$04F2A6        |
        LDA.b #$07                              ;$04F2A9        |
        STA $00                                 ;$04F2AB        |
        LDX.w $1436                             ;$04F2AD        |
CODE_04F2B0:
        LDY.w $0DD6
        LDA.w $1F17,Y                           ;$04F2B3        |
        STA.l $7EB978,X                         ;$04F2B6        |
        LDA.w $1F18,Y                           ;$04F2BA        |
        STA.l $7EB900,X                         ;$04F2BD        |
        LDA.w $1F19,Y                           ;$04F2C1        |
        STA.l $7EB9A0,X                         ;$04F2C4        |
        LDA.w $1F1A,Y                           ;$04F2C8        |
        STA.l $7EB928,X                         ;$04F2CB        |
        LDA.b #$00                              ;$04F2CF        |
        STA.l $7EB9C8,X                         ;$04F2D1        |
        STA.l $7EB950,X                         ;$04F2D5        |
        LDY $00                                 ;$04F2D9        |
        LDA.w DATA_04F280,Y                     ;$04F2DB        |
        STA.l $7EB9F0,X                         ;$04F2DE        |
        LDA.w DATA_04F288,Y                     ;$04F2E2        |
        STA.l $7EBA18,X                         ;$04F2E5        |
        LDA.b #$D0                              ;$04F2E9        |
        STA.l $7EBA40,X                         ;$04F2EB        |
        INX                                     ;$04F2EF        |
        DEC $00                                 ;$04F2F0        |
        BPL CODE_04F2B0                         ;$04F2F2        |
        CPX.b #$28                              ;$04F2F4        |
        BCC CODE_04F309                         ;$04F2F6        |
        LDA.w $1438                             ;$04F2F8        |
        CLC                                     ;$04F2FB        |
        ADC.b #$20                              ;$04F2FC        |
        CMP.b #$A0                              ;$04F2FE        |
        BCC CODE_04F304                         ;$04F300        |
        LDA.b #$00                              ;$04F302        |
CODE_04F304:
        STA.w $1438
        LDX.b #$00                              ;$04F307        |
CODE_04F309:
        STX.w $1436
CODE_04F30C:
        LDA.b #$10
        STA.w $1437                             ;$04F30E        |
        INC.w $1439                             ;$04F311        |
CODE_04F314:
        DEC.w $1437
        LDA.w $1438                             ;$04F317        |
        STA $0F                                 ;$04F31A        |
        LDX.b #$00                              ;$04F31C        |
CODE_04F31E:
        PHX
        LDY.b #$00                              ;$04F31F        |
        JSR CODE_04F39C                         ;$04F321        |
        JSR CODE_04F397                         ;$04F324        |
        JSR CODE_04F397                         ;$04F327        |
        PLX                                     ;$04F32A        |
        LDA.l $7EBA40,X                         ;$04F32B        |
        CLC                                     ;$04F32F        |
        ADC.b #$01                              ;$04F330        |
        BMI CODE_04F33A                         ;$04F332        |
        CMP.b #$40                              ;$04F334        |
        BCC CODE_04F33A                         ;$04F336        |
        LDA.b #$40                              ;$04F338        |
CODE_04F33A:
        STA.l $7EBA40,X
        LDA.l $7EB950,X                         ;$04F33E        |
        XBA                                     ;$04F342        |
        LDA.l $7EB9C8,X                         ;$04F343        |
        REP #$20                                ;$04F347        |
        CLC                                     ;$04F349        |
        ADC $02                                 ;$04F34A        |
        STA $02                                 ;$04F34C        |
        SEP #$20                                ;$04F34E        |
        XBA                                     ;$04F350        |
        ORA $01                                 ;$04F351        |
        BNE CODE_04F378                         ;$04F353        |
        LDY $0F                                 ;$04F355        |
        XBA                                     ;$04F357        |
        STA.w $0341,Y                           ;$04F358        |
        LDA $00                                 ;$04F35B        |
        STA.w $0340,Y                           ;$04F35D        |
        LDA.b #$E6                              ;$04F360        |
        STA.w $0342,Y                           ;$04F362        |
        LDA.w $13D2                             ;$04F365        |
        DEC A                                   ;$04F368        |
        ASL                                     ;$04F369        |
        ORA.b #$30                              ;$04F36A        |
        STA.w $0343,Y                           ;$04F36C        |
        TYA                                     ;$04F36F        |
        LSR                                     ;$04F370        |
        LSR                                     ;$04F371        |
        TAY                                     ;$04F372        |
        LDA.b #$02                              ;$04F373        |
        STA.w $0470,Y                           ;$04F375        |
CODE_04F378:
        LDA $0F
        CLC                                     ;$04F37A        |
        ADC.b #$04                              ;$04F37B        |
        CMP.b #$A0                              ;$04F37D        |
        BCC CODE_04F383                         ;$04F37F        |
        LDA.b #$00                              ;$04F381        |
CODE_04F383:
        STA $0F
        INX                                     ;$04F385        |
        CPX.w $1436                             ;$04F386        |
        BCC CODE_04F31E                         ;$04F389        |
        LDA.w $1439                             ;$04F38B        |
        CMP.b #$05                              ;$04F38E        |
        BCC Return04F396                        ;$04F390        |
        CPX.b #$28                              ;$04F392        |
        BCC CODE_04F31E                         ;$04F394        |
Return04F396:
        RTS

CODE_04F397:
        TXA
        CLC                                     ;$04F398        |
        ADC.b #$28                              ;$04F399        |
        TAX                                     ;$04F39B        |
CODE_04F39C:
        PHY
        LDA.l $7EB9F0,X                         ;$04F39D        |
        ASL                                     ;$04F3A1        |
        ASL                                     ;$04F3A2        |
        ASL                                     ;$04F3A3        |
        ASL                                     ;$04F3A4        |
        CLC                                     ;$04F3A5        |
        ADC.l $7EBA68,X                         ;$04F3A6        |
        STA.l $7EBA68,X                         ;$04F3AA        |
        LDA.l $7EB9F0,X                         ;$04F3AE        |
        PHP                                     ;$04F3B2        |
        LSR                                     ;$04F3B3        |
        LSR                                     ;$04F3B4        |
        LSR                                     ;$04F3B5        |
        LSR                                     ;$04F3B6        |
        LDY.b #$00                              ;$04F3B7        |
        PLP                                     ;$04F3B9        |
        BPL CODE_04F3BF                         ;$04F3BA        |
        ORA.b #$F0                              ;$04F3BC        |
        DEY                                     ;$04F3BE        |
CODE_04F3BF:
        ADC.l $7EB978,X
        STA.l $7EB978,X                         ;$04F3C3        |
        XBA                                     ;$04F3C7        |
        TYA                                     ;$04F3C8        |
        ADC.l $7EB900,X                         ;$04F3C9        |
        STA.l $7EB900,X                         ;$04F3CD        |
        XBA                                     ;$04F3D1        |
        PLY                                     ;$04F3D2        |
        REP #$20                                ;$04F3D3        |
        SEC                                     ;$04F3D5        |
        SBC.w $001A,y                           ;$04F3D6        |
        SEC                                     ;$04F3D9        |
        SBC.w #$0008                            ;$04F3DA        |
        STA.w $0000,Y                           ;$04F3DD        |
        SEP #$20                                ;$04F3E0        |
        INY                                     ;$04F3E2        |
        INY                                     ;$04F3E3        |
        RTS                                     ;$04F3E4        |

CODE_04F3E5:
        DEC A
        JSL execute_pointer                     ;$04F3E6        |

Ptrs04F3EA:
        dw CODE_04F3FF
        dw CODE_04F415
        dw CODE_04F513
        dw CODE_04F415
        dw CODE_04F3FF
        dw CODE_04F415
        dw CODE_04F3FA
        dw CODE_04F415

CODE_04F3FA:
        JSL CODE_009BA8
        RTS                                     ;$04F3FE        |

CODE_04F3FF:
        LDA.b #$22
        STA.w $1DFC                             ;$04F401        |
        INC.w $1B87                             ;$04F404        |
CODE_04F407:
        STZ $41
        STZ $42                                 ;$04F409        |
        STZ $43                                 ;$04F40B        |
        STZ.w $0D9F                             ;$04F40D        |
        RTS                                     ;$04F410        |

DATA_04F411:
        db $04,$FC

DATA_04F413:
        db $68,$00

CODE_04F415:
        LDX.b #$00
        LDA.w $0DB4                             ;$04F417        |
        CMP.w $0DB5                             ;$04F41A        |
        BPL CODE_04F420                         ;$04F41D        |
        INX                                     ;$04F41F        |
CODE_04F420:
        STX.w $1B8A
        LDX.w $1B88                             ;$04F423        |
        LDA.w $1B89                             ;$04F426        |
        CMP.l DATA_04F413,X                     ;$04F429        |
        BNE CODE_04F44B                         ;$04F42D        |
        INC.w $1B87                             ;$04F42F        |
        LDA.w $1B87                             ;$04F432        |
        CMP.b #$07                              ;$04F435        |
        BNE CODE_04F43D                         ;$04F437        |
        LDY.b #$1E                              ;$04F439        |
        STY $12                                 ;$04F43B        |
CODE_04F43D:
        DEC A
        AND.b #$03                              ;$04F43E        |
        BNE Return04F44A                        ;$04F440        |
        STZ.w $1B87                             ;$04F442        |
        STZ.w $1B88                             ;$04F445        |
        BRA CODE_04F407                         ;$04F448        |

Return04F44A:
        RTS

CODE_04F44B:
        CLC
        ADC.l DATA_04F411,X                     ;$04F44C        |
        STA.w $1B89                             ;$04F450        |
        CLC                                     ;$04F453        |
        ADC.b #$80                              ;$04F454        |
        XBA                                     ;$04F456        |
        REP #$10                                ;$04F457        |
        LDX.w #$016E                            ;$04F459        |
        LDA.b #$FF                              ;$04F45C        |
CODE_04F45E:
        STA.w $04F0,X
        STZ.w $04F1,X                           ;$04F461        |
        DEX                                     ;$04F464        |
        DEX                                     ;$04F465        |
        BPL CODE_04F45E                         ;$04F466        |
        SEP #$10                                ;$04F468        |
        LDA.w $1B89                             ;$04F46A        |
        LSR                                     ;$04F46D        |
        ADC.w $1B89                             ;$04F46E        |
        LSR                                     ;$04F471        |
        AND.b #$FE                              ;$04F472        |
        TAX                                     ;$04F474        |
        LDA.b #$80                              ;$04F475        |
        SEC                                     ;$04F477        |
        SBC.w $1B89                             ;$04F478        |
        REP #$20                                ;$04F47B        |
        LDY.b #$48                              ;$04F47D        |
CODE_04F47F:
        STA.w $0548,Y
        STA.w $0590,X                           ;$04F482        |
        DEY                                     ;$04F485        |
        DEY                                     ;$04F486        |
        DEX                                     ;$04F487        |
        DEX                                     ;$04F488        |
        BPL CODE_04F47F                         ;$04F489        |
        STZ.w $0701                             ;$04F48B        |
        SEP #$20                                ;$04F48E        |
        LDA.b #$22                              ;$04F490        |
        STA $41                                 ;$04F492        |
        LDA.b #$20                              ;$04F494        |
        JMP CODE_04DB95                         ;$04F496        |

DATA_04F499:
        db $51,$C4,$40,$24,$FC,$38,$52,$04
        db $40,$2C,$FC,$38,$52,$2F,$40,$02
        db $FC,$38,$52,$48,$40,$1C,$FC,$38
        db $FF

DATA_04F4B2:
        db $52,$49,$00,$09,$16,$28,$0A,$28
        db $1B,$28,$12,$28,$18,$28,$52,$52
        db $00,$09,$15,$28,$1E,$28,$12,$28
        db $10,$28,$12,$28,$52,$0B,$00,$05
        db $26,$28,$00,$28,$00,$28,$52,$14
        db $00,$05,$26,$28,$00,$28,$00,$28
        db $52,$0F,$00,$03,$FC,$38,$FC,$38
        db $52,$2F,$00,$03,$FC,$38,$FC,$38
        db $51,$C9,$00,$03,$85,$29,$85,$69
        db $51,$D2,$00,$03,$85,$29,$85,$69
        db $FF

DATA_04F503:
        db $7D,$38,$7E,$78

DATA_04F507:
        db $7E,$38,$7D,$78

DATA_04F50B:
        db $7D,$B8,$7E,$F8

DATA_04F50F:
        db $7E,$B8,$7D,$F8

CODE_04F513:
        LDA.w $0DA6
        ORA.w $0DA7                             ;$04F516        |
        AND.b #$10                              ;$04F519        |
        BEQ CODE_04F52B                         ;$04F51B        |
        LDX.w $0DB3                             ;$04F51D        |
        LDA.w $0DB4,X                           ;$04F520        |
        STA.w $0DBE                             ;$04F523        |
        JSL CODE_009C13                         ;$04F526        |
        RTS                                     ;$04F52A        |

CODE_04F52B:
        LDA.w $0DA6
        AND.b #$C0                              ;$04F52E        |
        BNE CODE_04F53B                         ;$04F530        |
        LDA.w $0DA7                             ;$04F532        |
        AND.b #$C0                              ;$04F535        |
        BEQ CODE_04F56C                         ;$04F537        |
        EOR.b #$C0                              ;$04F539        |
CODE_04F53B:
        LDX.b #$01
        ASL                                     ;$04F53D        |
        BCS CODE_04F541                         ;$04F53E        |
        DEX                                     ;$04F540        |
CODE_04F541:
        CPX.w $1B8A
        BEQ CODE_04F54B                         ;$04F544        |
        LDA.b #$18                              ;$04F546        |
        STA.w $1B8B                             ;$04F548        |
CODE_04F54B:
        STX.w $1B8A
        TXA                                     ;$04F54E        |
        EOR.b #$01                              ;$04F54F        |
        TAY                                     ;$04F551        |
        LDA.w $0DB4,X                           ;$04F552        |
        BEQ CODE_04F56C                         ;$04F555        |
        BMI CODE_04F56C                         ;$04F557        |
        LDA.w $0DB4,Y                           ;$04F559        |
        CMP.b #$62                              ;$04F55C        |
        BPL CODE_04F56C                         ;$04F55E        |
        INC A                                   ;$04F560        |
        STA.w $0DB4,Y                           ;$04F561        |
        DEC.w $0DB4,X                           ;$04F564        |
        LDA.b #$23                              ;$04F567        |
        STA.w $1DFC                             ;$04F569        |
CODE_04F56C:
        REP #$20
        LDA.w #$7848                            ;$04F56E        |
        STA.w $029C                             ;$04F571        |
        LDA.w #$7890                            ;$04F574        |
        STA.w $02A0                             ;$04F577        |
        LDA.w #$340A                            ;$04F57A        |
        STA.w $029E                             ;$04F57D        |
        LDA.w #$360A                            ;$04F580        |
        STA.w $02A2                             ;$04F583        |
        SEP #$20                                ;$04F586        |
        LDA.b #$02                              ;$04F588        |
        STA.w $0447                             ;$04F58A        |
        STA.w $0448                             ;$04F58D        |
        JSL CODE_05DBF2                         ;$04F590        |
        LDY.b #$50                              ;$04F594        |
        TYA                                     ;$04F596        |
        CLC                                     ;$04F597        |
        ADC.l $7F837B                           ;$04F598        |
        STA.l $7F837B                           ;$04F59C        |
        TAX                                     ;$04F5A0        |
CODE_04F5A1:
        LDA.w DATA_04F4B2,Y
        STA.l $7F837D,X                         ;$04F5A4        |
        DEX                                     ;$04F5A8        |
        DEY                                     ;$04F5A9        |
        BPL CODE_04F5A1                         ;$04F5AA        |
        INX                                     ;$04F5AC        |
        REP #$20                                ;$04F5AD        |
        LDY.w $0DB4                             ;$04F5AF        |
        BMI CODE_04F5BF                         ;$04F5B2        |
        LDA.w #$38FC                            ;$04F5B4        |
        STA.l $7F83C1,X                         ;$04F5B7        |
        STA.l $7F83C3,X                         ;$04F5BB        |
CODE_04F5BF:
        LDY.w $0DB5
        BMI CODE_04F5CF                         ;$04F5C2        |
        LDA.w #$38FC                            ;$04F5C4        |
        STA.l $7F83C9,X                         ;$04F5C7        |
        STA.l $7F83CB,X                         ;$04F5CB        |
CODE_04F5CF:
        SEP #$20
        INC.w $1B8B                             ;$04F5D1        |
        LDA.w $1B8B                             ;$04F5D4        |
        AND.b #$18                              ;$04F5D7        |
        BEQ CODE_04F600                         ;$04F5D9        |
        LDA.w $1B8A                             ;$04F5DB        |
        ASL                                     ;$04F5DE        |
        TAY                                     ;$04F5DF        |
        REP #$20                                ;$04F5E0        |
        LDA.w DATA_04F503,Y                     ;$04F5E2        |
        STA.l $7F83B1,X                         ;$04F5E5        |
        LDA.w DATA_04F507,Y                     ;$04F5E9        |
        STA.l $7F83B3,X                         ;$04F5EC        |
        LDA.w DATA_04F50B,Y                     ;$04F5F0        |
        STA.l $7F83B9,X                         ;$04F5F3        |
        LDA.w DATA_04F50F,Y                     ;$04F5F7        |
        STA.l $7F83BB,X                         ;$04F5FA        |
        SEP #$20                                ;$04F5FE        |
CODE_04F600:
        LDA.w $0DB4
        JSR CODE_04F60E                         ;$04F603        |
        TXA                                     ;$04F606        |
        CLC                                     ;$04F607        |
        ADC.b #$0A                              ;$04F608        |
        TAX                                     ;$04F60A        |
        LDA.w $0DB5                             ;$04F60B        |
CODE_04F60E:
        INC A
        PHX                                     ;$04F60F        |
        JSL CODE_00974C                         ;$04F610        |
        TXY                                     ;$04F614        |
        BNE CODE_04F619                         ;$04F615        |
        LDX #$FC                                ;$04F617        |
CODE_04F619:
        TXY
CODE_04F61A:
        PLX
        STA.l $7F83A1,X                         ;$04F61B        |
        TYA                                     ;$04F61F        |
        STA.l $7F839F,X                         ;$04F620        |
        RTS                                     ;$04F624        |

DATA_04F625:
        db $00,$00,$01,$E0,$00,$00,$00,$01
        db $60,$00,$06,$70,$01,$20,$00,$07
        db $38,$00,$8A,$01,$00,$58,$00,$7A
        db $00,$08,$88,$01,$18,$00,$09,$48
        db $01,$FC,$FF,$00,$80,$00,$00

DATA_04F64C:
        db $01,$00,$50,$00,$40,$01

DATA_04F652:
        db $03,$00,$00,$00,$00,$0A,$40,$00
        db $98,$00,$0A,$60,$00,$F8,$00,$0A
        db $40,$01,$58

DATA_04F665:
        db $01,$30,$00,$00,$01,$10,$FF,$20
        db $00,$70,$FF,$10,$00,$01,$40,$80

CODE_04F675:
        PHB
        PHK                                     ;$04F676        |
        PLB                                     ;$04F677        |
        LDX.b #$0C                              ;$04F678        |
        LDY.b #$4B                              ;$04F67A        |
CODE_04F67C:
        LDA.w $04F616,Y
        STA.w $0DE8,X                           ;$04F67F        |
        CMP.b #$01                              ;$04F682        |
        BEQ ADDR_04F68A                         ;$04F684        |
        CMP.b #$02                              ;$04F686        |
        BNE CODE_04F68F                         ;$04F688        |
ADDR_04F68A:
        LDA.b #$40
        STA.w $0E58,X                           ;$04F68C        |
CODE_04F68F:
        LDA.w DATA_04F625-14,Y
        STA.w $0E38,X                           ;$04F692        |
        LDA.w DATA_04F625-13,Y                  ;$04F695        |
        STA.w $0E68,X                           ;$04F698        |
        LDA.w DATA_04F625-12,Y                  ;$04F69B        |
        STA.w $0E48,X                           ;$04F69E        |
        LDA.w DATA_04F625-11,Y                  ;$04F6A1        |
        STA.w $0E78,X                           ;$04F6A4        |
        TYA                                     ;$04F6A7        |
        SEC                                     ;$04F6A8        |
        SBC.b #$05                              ;$04F6A9        |
        TAY                                     ;$04F6AB        |
        DEX                                     ;$04F6AC        |
        BPL CODE_04F67C                         ;$04F6AD        |
        LDX.b #$0D                              ;$04F6AF        |
CODE_04F6B1:
        STZ.w $0E25,X
        LDA.w DATA_04FD22                       ;$04F6B4        |
        DEC A                                   ;$04F6B7        |
        STA.w $0EB5,X                           ;$04F6B8        |
        LDA.w DATA_04F665,X                     ;$04F6BB        |
CODE_04F6BE:
        PHA
        STX.w $0DDE                             ;$04F6BF        |
        JSR CODE_04F853                         ;$04F6C2        |
        PLA                                     ;$04F6C5        |
        DEC A                                   ;$04F6C6        |
        BNE CODE_04F6BE                         ;$04F6C7        |
        INX                                     ;$04F6C9        |
        CPX.b #$10                              ;$04F6CA        |
        BCC CODE_04F6B1                         ;$04F6CC        |
        PLB                                     ;$04F6CE        |
        RTL                                     ;$04F6CF        |

DATA_04F6D0:
        db $70,$7F,$78,$7F,$70,$7F,$78,$7F
DATA_04F6D8:
        db $F0,$FF,$20,$00,$C0,$00,$F0,$FF
        db $F0,$FF,$80,$00,$F0,$FF,$00,$00
DATA_04F6E8:
        db $70,$00,$60,$01,$58,$01,$B0,$00
        db $60,$01,$60,$01,$70,$00,$60,$01
DATA_04F6F8:
        db $20,$58,$43,$CF,$18,$34,$A2,$5E
DATA_04F700:
        db $07,$05,$06,$07,$04,$06,$07,$05

CODE_04F708:
        LDA.b #$F7
        JSR CODE_04F882                         ;$04F70A        |
        BNE CODE_04F76E                         ;$04F70D        |
        LDY.w $1FFB                             ;$04F70F        |
        BNE CODE_04F73B                         ;$04F712        |
        LDA $13                                 ;$04F714        |
        LSR                                     ;$04F716        |
        BCC CODE_04F76E                         ;$04F717        |
        DEC.w $1FFC                             ;$04F719        |
        BNE CODE_04F76E                         ;$04F71C        |
        TAY                                     ;$04F71E        |
        LDA.w CODE_04F708,Y                     ;$04F71F        |
        AND.b #$07                              ;$04F722        |
        TAX                                     ;$04F724        |
        LDA.w DATA_04F6F8,X                     ;$04F725        |
        STA.w $1FFC                             ;$04F728        |
        LDY.w DATA_04F700,X                     ;$04F72B        |
        STY.w $1FFB                             ;$04F72E        |
        LDA.b #$08                              ;$04F731        |
        STA.w $1FFD                             ;$04F733        |
        LDA.b #$18                              ;$04F736        |
        STA.w $1DFC                             ;$04F738        |
CODE_04F73B:
        DEC.w $1FFD
        BPL CODE_04F748                         ;$04F73E        |
        DEC.w $1FFB                             ;$04F740        |
        LDA.b #$04                              ;$04F743        |
        STA.w $1FFD                             ;$04F745        |
CODE_04F748:
        TYA
        ASL                                     ;$04F749        |
        TAY                                     ;$04F74A        |
        LDX.w $0681                             ;$04F74B        |
        LDA.b #$02                              ;$04F74E        |
        STA.w $0682,X                           ;$04F750        |
        LDA.b #$47                              ;$04F753        |
        STA.w $0683,X                           ;$04F755        |
        LDA.w $0753,Y                           ;$04F758        |
        STA.w $0684,X                           ;$04F75B        |
        LDA.w $0754,Y                           ;$04F75E        |
        STA.w $0685,X                           ;$04F761        |
        STZ.w $0686,X                           ;$04F764        |
        TXA                                     ;$04F767        |
        CLC                                     ;$04F768        |
        ADC.b #$04                              ;$04F769        |
        STA.w $0681                             ;$04F76B        |
CODE_04F76E:
        LDX.b #$02
CODE_04F770:
        LDA.w $0DE5,X
        BNE CODE_04F7AB                         ;$04F773        |
        LDA.b #$05                              ;$04F775        |
        STA.w $0DE5,X                           ;$04F777        |
        JSR CODE_04FE5B                         ;$04F77A        |
        AND.b #$07                              ;$04F77D        |
        TAY                                     ;$04F77F        |
        LDA.w DATA_04F6D0,Y                     ;$04F780        |
        STA.w $0E55,X                           ;$04F783        |
        TYA                                     ;$04F786        |
        ASL                                     ;$04F787        |
        TAY                                     ;$04F788        |
        REP #$20                                ;$04F789        |
        LDA $1A                                 ;$04F78B        |
        CLC                                     ;$04F78D        |
        ADC.w DATA_04F6D8,Y                     ;$04F78E        |
        SEP #$20                                ;$04F791        |
        STA.w $0E35,X                           ;$04F793        |
        XBA                                     ;$04F796        |
        STA.w $0E65,X                           ;$04F797        |
        REP #$20                                ;$04F79A        |
        LDA $1C                                 ;$04F79C        |
        CLC                                     ;$04F79E        |
        ADC.w DATA_04F6E8,Y                     ;$04F79F        |
        SEP #$20                                ;$04F7A2        |
        STA.w $0E45,X                           ;$04F7A4        |
        XBA                                     ;$04F7A7        |
        STA.w $0E75,X                           ;$04F7A8        |
CODE_04F7AB:
        DEX
        BPL CODE_04F770                         ;$04F7AC        |
        LDX.b #$04                              ;$04F7AE        |
CODE_04F7B0:
        TXA
        STA.w $0DE0,X                           ;$04F7B1        |
        DEX                                     ;$04F7B4        |
        BPL CODE_04F7B0                         ;$04F7B5        |
        LDX.b #$04                              ;$04F7B7        |
CODE_04F7B9:
        STX $00
CODE_04F7BB:
        STX $01
        LDX $00                                 ;$04F7BD        |
        LDY.w $0DE0,X                           ;$04F7BF        |
        LDA.w $0E45,Y                           ;$04F7C2        |
        STA $02                                 ;$04F7C5        |
        LDA.w $0E75,Y                           ;$04F7C7        |
        STA $03                                 ;$04F7CA        |
        LDX $01                                 ;$04F7CC        |
        LDY.w $0DDF,X                           ;$04F7CE        |
        LDA.w $0E75,Y                           ;$04F7D1        |
        XBA                                     ;$04F7D4        |
        LDA.w $0E45,Y                           ;$04F7D5        |
        REP #$20                                ;$04F7D8        |
        CMP $02                                 ;$04F7DA        |
        SEP #$20                                ;$04F7DC        |
        BPL CODE_04F7ED                         ;$04F7DE        |
        PHY                                     ;$04F7E0        |
        LDY $00                                 ;$04F7E1        |
        LDA.w $0DE0,Y                           ;$04F7E3        |
        STA.w $0DDF,X                           ;$04F7E6        |
        PLA                                     ;$04F7E9        |
        STA.w $0DE0,Y                           ;$04F7EA        |
CODE_04F7ED:
        DEX
        BNE CODE_04F7BB                         ;$04F7EE        |
        LDX $00                                 ;$04F7F0        |
        DEX                                     ;$04F7F2        |
        BNE CODE_04F7B9                         ;$04F7F3        |
        LDA.b #$30                              ;$04F7F5        |
        STA.w $0DDF                             ;$04F7F7        |
        STZ.w $0EF7                             ;$04F7FA        |
        LDX.b #$0F                              ;$04F7FD        |
        LDY.b #$2D                              ;$04F7FF        |
CODE_04F801:
        CPX.b #$0D
        BCS CODE_04F80D                         ;$04F803        |
        LDA.w $0E25,X                           ;$04F805        |
        BEQ CODE_04F80D                         ;$04F808        |
        DEC.w $0E25,X                           ;$04F80A        |
CODE_04F80D:
        CPX.b #$05
        BCC CODE_04F819                         ;$04F80F        |
        STX.w $0DDE                             ;$04F811        |
        JSR CODE_04F853                         ;$04F814        |
        BRA CODE_04F825                         ;$04F817        |

CODE_04F819:
        PHX
        LDA.w $0DE0,X                           ;$04F81A        |
        TAX                                     ;$04F81D        |
        STX.w $0DDE                             ;$04F81E        |
        JSR CODE_04F853                         ;$04F821        |
        PLX                                     ;$04F824        |
CODE_04F825:
        DEX
        BPL CODE_04F801                         ;$04F826        |
Return04F828:
        RTS

DATA_04F829:
        db $7F,$21,$7F,$7F,$7F,$77,$3F,$F7
        db $F7,$00

DATA_04F833:
        db $00,$52,$31,$19,$45,$2A,$03,$8B
        db $94,$3C,$78,$0D,$36,$5E,$87,$1F
DATA_04F843:
        db $F4,$F4,$F4,$F4,$F4,$9C,$3C,$48
        db $C8,$CC,$A0,$A4,$D8,$DC,$E0,$E4

CODE_04F853:
        JSR CODE_04F87C
        BNE Return04F828                        ;$04F856        |
        LDA.w $0DE5,X                           ;$04F858        |
        JSL execute_pointer                     ;$04F85B        |

OWSprites:
        dw Return04F828
        dw ADDR_04F8CC
        dw ADDR_04F9B8
        dw CODE_04FA3E
        dw ADDR_04FAF1
        dw CODE_04FB37
        dw CODE_04FB98
        dw CODE_04FC46
        dw CODE_04FCE1
        dw CODE_04FD24
        dw CODE_04FD70

DATA_04F875:
        db $80,$40,$20,$10,$08,$04,$02

CODE_04F87C:
        LDY.w $0DE5,X
        LDA.w Return04F828,Y                    ;$04F87F        |
CODE_04F882:
        STA $00
        LDY.w $13D9                             ;$04F884        |
        CPY.b #$0A                              ;$04F887        |
        BNE CODE_04F892                         ;$04F889        |
        LDY.w $1DE8                             ;$04F88B        |
        CPY.b #$01                              ;$04F88E        |
        BNE CODE_04F8A3                         ;$04F890        |
CODE_04F892:
        LDA.w $0DD6
        LSR                                     ;$04F895        |
        LSR                                     ;$04F896        |
        TAY                                     ;$04F897        |
        LDA.w $1F11,Y                           ;$04F898        |
        TAY                                     ;$04F89B        |
        LDA.w DATA_04F875,Y                     ;$04F89C        |
        AND $00                                 ;$04F89F        |
        BEQ Return04F8A5                        ;$04F8A1        |
CODE_04F8A3:
        LDA.b #$01
Return04F8A5:
        RTS

DATA_04F8A6:
        db $01,$01,$03,$01,$01,$01,$01,$02
DATA_04F8AE:
        db $0C,$0C,$12,$12,$12,$12,$0C,$0C
DATA_04F8B6:
        db $10,$00,$08,$00,$20,$00,$20,$00
DATA_04F8BE:
        db $10,$00,$30,$00,$08,$00,$10,$00
DATA_04F8C6:
        db $01,$FF

DATA_04F8C8:
        db $10,$F0

DATA_04F8CA:
        db $10,$F0

ADDR_04F8CC:
        JSR CODE_04FE90
        CLC                                     ;$04F8CF        |
        JSR ADDR_04FE00                         ;$04F8D0        |
        JSR CODE_04FE62                         ;$04F8D3        |
        REP #$20                                ;$04F8D6        |
        LDA $02                                 ;$04F8D8        |
        STA $04                                 ;$04F8DA        |
        SEP #$20                                ;$04F8DC        |
        JSR CODE_04FE5B                         ;$04F8DE        |
        LDX.b #$06                              ;$04F8E1        |
        AND.b #$10                              ;$04F8E3        |
        BEQ ADDR_04F8E8                         ;$04F8E5        |
        INX                                     ;$04F8E7        |
ADDR_04F8E8:
        STX $06
        LDA $00                                 ;$04F8EA        |
        CLC                                     ;$04F8EC        |
        ADC.w DATA_04F8A6,X                     ;$04F8ED        |
        STA $00                                 ;$04F8F0        |
        BCC ADDR_04F8F6                         ;$04F8F2        |
        INC $01                                 ;$04F8F4        |
ADDR_04F8F6:
        LDA $04
        CLC                                     ;$04F8F8        |
        ADC.w DATA_04F8AE,X                     ;$04F8F9        |
        STA $02                                 ;$04F8FC        |
        LDA $05                                 ;$04F8FE        |
        ADC.b #$00                              ;$04F900        |
        STA $03                                 ;$04F902        |
        LDA.b #$32                              ;$04F904        |
        XBA                                     ;$04F906        |
        LDA.b #$28                              ;$04F907        |
        JSR CODE_04FB7B                         ;$04F909        |
        LDX $06                                 ;$04F90C        |
        DEX                                     ;$04F90E        |
        DEX                                     ;$04F90F        |
        BPL ADDR_04F8E8                         ;$04F910        |
        LDX.w $0DDE                             ;$04F912        |
        JSR CODE_04FE62                         ;$04F915        |
        LDA.b #$32                              ;$04F918        |
        XBA                                     ;$04F91A        |
        LDA.b #$26                              ;$04F91B        |
        JSR CODE_04FB7A                         ;$04F91D        |
        LDA.w $0E15,X                           ;$04F920        |
        BEQ ADDR_04F928                         ;$04F923        |
        JMP ADDR_04FF2E                         ;$04F925        |

ADDR_04F928:
        LDA.w $0E05,X
        AND.b #$01                              ;$04F92B        |
        TAY                                     ;$04F92D        |
        LDA.w $0EB5,X                           ;$04F92E        |
        CLC                                     ;$04F931        |
        ADC.w DATA_04F8C6,Y                     ;$04F932        |
        STA.w $0EB5,X                           ;$04F935        |
        CMP.w DATA_04F8CA,Y                     ;$04F938        |
        BNE ADDR_04F945                         ;$04F93B        |
        LDA.w $0E05,X                           ;$04F93D        |
        EOR.b #$01                              ;$04F940        |
        STA.w $0E05,X                           ;$04F942        |
ADDR_04F945:
        JSR ADDR_04FEEF
        LDY.w $0DF5,X                           ;$04F948        |
        LDA.w $0E04,X                           ;$04F94B        |
        ASL                                     ;$04F94E        |
        EOR $00                                 ;$04F94F        |
        BPL ADDR_04F95D                         ;$04F951        |
        LDA $06                                 ;$04F953        |
        CMP.w DATA_04F8B6,Y                     ;$04F955        |
        LDA.w #$0040                            ;$04F958        |
        BCS ADDR_04F96D                         ;$04F95B        |
ADDR_04F95D:
        LDA.w $0E04,X
        EOR $02                                 ;$04F960        |
        ASL                                     ;$04F962        |
        BCC ADDR_04F96D                         ;$04F963        |
        LDA $08                                 ;$04F965        |
        CMP.w DATA_04F8BE,Y                     ;$04F967        |
        LDA.w #$0080                            ;$04F96A        |
ADDR_04F96D:
        SEP #$20
        BCC ADDR_04F97F                         ;$04F96F        |
        EOR.w $0E05,X                           ;$04F971        |
        STA.w $0E05,X                           ;$04F974        |
        JSR CODE_04FE5B                         ;$04F977        |
        AND.b #$06                              ;$04F97A        |
        STA.w $0DF5,X                           ;$04F97C        |
ADDR_04F97F:
        TXA
        CLC                                     ;$04F980        |
        ADC.b #$10                              ;$04F981        |
        TAX                                     ;$04F983        |
        LDA.w $0DF5,X                           ;$04F984        |
        ASL                                     ;$04F987        |
        JSR ADDR_04F993                         ;$04F988        |
        LDX.w $0DDE                             ;$04F98B        |
        LDA.w $0E05,X                           ;$04F98E        |
        ASL                                     ;$04F991        |
        ASL                                     ;$04F992        |
ADDR_04F993:
        LDY.b #$00
        BCS ADDR_04F998                         ;$04F995        |
        INY                                     ;$04F997        |
ADDR_04F998:
        LDA.w $0E95,X
        CLC                                     ;$04F99B        |
        ADC.w DATA_04F8C6,Y                     ;$04F99C        |
        CMP.w DATA_04F8C8,Y                     ;$04F99F        |
        BEQ Return04F9A7                        ;$04F9A2        |
        STA.w $0E95,X                           ;$04F9A4        |
Return04F9A7:
        RTS

DATA_04F9A8:
        db $4E,$4F,$5E,$4F

DATA_04F9AC:
        db $08,$07,$04,$07

DATA_04F9B0:
        db $00,$01,$04,$01

DATA_04F9B4:
        db $01,$07,$09,$07

ADDR_04F9B8:
        CLC
        JSR ADDR_04FE00                         ;$04F9B9        |
        JSR ADDR_04FEEF                         ;$04F9BC        |
        SEP #$20                                ;$04F9BF        |
        LDY.b #$00                              ;$04F9C1        |
        LDA $01                                 ;$04F9C3        |
        BMI ADDR_04F9C8                         ;$04F9C5        |
        INY                                     ;$04F9C7        |
ADDR_04F9C8:
        LDA.w $0E95,X
        CLC                                     ;$04F9CB        |
        ADC.w DATA_04F8C6,Y                     ;$04F9CC        |
        CMP.w DATA_04F8C8,Y                     ;$04F9CF        |
        BEQ ADDR_04F9D7                         ;$04F9D2        |
        STA.w $0E95,X                           ;$04F9D4        |
ADDR_04F9D7:
        LDY.w $0DD6
        LDA.w $1F19,Y                           ;$04F9DA        |
        STA.w $0E45,X                           ;$04F9DD        |
        LDA.w $1F1A,Y                           ;$04F9E0        |
        STA.w $0E75,X                           ;$04F9E3        |
        JSR CODE_04FE90                         ;$04F9E6        |
        JSR CODE_04FE62                         ;$04F9E9        |
        LDA.b #$36                              ;$04F9EC        |
        LDY.w $0E95,X                           ;$04F9EE        |
        BMI ADDR_04F9F5                         ;$04F9F1        |
        ORA.b #$40                              ;$04F9F3        |
ADDR_04F9F5:
        PHA
        XBA                                     ;$04F9F6        |
        LDA.b #$4C                              ;$04F9F7        |
        JSR CODE_04FB7A                         ;$04F9F9        |
        PLA                                     ;$04F9FC        |
        XBA                                     ;$04F9FD        |
        JSR CODE_04FE5B                         ;$04F9FE        |
        LSR                                     ;$04FA01        |
        LSR                                     ;$04FA02        |
        LSR                                     ;$04FA03        |
        AND.b #$03                              ;$04FA04        |
        TAY                                     ;$04FA06        |
        LDA.w DATA_04F9AC,Y                     ;$04FA07        |
        BIT.w $0E95,X                           ;$04FA0A        |
        BMI ADDR_04FA12                         ;$04FA0D        |
        LDA.w DATA_04F9B0,Y                     ;$04FA0F        |
ADDR_04FA12:
        CLC
        ADC $00                                 ;$04FA13        |
        STA $00                                 ;$04FA15        |
        BCC ADDR_04FA1B                         ;$04FA17        |
        INC $01                                 ;$04FA19        |
ADDR_04FA1B:
        LDA.w DATA_04F9B4,Y
        CLC                                     ;$04FA1E        |
        ADC $02                                 ;$04FA1F        |
        STA $02                                 ;$04FA21        |
        BCC ADDR_04FA27                         ;$04FA23        |
        INC $03                                 ;$04FA25        |
ADDR_04FA27:
        LDA.w DATA_04F9A8,Y
        CLC                                     ;$04FA2A        |
        JMP CODE_04FB7B                         ;$04FA2B        |

DATA_04FA2E:
        db $70,$50,$B0

DATA_04FA31:
        db $00,$01,$00

DATA_04FA34:
        db $CF,$8F,$7F

DATA_04FA37:
        db $00,$00,$01

DATA_04FA3A:
        db $73,$72,$63,$62

CODE_04FA3E:
        LDA.w $0DF5,X
        BNE CODE_04FA83                         ;$04FA41        |
        LDA.w $13C1                             ;$04FA43        |
        SEC                                     ;$04FA46        |
        SBC.b #$4E                              ;$04FA47        |
        CMP.b #$03                              ;$04FA49        |
        BCS Return04FA82                        ;$04FA4B        |
        TAY                                     ;$04FA4D        |
        LDA.w DATA_04FA2E,Y                     ;$04FA4E        |
        STA.w $0E35,X                           ;$04FA51        |
        LDA.w DATA_04FA31,Y                     ;$04FA54        |
        STA.w $0E65,X                           ;$04FA57        |
        LDA.w DATA_04FA34,Y                     ;$04FA5A        |
        STA.w $0E45,X                           ;$04FA5D        |
        LDA.w DATA_04FA37,Y                     ;$04FA60        |
        STA.w $0E75,X                           ;$04FA63        |
        JSR CODE_04FE5B                         ;$04FA66        |
        LSR                                     ;$04FA69        |
        ROR                                     ;$04FA6A        |
        LSR                                     ;$04FA6B        |
        AND.b #$40                              ;$04FA6C        |
        ORA.b #$12                              ;$04FA6E        |
        STA.w $0DF5,X                           ;$04FA70        |
        LDA.b #$24                              ;$04FA73        |
        STA.w $0EB5,X                           ;$04FA75        |
        LDA.b #$0E                              ;$04FA78        |
        STA.w $1DF9                             ;$04FA7A        |
CODE_04FA7D:
        LDA.b #$0F
        STA.w $0E25,X                           ;$04FA7F        |
Return04FA82:
        RTS

CODE_04FA83:
        DEC.w $0EB5,X
        LDA.w $0EB5,X                           ;$04FA86        |
        CMP.b #$E4                              ;$04FA89        |
        BNE CODE_04FA90                         ;$04FA8B        |
        JSR CODE_04FA7D                         ;$04FA8D        |
CODE_04FA90:
        JSR CODE_04FE90
        LDA.w $0E55,X                           ;$04FA93        |
        ORA.w $0E25,X                           ;$04FA96        |
        BNE CODE_04FA9E                         ;$04FA99        |
        STZ.w $0DF5,X                           ;$04FA9B        |
CODE_04FA9E:
        JSR CODE_04FE62
        LDA.w $0DF5,X                           ;$04FAA1        |
        LDY.b #$08                              ;$04FAA4        |
        BIT.w $0EB5,X                           ;$04FAA6        |
        BPL CODE_04FAAF                         ;$04FAA9        |
        EOR.b #$C0                              ;$04FAAB        |
        LDY.b #$10                              ;$04FAAD        |
CODE_04FAAF:
        XBA
        TYA                                     ;$04FAB0        |
        LDY.b #$4A                              ;$04FAB1        |
        AND $13                                 ;$04FAB3        |
        BEQ CODE_04FAB9                         ;$04FAB5        |
        LDY.b #$48                              ;$04FAB7        |
CODE_04FAB9:
        TYA
        JSR CODE_04FB06                         ;$04FABA        |
        JSR CODE_04FE4E                         ;$04FABD        |
        SEC                                     ;$04FAC0        |
        SBC.b #$08                              ;$04FAC1        |
        STA $02                                 ;$04FAC3        |
        BCS CODE_04FAC9                         ;$04FAC5        |
        DEC $03                                 ;$04FAC7        |
CODE_04FAC9:
        LDA.b #$36
        XBA                                     ;$04FACB        |
        LDA.w $0E25,X                           ;$04FACC        |
        BEQ Return04FA82                        ;$04FACF        |
        LSR                                     ;$04FAD1        |
        LSR                                     ;$04FAD2        |
        PHY                                     ;$04FAD3        |
        TAY                                     ;$04FAD4        |
        LDA.w DATA_04FA3A,Y                     ;$04FAD5        |
        PLY                                     ;$04FAD8        |
        PHA                                     ;$04FAD9        |
        JSR CODE_04FAED                         ;$04FADA        |
        REP #$20                                ;$04FADD        |
        LDA $00                                 ;$04FADF        |
        CLC                                     ;$04FAE1        |
        ADC.w #$0008                            ;$04FAE2        |
        STA $00                                 ;$04FAE5        |
        SEP #$20                                ;$04FAE7        |
        LDA.b #$76                              ;$04FAE9        |
        XBA                                     ;$04FAEB        |
        PLA                                     ;$04FAEC        |
CODE_04FAED:
        CLC
        JMP CODE_04FB0A                         ;$04FAEE        |

ADDR_04FAF1:
        JSR ADDR_04FED7
        JSR CODE_04FE62                         ;$04FAF4        |
        JSR CODE_04FE5B                         ;$04FAF7        |
        LDY.b #$2A                              ;$04FAFA        |
        AND.b #$08                              ;$04FAFC        |
        BEQ ADDR_04FB02                         ;$04FAFE        |
        LDY.b #$2C                              ;$04FB00        |
ADDR_04FB02:
        LDA.b #$32
        XBA                                     ;$04FB04        |
        TYA                                     ;$04FB05        |
CODE_04FB06:
        SEC
        LDY.w DATA_04F843,X                     ;$04FB07        |
CODE_04FB0A:
        STA.w $0242,Y
        XBA                                     ;$04FB0D        |
        STA.w $0243,Y                           ;$04FB0E        |
        LDA $01                                 ;$04FB11        |
        BNE Return04FB36                        ;$04FB13        |
        LDA $00                                 ;$04FB15        |
        STA.w $0240,Y                           ;$04FB17        |
        LDA $03                                 ;$04FB1A        |
        BNE Return04FB36                        ;$04FB1C        |
        PHP                                     ;$04FB1E        |
        LDA $02                                 ;$04FB1F        |
        STA.w $0241,Y                           ;$04FB21        |
        TYA                                     ;$04FB24        |
        LSR                                     ;$04FB25        |
        LSR                                     ;$04FB26        |
        PLP                                     ;$04FB27        |
        PHY                                     ;$04FB28        |
        TAY                                     ;$04FB29        |
        ROL                                     ;$04FB2A        |
        ASL                                     ;$04FB2B        |
        AND.b #$03                              ;$04FB2C        |
        STA.w $0430,Y                           ;$04FB2E        |
        PLY                                     ;$04FB31        |
        DEY                                     ;$04FB32        |
        DEY                                     ;$04FB33        |
        DEY                                     ;$04FB34        |
        DEY                                     ;$04FB35        |
Return04FB36:
        RTS

CODE_04FB37:
        LDA.b #$02
        STA.w $0E95,X                           ;$04FB39        |
        LDA.b #$FF                              ;$04FB3C        |
        STA.w $0EA5,X                           ;$04FB3E        |
        JSR CODE_04FE90                         ;$04FB41        |
        JSR CODE_04FE62                         ;$04FB44        |
        REP #$20                                ;$04FB47        |
        LDA $00                                 ;$04FB49        |
        CLC                                     ;$04FB4B        |
        ADC.w #$0020                            ;$04FB4C        |
        CMP.w #$0140                            ;$04FB4F        |
        BCS CODE_04FB5D                         ;$04FB52        |
        LDA $02                                 ;$04FB54        |
        CLC                                     ;$04FB56        |
        ADC.w #$0080                            ;$04FB57        |
        CMP.w #$01A0                            ;$04FB5A        |
CODE_04FB5D:
        SEP #$20
        BCC CODE_04FB64                         ;$04FB5F        |
        STZ.w $0DE5,X                           ;$04FB61        |
CODE_04FB64:
        LDA.b #$32
        JSR CODE_04FB77                         ;$04FB66        |
        REP #$20                                ;$04FB69        |
        LDA $00                                 ;$04FB6B        |
        CLC                                     ;$04FB6D        |
        ADC.w #$0010                            ;$04FB6E        |
        STA $00                                 ;$04FB71        |
        SEP #$20                                ;$04FB73        |
        LDA.b #$72                              ;$04FB75        |
CODE_04FB77:
        XBA
        LDA.b #$44                              ;$04FB78        |
CODE_04FB7A:
        SEC
CODE_04FB7B:
        LDY.w $0DDF
        JSR CODE_04FB0A                         ;$04FB7E        |
        STY.w $0DDF                             ;$04FB81        |
Return04FB84:
        RTS

DATA_04FB85:
        db $80,$40,$20

DATA_04FB88:
        db $30,$10,$C0

DATA_04FB8B:
        db $01,$01,$01

DATA_04FB8E:
        db $7F,$7F,$8F

DATA_04FB91:
        db $01,$00

DATA_04FB93:
        db $01,$08

DATA_04FB95:
        db $02,$0F,$00

CODE_04FB98:
        LDA.w $0DF5,X
        BNE ADDR_04FBD8                         ;$04FB9B        |
        LDA.w $13C1                             ;$04FB9D        |
        SEC                                     ;$04FBA0        |
        SBC.b #$49                              ;$04FBA1        |
        CMP.b #$03                              ;$04FBA3        |
        BCS Return04FB84                        ;$04FBA5        |
        TAY                                     ;$04FBA7        |
        STA.w $0EF6                             ;$04FBA8        |
        LDA.w $0EF5                             ;$04FBAB        |
        AND.w DATA_04FB85,Y                     ;$04FBAE        |
        BNE Return04FB84                        ;$04FBB1        |
        LDA.w DATA_04FB88,Y                     ;$04FBB3        |
        STA.w $0E35,X                           ;$04FBB6        |
        LDA.w DATA_04FB8B,Y                     ;$04FBB9        |
        STA.w $0E65,X                           ;$04FBBC        |
        LDA.w DATA_04FB8E,Y                     ;$04FBBF        |
        STA.w $0E45,X                           ;$04FBC2        |
        LDA.w DATA_04FB91,Y                     ;$04FBC5        |
        STA.w $0E75,X                           ;$04FBC8        |
        LDA.b #$02                              ;$04FBCB        |
        STA.w $0DF5,X                           ;$04FBCD        |
        LDA.b #$F0                              ;$04FBD0        |
        STA.w $0E95,X                           ;$04FBD2        |
        STZ.w $0E25,X                           ;$04FBD5        |
ADDR_04FBD8:
        JSR CODE_04FE62
        LDA.w $0E25,X                           ;$04FBDB        |
        BNE ADDR_04FC00                         ;$04FBDE        |
        INC.w $0E05,X                           ;$04FBE0        |
        JSR CODE_04FEAB                         ;$04FBE3        |
        LDY.w $0DF5,X                           ;$04FBE6        |
        LDA.w $0E35,X                           ;$04FBE9        |
        AND.b #$0F                              ;$04FBEC        |
        CMP.w DATA_04FB95,Y                     ;$04FBEE        |
        BNE ADDR_04FC00                         ;$04FBF1        |
        DEC.w $0DF5,X                           ;$04FBF3        |
        LDA.b #$04                              ;$04FBF6        |
        STA.w $0E95,X                           ;$04FBF8        |
        LDA.b #$60                              ;$04FBFB        |
        STA.w $0E25,X                           ;$04FBFD        |
ADDR_04FC00:
        LDA.w DATA_04FB93,Y
        LDY.b #$22                              ;$04FC03        |
        AND.w $0E05,X                           ;$04FC05        |
        BNE ADDR_04FC0C                         ;$04FC08        |
        LDY.b #$62                              ;$04FC0A        |
ADDR_04FC0C:
        TYA
        XBA                                     ;$04FC0D        |
        LDA.b #$6A                              ;$04FC0E        |
        JSR CODE_04FB06                         ;$04FC10        |
        JSR ADDR_04FED7                         ;$04FC13        |
        BCS Return04FC1D                        ;$04FC16        |
        ORA.b #$80                              ;$04FC18        |
        STA.w $0EF7                             ;$04FC1A        |
Return04FC1D:
        RTS

DATA_04FC1E:
        db $38

DATA_04FC1F:
        db $00,$68,$00

DATA_04FC22:
        db $8A

DATA_04FC23:
        db $01,$6A,$00

DATA_04FC26:
        db $01,$02,$03,$04,$03,$02,$01,$00
        db $01,$02,$03,$04,$03,$02,$01,$00
DATA_04FC36:
        db $FF,$FF,$FE,$FD,$FD,$FC,$FB,$FB
        db $FA,$F9,$F9,$F8,$F7,$F7,$F6,$F5

CODE_04FC46:
        LDA.w $0DD6
        LSR                                     ;$04FC49        |
        LSR                                     ;$04FC4A        |
        TAY                                     ;$04FC4B        |
        LDA.w $1F11,Y                           ;$04FC4C        |
        ASL                                     ;$04FC4F        |
        TAY                                     ;$04FC50        |
        LDA.w DATA_04FC1E,Y                     ;$04FC51        |
        STA.w $0E35,X                           ;$04FC54        |
        LDA.w DATA_04FC1F,Y                     ;$04FC57        |
        STA.w $0E65,X                           ;$04FC5A        |
        LDA.w DATA_04FC22,Y                     ;$04FC5D        |
        STA.w $0E45,X                           ;$04FC60        |
        LDA.w DATA_04FC23,Y                     ;$04FC63        |
        STA.w $0E75,X                           ;$04FC66        |
        LDA $13                                 ;$04FC69        |
        AND.b #$0F                              ;$04FC6B        |
        BNE CODE_04FC7C                         ;$04FC6D        |
        LDA.w $0DF5,X                           ;$04FC6F        |
        INC A                                   ;$04FC72        |
        CMP.b #$0C                              ;$04FC73        |
        BCC CODE_04FC79                         ;$04FC75        |
        LDA.b #$00                              ;$04FC77        |
CODE_04FC79:
        STA.w $0DF5,X
CODE_04FC7C:
        LDA.b #$03
        STA $04                                 ;$04FC7E        |
        LDA $13                                 ;$04FC80        |
        STA $06                                 ;$04FC82        |
        STZ $07                                 ;$04FC84        |
        LDY.w DATA_04F843,X                     ;$04FC86        |
        LDA.w $0DF5,X                           ;$04FC89        |
        TAX                                     ;$04FC8C        |
CODE_04FC8D:
        PHY
        PHX                                     ;$04FC8E        |
        LDX.w $0DDE                             ;$04FC8F        |
        JSR CODE_04FE62                         ;$04FC92        |
        PLX                                     ;$04FC95        |
        LDA $07                                 ;$04FC96        |
        CLC                                     ;$04FC98        |
        ADC.w DATA_04FC36,X                     ;$04FC99        |
        CLC                                     ;$04FC9C        |
        ADC $02                                 ;$04FC9D        |
        STA $02                                 ;$04FC9F        |
        BCS CODE_04FCA5                         ;$04FCA1        |
        DEC $03                                 ;$04FCA3        |
CODE_04FCA5:
        LDA $00
        CLC                                     ;$04FCA7        |
        ADC.w DATA_04FC26,X                     ;$04FCA8        |
        STA $00                                 ;$04FCAB        |
        BCC CODE_04FCB1                         ;$04FCAD        |
        INC $01                                 ;$04FCAF        |
CODE_04FCB1:
        TXA
        CLC                                     ;$04FCB2        |
        ADC.b #$0C                              ;$04FCB3        |
        CMP.b #$10                              ;$04FCB5        |
        AND.b #$0F                              ;$04FCB7        |
        TAX                                     ;$04FCB9        |
        BCC CODE_04FCC2                         ;$04FCBA        |
        LDA $07                                 ;$04FCBC        |
        SBC.b #$0C                              ;$04FCBE        |
        STA $07                                 ;$04FCC0        |
CODE_04FCC2:
        LDA.b #$30
        XBA                                     ;$04FCC4        |
        LDY.b #$28                              ;$04FCC5        |
        LDA $06                                 ;$04FCC7        |
        CLC                                     ;$04FCC9        |
        ADC.b #$0A                              ;$04FCCA        |
        STA $06                                 ;$04FCCC        |
        AND.b #$20                              ;$04FCCE        |
        BEQ CODE_04FCD4                         ;$04FCD0        |
        LDY.b #$5F                              ;$04FCD2        |
CODE_04FCD4:
        TYA
        PLY                                     ;$04FCD5        |
        JSR CODE_04FAED                         ;$04FCD6        |
        DEC $04                                 ;$04FCD9        |
        BNE CODE_04FC8D                         ;$04FCDB        |
        LDX.w $0DDE                             ;$04FCDD        |
        RTS                                     ;$04FCE0        |

CODE_04FCE1:
        JSR CODE_04FE62
        LDA.b #$04                              ;$04FCE4        |
        STA $04                                 ;$04FCE6        |
        LDA.b #$6F                              ;$04FCE8        |
        STA $05                                 ;$04FCEA        |
        LDY.w DATA_04F843,X                     ;$04FCEC        |
CODE_04FCEF:
        LDA $13
        LSR                                     ;$04FCF1        |
        AND.b #$06                              ;$04FCF2        |
        ORA.b #$30                              ;$04FCF4        |
        XBA                                     ;$04FCF6        |
        LDA $05                                 ;$04FCF7        |
        JSR CODE_04FAED                         ;$04FCF9        |
        LDA $00                                 ;$04FCFC        |
        SEC                                     ;$04FCFE        |
        SBC.b #$08                              ;$04FCFF        |
        STA $00                                 ;$04FD01        |
        DEC $05                                 ;$04FD03        |
        DEC $04                                 ;$04FD05        |
        BNE CODE_04FCEF                         ;$04FD07        |
        RTS                                     ;$04FD09        |

DATA_04FD0A:
        db $07,$07,$03,$03,$5F,$5F

DATA_04FD10:
        db $01,$FF,$01,$FF,$01,$FF,$01,$FF
        db $01,$FF

DATA_04FD1A:
        db $18,$E8,$0A,$F6,$08,$F8,$03,$FD
DATA_04FD22:
        db $01,$FF

CODE_04FD24:
        JSR CODE_04FE90
        JSR CODE_04FE62                         ;$04FD27        |
        JSR CODE_04FE62                         ;$04FD2A        |
        LDA.b #$00                              ;$04FD2D        |
        LDY.w $0E95,X                           ;$04FD2F        |
        BMI CODE_04FD36                         ;$04FD32        |
        LDA.b #$40                              ;$04FD34        |
CODE_04FD36:
        XBA
        LDA.b #$68                              ;$04FD37        |
        JSR CODE_04FB06                         ;$04FD39        |
        INC.w $0E15,X                           ;$04FD3C        |
        LDA.w $0E15,X                           ;$04FD3F        |
        LSR                                     ;$04FD42        |
        BCS Return04FD6F                        ;$04FD43        |
        LDA.w $0E05,X                           ;$04FD45        |
        ORA.b #$02                              ;$04FD48        |
        TAY                                     ;$04FD4A        |
        TXA                                     ;$04FD4B        |
        ADC.b #$10                              ;$04FD4C        |
        TAX                                     ;$04FD4E        |
        JSR CODE_04FD55                         ;$04FD4F        |
        LDY.w $0DF5,X                           ;$04FD52        |
CODE_04FD55:
        LDA.w $0E95,X
        CLC                                     ;$04FD58        |
        ADC.w DATA_04FD10,Y                     ;$04FD59        |
        STA.w $0E95,X                           ;$04FD5C        |
        CMP.w DATA_04FD1A,Y                     ;$04FD5F        |
        BNE CODE_04FD68                         ;$04FD62        |
        TYA                                     ;$04FD64        |
        EOR.b #$01                              ;$04FD65        |
        TAY                                     ;$04FD67        |
CODE_04FD68:
        TYA
        STA.w $0DF5,X                           ;$04FD69        |
        LDX.w $0DDE                             ;$04FD6C        |
Return04FD6F:
        RTS

CODE_04FD70:
        JSR CODE_04FE90
        JSR CODE_04FE62                         ;$04FD73        |
        JSR CODE_04FE62                         ;$04FD76        |
        LDY.w $0DB3                             ;$04FD79        |
        LDA.w $1F11,Y                           ;$04FD7C        |
        BEQ CODE_04FDA5                         ;$04FD7F        |
        CPX.b #$0F                              ;$04FD81        |
        BNE CODE_04FD8E                         ;$04FD83        |
        LDA.w $1F07                             ;$04FD85        |
        AND.b #$12                              ;$04FD88        |
        BNE CODE_04FD8E                         ;$04FD8A        |
        STX $03                                 ;$04FD8C        |
CODE_04FD8E:
        TXA
        ASL                                     ;$04FD8F        |
        TAY                                     ;$04FD90        |
        REP #$20                                ;$04FD91        |
        LDA $00                                 ;$04FD93        |
        CLC                                     ;$04FD95        |
        ADC.w DATA_04F64C,Y                     ;$04FD96        |
        STA $00                                 ;$04FD99        |
        LDA $02                                 ;$04FD9B        |
        CLC                                     ;$04FD9D        |
        ADC.w DATA_04F652,Y                     ;$04FD9E        |
        STA $02                                 ;$04FDA1        |
        SEP #$20                                ;$04FDA3        |
CODE_04FDA5:
        LDA.b #$34
        LDY.w $0E95,X                           ;$04FDA7        |
        BMI CODE_04FDAE                         ;$04FDAA        |
        LDA.b #$44                              ;$04FDAC        |
CODE_04FDAE:
        XBA
        LDA.b #$60                              ;$04FDAF        |
        JSR CODE_04FB06                         ;$04FDB1        |
        LDA.w $0E25,X                           ;$04FDB4        |
        STA $00                                 ;$04FDB7        |
        INC.w $0E25,X                           ;$04FDB9        |
        TXA                                     ;$04FDBC        |
        CLC                                     ;$04FDBD        |
        ADC.b #$20                              ;$04FDBE        |
        TAX                                     ;$04FDC0        |
        LDA.b #$08                              ;$04FDC1        |
        JSR CODE_04FDD2                         ;$04FDC3        |
        TXA                                     ;$04FDC6        |
        CLC                                     ;$04FDC7        |
        ADC.b #$10                              ;$04FDC8        |
        TAX                                     ;$04FDCA        |
        LDA.b #$06                              ;$04FDCB        |
        JSR CODE_04FDD2                         ;$04FDCD        |
        LDA.b #$04                              ;$04FDD0        |
CODE_04FDD2:
        ORA.w $0DF5,X
        TAY                                     ;$04FDD5        |
        LDA.w $FD06,Y                           ;$04FDD6        |
        AND $00                                 ;$04FDD9        |
        BNE CODE_04FD68                         ;$04FDDB        |
        JMP CODE_04FD55                         ;$04FDDD        |

DATA_04FDE0:
        db $00,$00,$00,$00,$01,$02,$02,$02
        db $00,$00,$01,$01,$02,$02,$03,$03
DATA_04FDF0:
        db $08,$08,$08,$08,$07,$06,$05,$05
        db $00,$00,$0E,$0E,$0C,$0C,$0A,$0A

ADDR_04FE00:
        ROR $04
        JSR CODE_04FE62                         ;$04FE02        |
        JSR CODE_04FE4E                         ;$04FE05        |
        LDA.w $0E55,X                           ;$04FE08        |
        LSR                                     ;$04FE0B        |
        LSR                                     ;$04FE0C        |
        LSR                                     ;$04FE0D        |
        LSR                                     ;$04FE0E        |
        LDY.b #$29                              ;$04FE0F        |
        BIT $04                                 ;$04FE11        |
        BPL ADDR_04FE1A                         ;$04FE13        |
        LDY.b #$2E                              ;$04FE15        |
        CLC                                     ;$04FE17        |
        ADC.b #$08                              ;$04FE18        |
ADDR_04FE1A:
        STY $05
        TAY                                     ;$04FE1C        |
        STY $06                                 ;$04FE1D        |
        LDA $00                                 ;$04FE1F        |
        CLC                                     ;$04FE21        |
        ADC.w DATA_04FDE0,Y                     ;$04FE22        |
        STA $00                                 ;$04FE25        |
        BCC ADDR_04FE2B                         ;$04FE27        |
        INC $01                                 ;$04FE29        |
ADDR_04FE2B:
        LDA.b #$32
        LDY.w DATA_04F843,X                     ;$04FE2D        |
        JSR ADDR_04FE45                         ;$04FE30        |
        PHY                                     ;$04FE33        |
        LDY $06                                 ;$04FE34        |
        LDA $00                                 ;$04FE36        |
        CLC                                     ;$04FE38        |
        ADC.w DATA_04FDF0,Y                     ;$04FE39        |
        STA $00                                 ;$04FE3C        |
        BCC ADDR_04FE42                         ;$04FE3E        |
        INC $01                                 ;$04FE40        |
ADDR_04FE42:
        LDA.b #$72
        PLY                                     ;$04FE44        |
ADDR_04FE45:
        XBA
        LDA $04                                 ;$04FE46        |
        ASL                                     ;$04FE48        |
        LDA $05                                 ;$04FE49        |
        JMP CODE_04FB0A                         ;$04FE4B        |

CODE_04FE4E:
        LDA $02
        CLC                                     ;$04FE50        |
        ADC.w $0E55,X                           ;$04FE51        |
        STA $02                                 ;$04FE54        |
        BCC Return04FE5A                        ;$04FE56        |
        INC $03                                 ;$04FE58        |
Return04FE5A:
        RTS

CODE_04FE5B:
        LDA $13
        CLC                                     ;$04FE5D        |
        ADC.w DATA_04F833,X                     ;$04FE5E        |
        RTS                                     ;$04FE61        |

CODE_04FE62:
        TXA
        CLC                                     ;$04FE63        |
        ADC.b #$10                              ;$04FE64        |
        TAX                                     ;$04FE66        |
        LDY.b #$02                              ;$04FE67        |
        JSR CODE_04FE7D                         ;$04FE69        |
        LDX.w $0DDE                             ;$04FE6C        |
        LDA $02                                 ;$04FE6F        |
        SEC                                     ;$04FE71        |
        SBC.w $0E55,X                           ;$04FE72        |
        STA $02                                 ;$04FE75        |
        BCS CODE_04FE7B                         ;$04FE77        |
        DEC $03                                 ;$04FE79        |
CODE_04FE7B:
        LDY.b #$00
CODE_04FE7D:
        LDA.w $0E65,X
        XBA                                     ;$04FE80        |
        LDA.w $0E35,X                           ;$04FE81        |
        REP #$20                                ;$04FE84        |
        SEC                                     ;$04FE86        |
        SBC.w $001A,y                           ;$04FE87        |
        STA.w $0000,Y                           ;$04FE8A        |
        SEP #$20                                ;$04FE8D        |
        RTS                                     ;$04FE8F        |

CODE_04FE90:
        TXA
        CLC                                     ;$04FE91        |
        ADC.b #$20                              ;$04FE92        |
        TAX                                     ;$04FE94        |
        JSR CODE_04FEAB                         ;$04FE95        |
        LDA.w $0E35,X                           ;$04FE98        |
        BPL CODE_04FEA0                         ;$04FE9B        |
        STZ.w $0E35,X                           ;$04FE9D        |
CODE_04FEA0:
        TXA
        SEC                                     ;$04FEA1        |
        SBC.b #$10                              ;$04FEA2        |
        TAX                                     ;$04FEA4        |
        JSR CODE_04FEAB                         ;$04FEA5        |
        LDX.w $0DDE                             ;$04FEA8        |
CODE_04FEAB:
        LDA.w $0E95,X
        ASL                                     ;$04FEAE        |
        ASL                                     ;$04FEAF        |
        ASL                                     ;$04FEB0        |
        ASL                                     ;$04FEB1        |
        CLC                                     ;$04FEB2        |
        ADC.w $0EC5,X                           ;$04FEB3        |
        STA.w $0EC5,X                           ;$04FEB6        |
        LDA.w $0E95,X                           ;$04FEB9        |
        PHP                                     ;$04FEBC        |
        LSR                                     ;$04FEBD        |
        LSR                                     ;$04FEBE        |
        LSR                                     ;$04FEBF        |
        LSR                                     ;$04FEC0        |
        LDY.b #$00                              ;$04FEC1        |
        PLP                                     ;$04FEC3        |
        BPL CODE_04FEC9                         ;$04FEC4        |
        ORA.b #$F0                              ;$04FEC6        |
        DEY                                     ;$04FEC8        |
CODE_04FEC9:
        ADC.w $0E35,X
        STA.w $0E35,X                           ;$04FECC        |
        TYA                                     ;$04FECF        |
        ADC.w $0E65,X                           ;$04FED0        |
        STA.w $0E65,X                           ;$04FED3        |
        RTS                                     ;$04FED6        |

ADDR_04FED7:
        JSR ADDR_04FEEF
        LDA $06                                 ;$04FEDA        |
        CMP.w #$0008                            ;$04FEDC        |
        BCS ADDR_04FEE6                         ;$04FEDF        |
        LDA $08                                 ;$04FEE1        |
        CMP.w #$0008                            ;$04FEE3        |
ADDR_04FEE6:
        SEP #$20
        TXA                                     ;$04FEE8        |
        BCS Return04FEEE                        ;$04FEE9        |
        STA.w $0EF7                             ;$04FEEB        |
Return04FEEE:
        RTS

ADDR_04FEEF:
        LDA.w $0E65,X
        XBA                                     ;$04FEF2        |
        LDA.w $0E35,X                           ;$04FEF3        |
        REP #$20                                ;$04FEF6        |
        CLC                                     ;$04FEF8        |
        ADC.w #$0008                            ;$04FEF9        |
        LDY.w $0DD6                             ;$04FEFC        |
        SEC                                     ;$04FEFF        |
        SBC.w $1F17,Y                           ;$04FF00        |
        STA $00                                 ;$04FF03        |
        BPL ADDR_04FF0B                         ;$04FF05        |
        EOR.w #$FFFF                            ;$04FF07        |
        INC A                                   ;$04FF0A        |
ADDR_04FF0B:
        STA $06
        SEP #$20                                ;$04FF0D        |
        LDA.w $0E75,X                           ;$04FF0F        |
        XBA                                     ;$04FF12        |
        LDA.w $0E45,X                           ;$04FF13        |
        REP #$20                                ;$04FF16        |
        CLC                                     ;$04FF18        |
        ADC.w #$0008                            ;$04FF19        |
        LDY.w $0DD6                             ;$04FF1C        |
        SEC                                     ;$04FF1F        |
        SBC.w $1F19,Y                           ;$04FF20        |
        STA $02                                 ;$04FF23        |
        BPL ADDR_04FF2B                         ;$04FF25        |
        EOR.w #$FFFF                            ;$04FF27        |
        INC A                                   ;$04FF2A        |
ADDR_04FF2B:
        STA $08
        RTS                                     ;$04FF2D        |

ADDR_04FF2E:
        JSR ADDR_04FEEF
        LSR $06                                 ;$04FF31        |
        LSR $08                                 ;$04FF33        |
        SEP #$20                                ;$04FF35        |
        LDA.w $0E55,X                           ;$04FF37        |
        LSR                                     ;$04FF3A        |
        STA $0A                                 ;$04FF3B        |
        STZ $05                                 ;$04FF3D        |
        LDY.b #$04                              ;$04FF3F        |
        CMP $08                                 ;$04FF41        |
        BCS ADDR_04FF49                         ;$04FF43        |
        LDY.b #$02                              ;$04FF45        |
        LDA $08                                 ;$04FF47        |
ADDR_04FF49:
        CMP $06
        BCS ADDR_04FF51                         ;$04FF4B        |
        LDY.b #$00                              ;$04FF4D        |
        LDA $06                                 ;$04FF4F        |
ADDR_04FF51:
        CMP.b #$01
        BCS ADDR_04FF67                         ;$04FF53        |
        STZ.w $0E15,X                           ;$04FF55        |
        STZ.w $0E95,X                           ;$04FF58        |
        STZ.w $0EA5,X                           ;$04FF5B        |
        STZ.w $0EB5,X                           ;$04FF5E        |
        LDA.b #$40                              ;$04FF61        |
        STA.w $0E55,X                           ;$04FF63        |
        RTS                                     ;$04FF66        |

ADDR_04FF67:
        STY $0C
        LDX.b #$04                              ;$04FF69        |
ADDR_04FF6B:
        CPX $0C
        BNE ADDR_04FF73                         ;$04FF6D        |
        LDA.b #$20                              ;$04FF6F        |
        BRA ADDR_04FF91                         ;$04FF71        |

ADDR_04FF73:
        STZ.w $4204
        LDA $06,X                               ;$04FF76        |
        STA.w $4205                             ;$04FF78        |
        LDA.w $0006,Y                           ;$04FF7B        |
        STA.w $4206                             ;$04FF7E        |
        NOP                                     ;$04FF81        |
        NOP                                     ;$04FF82        |
        NOP                                     ;$04FF83        |
        NOP                                     ;$04FF84        |
        NOP                                     ;$04FF85        |
        NOP                                     ;$04FF86        |
        REP #$20                                ;$04FF87        |
        LDA.w $4214                             ;$04FF89        |
        LSR                                     ;$04FF8C        |
        LSR                                     ;$04FF8D        |
        LSR                                     ;$04FF8E        |
        SEP #$20                                ;$04FF8F        |
ADDR_04FF91:
        BIT $01,X
        BMI ADDR_04FF98                         ;$04FF93        |
        EOR.b #$FF                              ;$04FF95        |
        INC A                                   ;$04FF97        |
ADDR_04FF98:
        STA $00,X
        DEX                                     ;$04FF9A        |
        DEX                                     ;$04FF9B        |
        BPL ADDR_04FF6B                         ;$04FF9C        |
        LDX.w $0DDE                             ;$04FF9E        |
        LDA $00                                 ;$04FFA1        |
        STA.w $0E95,X                           ;$04FFA3        |
        LDA $02                                 ;$04FFA6        |
        STA.w $0EA5,X                           ;$04FFA8        |
        LDA $04                                 ;$04FFAB        |
        STA.w $0EB5,X                           ;$04FFAD        |
        RTS                                     ;$04FFB0        |

DATA_04FFB1:
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF
