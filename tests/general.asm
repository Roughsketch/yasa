LDA $0DBF
LDA $0DBF
SEC
label1:
SBC #$64          ;-100 coins (this code only runs when they're >100)
STA $0DBF : SEC
l2_:
LDA #$81
STA $17C0,y       ;cape smoke effect