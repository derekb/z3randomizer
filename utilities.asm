;================================================================================
; Utility Functions
;================================================================================
!PROGRESSIVE_SHIELD = "$7EF416" ; ss-- ----
;--------------------------------------------------------------------------------
; GetSpriteTile
; in:	A - Loot ID
; out:	A - Sprite GFX ID
;--------------------------------------------------------------------------------
GetSpriteID:
	PHX
	PHB : PHK : PLB
	;--------
	TAX : LDA .gfxSlots, X ; look up item gfx
	PLB : PLX
	CMP.b #$FA : !BGE .specialHandling
RTL
	.specialHandling
	CMP.b #$FA : BNE ++ ; RNG Item (Single)
		JSL.l GetRNGItemSingle : JMP GetSpriteID
	++ CMP.b #$FB : BNE ++ ; RNG Item (Multi)
		JSL.l GetRNGItemMulti : JMP GetSpriteID
	++ CMP.b #$FE : BNE ++ ; Progressive Sword
		LDA $7EF359 : BNE + ; No Sword
			LDA.b #$43 : RTL
		+ : CMP.b #$01 : BNE + ; Fighter Sword
			LDA.b #$44 : RTL
		+ : CMP.b #$02 : BNE + ; Master Sword
			LDA.b #$45 : RTL
		+ ; Everything Else
			LDA.b #$46 : RTL
	++ : CMP.b #$FF : BNE ++ ; Progressive Shield
		LDA !PROGRESSIVE_SHIELD : AND #$C0 : BNE + ; No Shield
			LDA.b #$2D : RTL
		+ : CMP.b #$40 : BNE + ; Fighter Shield
			LDA.b #$20 : RTL
		+ ; Everything Else
			LDA.b #$2E : RTL
	++
RTL

;DATA - Loot Identifier to Sprite ID
{
	.gfxSlots
    db $06, $44, $45, $46, $2D, $20, $2E, $09
    db $09, $0A, $08, $05, $10, $0B, $2C, $1B
    
    db $1A, $1C, $14, $19, $0C, $07, $1D, $2F
    db $07, $15, $12, $0D, $0D, $0E, $11, $17
    
    db $28, $27, $04, $04, $0F, $16, $03, $13
    db $01, $1E, $10, $00, $00, $00, $00, $00

    db $00, $30, $22, $21, $24, $24, $24, $23
    db $23, $23, $29, $2A, $2C, $2B, $03, $03
    
    db $34, $35, $31, $33, $02, $32, $36, $37
	db $2C, $43, $0C, $38, $39, $3A, $3B, $3C
	; db $2C, $06, $0C, $38, $FF, $FF, $FF, $FF
	
	;5x
	db $44 ; Safe Master Sword
	db $3D, $3E, $3F, $40 ; Bomb & Arrow +5/+10
	db $00, $00, $00 ; 3x Programmable Item
	db $41 ; Upgrade-Only Silver Arrows
	db $24 ; 1 Rupoor
	db $47 ; Null Item
	db $48, $48, $48 ; Red, Blue & Green Clocks
	db $FE, $FF ; Progressive Sword & Shield
	
	;6x
	db $04, $0D ; Progressive Armor & Gloves
	db $FA, $FB ; RNG Single & Multi
	db $FF, $FF, $FF, $FF, $FF, $FF ; Unused
	db $49, $4A, $49 ; Goal Item Single, Multi & Alt Multi
	db $FF, $FF, $FF ; Unused
	
	;7x
	db $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21 ; Free Map
	
	;7x
	db $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16 ; Free Compass
	
	;7x
	db $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22, $22 ; Free Big Key
	
	;7x
	db $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F ; Free Small Key
}
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; GetSpritePalette
; in:	A - Loot ID
; out:	A - Palette
;--------------------------------------------------------------------------------
GetSpritePalette:
	PHX
	PHB : PHK : PLB
	;--------
	TAX : LDA .gfxPalettes, X ; look up item gfx
	PLB : PLX
	CMP.b #$FA : !BGE .specialHandling
