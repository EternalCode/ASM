.text
.align 2
.thumb
.thumb_func

main:
	@push {lr}
	@check trainer on last Pokemon
	@check trainer last Pokemon Half HP
	@check trainer first time damaged (turn counter is 1 and pokemon
	@slide trainer
	ldr r1, .VAR @get pointer number var from table. Var is index
	ldrb r1, [r1]
	ldr r0, .TABLE
	lsl r1, #0x2
	add r0, r0, r1
	ldr r0, [r0] @r0 contains pointer (reverse hex)
	ldr r1, =(0x80D77F4 +1) @battle text functions
	bl linkerOne
	@mov r1, #0x18
	@ldr r2, =(0x80D87BC +1)
	@bl linkerTwo
	@unslide trainer
	ldr r1, = 0x3004F90
	ldrb r0, [r1, #0x13]
	cmp r0, #0xFE
	bhi replacer
	add r0, #0x1
	strb r0, [r1, #0x13]
	ldr r2, = (0x8013CBC + 1)

linkerTwo:
	bx r2

linkerOne:
	bx r1

replacer:
	ldr r2, = (0x8013CBC +1)
	bx r2



.align 2
.VAR:
	.word 0x020270B4 + (0x8001 * 2)

.TABLE:
	.word (0x871A600)
