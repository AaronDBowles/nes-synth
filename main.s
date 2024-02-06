.scope Main

.include "free_synth.s"


.proc Main
    
    ;eventually add mode selection here
    jsr FreeSynth::loop
    rts

.endproc
.endscope