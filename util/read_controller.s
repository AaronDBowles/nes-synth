
.scope ReadController

.proc ReadController
    ;load previously captured controller input into $21 to for change detection purposes if we need to compare
    lda $20
    sta $21
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

    lda $20
    sta $21

    rts
.endproc
.endscope