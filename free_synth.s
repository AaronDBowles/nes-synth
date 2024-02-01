.export FreeSynth
.segment "CODE"


;zero page $0000 to $00FF
;nes ram is $0000 to $07FF
;A B Select Start Up Down Left Right
.proc FreeSynth
    
    ;initialize player1 channel selection byte
    lda #0
    sta $00

    ;initialize player1 sound byte
    lda #0
    sta $01

free_synth:
    ;store controller in $20
    jsr ReadController

play_sound:

    
    bne free_synth

    rts

.endproc