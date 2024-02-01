.scope FreeSynth

.include "util/read_controller.s"

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
    jsr ReadController::ReadController

parse_inputs:
    ;determine if channel is being incremented with B press
    lda %01000000
    and $20
    cmp #%01000000

play_sound:
    
    ;determine channel
    lda $00


    
    bne free_synth

    rts

.endproc
.endscope