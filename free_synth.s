.scope FreeSynth

.include "util/read_controller.s"

;zero page $0000 to $00FF
;nes ram is $0000 to $07FF
;A B Select Start Up Down Left Right
    .proc init
        ;initialize player1 channel selection byte
        lda #0
        sta $22
        ;initialize player1 sound byte
        lda #0
        sta $23
        jsr loop
    .endproc

    .proc loop
    free_synth:
        ;store controller in $20, previous controller capture in $21
        jsr ReadController::ReadController
        
    parse_inputs:
        ;check if inputs have even changed
        lda $20
        cmp $21
        ;if they havent changed, go back to top, nothing to do here
        beq free_synth
        ;determine if channel is being incremented with B press
        lda #%01000000
        and $20
        cmp #%01000000
        ;if so, increment $22 to increase channel selection
        beq change_channel

    play_sound:
        ;determine channel
        lda #0
        cmp $22
        beq play_pulse1
        lda #1
        cmp $22
        beq play_pulse2
        lda #2
        cmp $22
        beq play_tri
        lda #3
        cmp $22
        beq play_noise
        lda #4
        cmp $22
        beq play_dmc

        jsr loop

    .endproc

    .proc change_channel
        ;increment $22 to increase channel selection
        ldx $22
        inx
        stx $22
        lda #5
        cmp $22
        beq reset_channel
        jsr loop 

    reset_channel:
        lda #0
        sta $22
        jsr loop
        
    .endproc

    .proc play_pulse1
        ;for testing just play pulse
        lda #%00000001
        sta $4015
        lda #%11111100
        sta $4000
        lda #%0001111
        sta $4002
        lda #%1111011
        sta $4003
        jsr loop
    .endproc

    .proc play_pulse2
        lda #%00000010
        sta $4015
        lda #%1111100
        sta $4004
        lda #%0001111
        sta $4006
        lda #%1111011
        sta $4007
        jsr loop
    .endproc

    .proc play_tri
        ;for testing just play triangle
        lda #%00000100
        sta $4015
        lda #%11111100
        sta $4008
        lda #%0111111
        sta $400A
        lda #%1111111
        sta $400B
        jsr loop
    .endproc

    .proc play_noise
        ;for testing just play noise
        lda #%00001000
        sta $4015
        lda #%11111100
        sta $400C
        lda #%0001111
        sta $400E
        lda #%1111011
        sta $400F
        jsr loop
    .endproc

    .proc play_dmc
        ;NOT IMPLEMENTED
        lda #%00000000
        sta $4015
        jsr loop
    .endproc
.endscope