RTL
	.specialHandling
	CMP.b #$FD : BNE ++ ; Progressive Sword
		LDA $7EF359 : BNE + ; No Sword
			LDA.b #$04 : RTL
		+ : CMP.b #$01 : BNE + ; Fighter Sword
			LDA.b #$04 : RTL
		+ : CMP.b #$02 : BNE + ; Master Sword
			LDA.b #$02 : RTL
		+ ; Everything Else
			LDA.b #$08 : RTL
	++ : CMP.b #$FE : BNE ++ ; Progressive Shield
		LDA $7EF35A : BNE + ; No Shield
			LDA.b #$04 : RTL
		+ : CMP.b #$01 : BNE + ; Fighter Shield
			LDA.b #$02 : RTL
		+ ; Everything Else
			LDA.b #$08 : RTL
	++ : CMP.b #$FF : BNE ++ ; Progressive Armor
		LDA $7EF35B : BNE + ; Green Tunic
			LDA.b #$04 : RTL
		+ ; Everything Else
			LDA.b #$02 : RTL
	++ : CMP.b #$FC : BNE ++ ; Progressive Gloves
		LDA $7EF354 : BNE + ; No Gloves
			LDA.b #$02 : RTL
		+ ; Everything Else
			LDA.b #$08 : RTL
	++ : CMP.b #$FA : BNE ++ ; RNG Item (Single)
		JSL.l GetRNGItemSingle : JMP GetSpritePalette
	++ : CMP.b #$FB : BNE ++ ; RNG Item (Multi)
		JSL.l GetRNGItemMulti : JMP GetSpritePalette
	++
RTL

;DATA - Loot Identifier to Sprite Palette
{
	.gfxPalettes
	db $00, $04, $02, $08, $04, $02, $08, $02
	db $04, $02, $02, $02, $04, $04, $04, $08
	
	db $08, $08, $02, $02, $04, $02, $02, $02
	db $04, $02, $04, $02, $08, $08, $04, $02
	
	db $0A, $02, $04, $02, $04, $04, $00, $04
	db $04, $08, $02, $02, $08, $04, $02, $08
	
	db $04, $04, $08, $08, $08, $04, $02, $08
	db $02, $04, $08, $02, $04, $04, $02, $02
	
	db $08, $08, $02, $04, $04, $08, $08, $08
	db $04, $04, $04, $02, $08, $08, $08, $08
	; db $04, $0A, $04, $02, $FF, $FF, $FF, $FF
	
	db $04 ; Safe Master Sword
	db $08, $08, $08, $08 ; Bomb & Arrow +5/+10
	db $00, $00, $00 ; Programmable Items 1-2
	db $02 ; Upgrade-Only Silver Arrows
	db $06 ; 1 Rupoor
	db $02 ; Null Item
	db $02, $04, $08 ; Red, Blue & Green Clocks
	db $FD, $FE, $FF, $FC ; Progressive Sword, Shield, Armor & Gloves
	db $FA, $FB ; RNG Single & Multi
	db $00, $00, $00, $00, $00, $00 ; Unused
	db $08, $08, $08 ; Goal Item Single, Multi & Alt Multi
	db $00, $00, $00 ; Unused
	db $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08 ; Free Map
	db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; Free Compass
	db $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08 ; Free Big Key
	db $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08 ; Free Small Key
}
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; IsNarrowSprite
; in:	A - Loot ID
; out:	Carry - 0 = Full, 1 = Narrow
;--------------------------------------------------------------------------------
IsNarrowSprite:
	PHA : PHX
	PHB : PHK : PLB

	;--------
	CMP.b #$5F : BNE ++ ; Special Handler for Progressive Shield
		LDA $7EF35A : BNE + : SEC : BRA .done : +; No Shield
		BRA .false ; Everything Else
	++ CMP.b #$62 : BNE ++ ; RNG Item (Single)
		JSL.l GetRNGItemSingle : BRA .continue
	++ CMP.b #$63 : BNE ++ ; RNG Item (Multi)
		JSL.l GetRNGItemMulti
	++
	
	.continue
	;--------
	
	LDX.b #$00 ; set index counter to 0
	;----
	-
	CPX.b #$24 : !BGE .false ; finish if we've done the whole list
	CMP .smallSprites, X : BNE + ; skip to next if we don't match
	;--
	SEC ; set true state
	BRA .done ; we're done
	;--
	+
	INX ; increment index
	BRA - ; go back to beginning of loop
	;----
	.false
	CLC
	.done
	PLB : PLX : PLA
