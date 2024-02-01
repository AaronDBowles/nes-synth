.export ReadController
.segment "CODE"

.proc ReadController

    lda #1
    sta $20

    ;send the latch pulse
    sta $4016
    lda #0
    sta $4016

read_button:
    lda $4016
    lsr a
    rol $20
    bcc read_button

    rts
.endproc