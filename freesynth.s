.export Main
.segment "CODE"

.proc Main

forever:
;poll_controller
;play_sound
    bne forever

poll_controller:
;get inputs
;determine channel
;
    lda $01

.endproc