RTL

;DATA - Half-Size Sprite Markers
{
	.smallSprites
	db $04, $07, $08, $09, $0A, $0B, $0C, $13
	db $15, $18, $24, $2A, $31, $34, $35, $36
	db $42, $43, $45, $59, $A0, $A1, $A2, $A3
	db $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB
	db $AC, $AD, $AE, $AF, $FF, $FF, $FF, $FF
}
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; PrepDynamicTile
; in:	A - Loot ID
;-------------------------------------------------------------------------------- 20/8477
PrepDynamicTile:
	PHA : PHX : PHY
	JSR.w LoadDynamicTileOAMTable
	JSL.l GetSpriteID ; convert loot id to sprite id
	JSL.l GetAnimatedSpriteTile_variable
	PLY : PLX : PLA
RTL
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; LoadDynamicTileOAMTable
; in:	A - Loot ID
;-------------------------------------------------------------------------------- 20/847B
!SPRITE_OAM = "$7EC025"
;--------------------------------------------------------------------------------
LoadDynamicTileOAMTable:
	PHA : PHP
	
	PHA
		REP #$20 ; set 16-bit accumulator
		LDA.w #$0000 : STA.l !SPRITE_OAM
		               STA.l !SPRITE_OAM+2
		LDA.w #$0200 : STA.l !SPRITE_OAM+6
		SEP #$20 ; set 8-bit accumulator
		LDA.b #$24 : STA.l !SPRITE_OAM+4
	
	LDA $01,s
	
		JSL.l GetSpritePalette
		STA !SPRITE_OAM+5 : STA !SPRITE_OAM+13
	PLA
	JSL.l IsNarrowSprite : BCS .narrow
	
	BRA .done
	
	.narrow
	REP #$20 ; set 16-bit accumulator
	LDA.w #$0000 : STA.l !SPRITE_OAM+7
	               STA.l !SPRITE_OAM+14
	LDA.w #$0800 : STA.l !SPRITE_OAM+9
	LDA.w #$3400 : STA.l !SPRITE_OAM+11
	
	.done
	PLP : PLA
RTS
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; DrawDynamicTile
; in:	A - Loot ID
; out:  A - OAM Slots Taken
;--------------------------------------------------------------------------------
; This wastes two OAM slots if you don't want a shadow - fix later
;-------------------------------------------------------------------------------- 2084B8
!SPRITE_OAM = "$7EC025"
!SKIP_EOR = "$7F5008"
;--------------------------------------------------------------------------------
DrawDynamicTile:
	JSL.l IsNarrowSprite : BCS .narrow
	
	.full
	LDA.b #$01 : STA $06
	LDA #$0C : JSL.l OAM_AllocateFromRegionC
	LDA #$02 : PHA
	BRA .draw
	
	.narrow
	LDA.b #$02 : STA $06
	LDA #$10 : JSL.l OAM_AllocateFromRegionC
	LDA #$03 : PHA
	
	.draw
	LDA.b #!SPRITE_OAM>>0 : STA $08
	LDA.b #!SPRITE_OAM>>8 : STA $09
	STZ $07
	LDA #$7E : PHB : PHA : PLB
		LDA.b #$01 : STA.l !SKIP_EOR
		JSL Sprite_DrawMultiple_quantity_preset
	PLB
	
	LDA $90 : !ADD.b #$08 : STA $90 ; leave the pointer in the right spot to draw the shadow, if desired
	LDA $92 : INC #2 : STA $92
	PLA
RTL
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; Sprite_IsOnscreen
; in:	X - Sprite Slot
; out:	Carry - 1 = On Screen, 0 = Off Screen
;--------------------------------------------------------------------------------
Sprite_IsOnscreen:
    JSR _Sprite_IsOnscreen_DoWork
	BCS +
		REP #$20
		LDA $E2 : PHA : !SUB.w #$0F : STA $E2
		LDA $E8 : PHA : !SUB.w #$0F : STA $E8
		SEP #$20
			JSR _Sprite_IsOnscreen_DoWork
		REP #$20
		PLA : STA $E8
		PLA : STA $E2
		SEP #$20
	+
