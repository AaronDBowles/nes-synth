.scope FreeSynth

.include "util/read_controller.s"

PLAYER1_CHAN = $22
PLAYER1_SOUND = $23

    .proc loop
    free_synth:
        jsr Joypad::update
        
    parse_inputs:
        ;determine if channel is being incremented with B press
        lda Joypad::pressed
        and #BUTTON_B
        bne change_channel
        ;if A, play sound
        ; lda #%10000000
        ; and CONTROLLER1_INPUT
        ; cmp #%10000000
        ; beq play_sound

        rts
    

    .endproc

    .proc play_sound
        ;determine channel
        lda #0
        cmp PLAYER1_CHAN
        beq play_pulse1
        lda #1
        cmp PLAYER1_CHAN
        beq play_pulse2
        lda #2
        cmp PLAYER1_CHAN
        beq play_tri
        lda #3
        cmp PLAYER1_CHAN
        beq play_noise
        lda #4
        cmp PLAYER1_CHAN
        beq play_dmc

        rts
    .endproc

    .proc change_channel
        ;increment PLAYER1_CHAN to increase channel selection
        lda #4
        cmp PLAYER1_CHAN
        beq reset_channel
        ldx PLAYER1_CHAN
        inx
        stx PLAYER1_CHAN
        rts
    reset_channel:
        lda #0
        sta PLAYER1_CHAN
        rts
        
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
        rts
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
        rts
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
        rts
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
        rts
    .endproc

    .proc play_dmc
        ;NOT IMPLEMENTED
        lda #%00000000
        sta $4015
        rts
    .endproc
.endscope