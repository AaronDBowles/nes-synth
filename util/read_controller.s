; Controller port addresses
JOYPAD1 = $4016
JOYPAD2 = $4017

; Button mask bits
BUTTON_A      = 1 << 7
BUTTON_B      = 1 << 6
BUTTON_SELECT = 1 << 5
BUTTON_START  = 1 << 4
BUTTON_UP     = 1 << 3
BUTTON_DOWN   = 1 << 2
BUTTON_LEFT   = 1 << 1
BUTTON_RIGHT  = 1 << 0

; Joypad State controller
.scope Joypad
  down    = $21     ; Button "down" bitmaks, 1 means down & 0 means up.
  pressed = $22     ; Button "pressed" bitmask, 1 means pressed this frame.
  downTiles = $600  ; Holds tile values for the controlller state in the BG

 .proc update
    jsr read_joypad1
    .ifndef VIDEO_DEMO_MODE
      jsr compute_button_tiles
    .endif
    rts
  .endproc

  .proc read_joypad1
    lda down
    tay
    lda #1
    sta JOYPAD1
    sta down
    lsr
    sta JOYPAD1
  @loop:
    lda JOYPAD1
    lsr
    rol down
    bcc @loop
    tya
    eor down
    and down
    sta pressed
    rts
  .endproc

  .proc compute_button_tiles
    ldx #7
    ldy down
  @loop:
    tya
    lsr
    tay
    lda #$29
    adc #0
    sta downTiles, x
    dex
    bpl @loop
    rts
  .endproc
  .endscope
  