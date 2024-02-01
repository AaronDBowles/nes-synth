.scope FreeSynth

.include "util/read_controller.s"

;zero page $0000 to $00FF
;nes ram is $0000 to $07FF
;A B Select Start Up Down Left Right
    .proc FreeSynth
        
        ;initialize player1 channel selection byte
        lda #0
        sta $21

        ;initialize player1 sound byte
        lda #0
        sta $22

    free_synth:
        ;store controller in $20
        jsr ReadController::ReadController

    parse_inputs:
        ;determine if channel is being incremented with B press
        lda %01000000
        and $20
        cmp #%01000000
        ;if so, increment $21 to increase channel selection
        beq change_channel

    play_sound:
        ;for testing just play pulse
        lda #%00001111
        sta $4015
        lda #%11111100
        sta $4000
        lda #%0001111
        sta $4002
        lda #%1111011
        sta $4003

        ;determine channel
        


        
        ;bne free_synth

        rts

    .endproc

    .proc change_channel
        ;increment $21 to increase channel selection
        ldx $21
        inx
        stx $21
        lda #6
        cmp $21
        beq reset_channel
        rts

    reset_channel:
        lda #0
        sta $21
        rts
        
    .endproc
.endscope