RTL

_Sprite_IsOnscreen_DoWork:
    LDA $0D10, X : CMP $E2
    LDA $0D30, X : SBC $E3 : BNE .offscreen

    LDA $0D00, X : CMP $E8
    LDA $0D20, X : SBC $E9 : BNE .offscreen
	SEC
RTS
	.offscreen
	CLC
RTS
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; Sprite_GetScreenRelativeCoords:
; out:	$00.w Sprite Y
; out:	$02.w Sprite X
; out:	$06.b Sprite Y Relative
; out:	$07.b Sprite X Relative
;--------------------------------------------------------------------------------
; Copied from bank $06
;--------------------------------------------------------------------------------
!spr_y_lo = $00
!spr_y_hi = $01

!spr_x_lo = $02
!spr_x_hi = $03

!spr_y_screen_rel = $06
!spr_x_screen_rel = $07
;--------------------------------------------------------------------------------
Sprite_GetScreenRelativeCoords:
	STY $0B

	STA $08

	LDA $0D00, X : STA $00
	!SUB $E8     : STA $06
	LDA $0D20, X : STA $01

	LDA $0D10, X : STA $02
	!SUB $E2     : STA $07
	LDA $0D30, X : STA $03
RTL
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; SkipDrawEOR - Shims in Bank05.asm : 2499
;--------------------------------------------------------------------------------
!SKIP_EOR = "$7F5008"
;--------------------------------------------------------------------------------
SkipDrawEOR:
	LDA.l !SKIP_EOR : BEQ .normal
	LDA.w #$0000 : STA.l !SKIP_EOR
	LDA $04 : AND.w #$F0FF : STA $04
	.normal
	LDA ($08), Y : EOR $04 ; thing we wrote over
RTL
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; HexToDec
; in:	A(w) - Word to Convert
; out:	$7F5003 - $7F5007 (high - low)
;--------------------------------------------------------------------------------
HexToDec:
	PHA
	PHA
		LDA.w #$9090
		STA $7F5003 : STA $7F5005 : STA $7F5006 ; clear digit storage
	PLA
	-
	CMP.w #10000 : !BLT +
	PHA : SEP #$20 : LDA $7F5003 : INC : STA $7F5003 : REP #$20 : PLA
	!SUB.w #10000 : BRA -
	+ -
	CMP.w #1000 : !BLT +
	PHA : SEP #$20 : LDA $7F5004 : INC : STA $7F5004 : REP #$20 : PLA
	!SUB.w #1000 : BRA -
	+ -
	CMP.w #100 : !BLT +
	PHA : SEP #$20 : LDA $7F5005 : INC : STA $7F5005 : REP #$20 : PLA
	!SUB.w #100 : BRA -
	+ -
	CMP.w #10 : !BLT +
	PHA : SEP #$20 : LDA $7F5006 : INC : STA $7F5006 : REP #$20 : PLA
	!SUB.w #10 : BRA -
	+ -
	CMP.w #1 : !BLT +
	PHA : SEP #$20 : LDA $7F5007 : INC : STA $7F5007 : REP #$20 : PLA
	!SUB.w #1 : BRA -
	+ 
	PLA
RTL
;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
; NameHash
; out:
; $00 - $07 - 64-bit Seed Hash
;--------------------------------------------------------------------------------
NameHash:
	PHP
	SEP #$30 ; set 8-bit accumulator & index registers
	LDY #$00; ; for (j = 0; j < 8; ++j) {
	-
		CPY #$08 : !BGE +
			LDA $00FFC0 : PHY : !ADD 1,s : STA 1,s : PLX : LDA.l NameHashTable, X ; h = T[(x[0] + j) % 256];
			PHY
				LDY #$01 ; for (i = 1; i < len; ++i) {
				--
					CPY #21 : !BGE ++ ; 21 decimal
						TYX : EOR $00FFC0, X : TAX : LDA.l NameHashTable, X ; h = T[h ^ x[i]];
					INY
					BRA --
				++ ; }
			PLY : TYX
			STA $00, X
		INY
		BRA -
	+ ; }
	PLP
RTL
;--------------------------------------------------------------------------------
;================================================================================