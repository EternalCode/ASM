.text
.align 2
.thumb
.thumb_func

main:
	push {r2-r5, lr}
	ldr r0, .checkPokemon @check trainer's pokemon
	bl checkPokemon
	cmp r1, #0x0 @check if last pokemon
	bne skip
	mov r1, #0x39
	mov r3, r0 @save r0
	ldr r5, VAR2
	cmp r5, #0x0 @if last Pokemon and we haven't displayed text before display
	beq text
	ldr r2, = (0x803FBE8 + 1) @check if last Pokemon less than half
	bl linkerTwo
	mov r4, r0 @r4 = currentHP
	mov r0, r3
	mov r1, #3A
	bl linkerTwo
	mov r1, #0x2
	mul r4, r4, r1
	cmp r0, r4
	ble skip @if more than half, no text display

text:
	@slide trainer (todo)
	@
	@below is the text, for some reason it appears to come on screen delayed :/
	@
	mov r0, #0x1 @set a flag (cover cases player spamming growl, doing no dmg..ect)
	strb r0, [r5]
	ldr r1, .VAR @get pointer number var from table. Var is index
	ldrb r1, [r1]
	ldr r0, .TABLE
	lsl r1, #0x2
	add r0, r0, r1
	ldr r0, [r0] @r0 contains pointer (reverse hex)
	mov r1, #0x0  @check that it's a valid pointer, not free space
	ldrb r0, [r1]
	cmp r1, #0xFF
	beq skip
	ldr r1, =(0x80D77F4 +1) @battle text functions
	bl linkerOne
	mov r1, #0x18
	ldr r2, =(0x80D87BC +1)
	bl linkerTwo
	@unslide trainer (todo)

skip:
	ldr r1, = 0x3004F90
	ldrb r0, [r1, #0x13]
	cmp r0, #0xFE
	bhi replacer
	add r0, #0x1
	strb r0, [r1, #0x13]

replacer:
	ldr r2, = (0x8013CBC + 1)

linkerTwo:
	bx r2

linkerOne:
	bx r1



.align 2
.VAR:
	.word 0x020270B4 + (0x8001 * 2)

.VAR2:
	.word 0x020270B4 + (0x8002 * 2)

.TABLE:
	.word (0x871A600)
