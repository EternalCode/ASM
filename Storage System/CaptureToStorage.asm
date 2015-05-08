.text
.align 2
.thumb
.thumb_func

@hook at 0802D81A
main:
	ldr r7, .VAR
	ldrb r7, [r7]
	cmp r7, #0x1
	bne noCrash
	ldr r4, =0x300500C @data
	ldr r2, [r4]
	mov r1, #0x7
	ldr r0, =(0x202402C) @src
	mov r6, r0
	ldr r3, =(0x804037C +1) @set non-BadEggness
	bl linker
	ldr r2, [r4]
	add r2, r2, #0x8
	mov r0, r6
	mov r1, #0x31
	ldr r3, =(0x804037C +1)
	bl linker
	ldr r2, [r4]
	add r2, r2, #0xA
	mov r0, r6
	mov r1, #0x1
	ldr r3, =(0x804037C +1)
	bl linker

toStorage:
	ldr r1, =(0x203C000)
	ldrb r0, [r0]
	mov r2, #0x50
	mul r0, r0, r2
	add r0, r0, r1
	add r0, r0, #0x1 @destination
	ldr r0, =(0x202402C) @src
	mov r2, #0x50 @size
	ldr r3, =(0x8040B08 +1) @func
	bl linker
	ldr r0, =(0x202402C)
	mov r1, #0xB
	ldr r3, =(0x803FBE8 +1) @get species
	bl linker
	mov r6, r0
toDex:
	ldr r3, =(0x8043298 +1) @add to dex
	bl linker
	mov r0, r6
	mov r1, #0x2
	ldr r3, =(0x8088E74 +1)
	bl linker
	mov r0, r6
	mov r1, #0x3
	ldr r3, =(0x8088E74 +1)
	bl linker
	ldr r3, =(0x802D920 +1)
	bx r3

nickname: @commented out because untested, and likely to crash.
	@bl PartySwap
	@ldr r0, =(0x80370C0)
	@ldr r1, =(0x2024029)
	@ldrb r1, [r1]
	@strb r1, [r0]
	@ldr r3, = (0x80CC088 +1)
	@bl linker
	@@need someway to wait until this is executed
	@@before executing the next line
	@bl PartySwap
	@ldr r3, =(0x802D920 +1)
	@bx r3
	@pop {r3-r6} @return to OW
	@pop {r0}
	@bx r0

noCrash:
	mov r7, #0x64
	mul r0, r0, r7
	ldr r1, =(0x202402C)
	mov r8, r1
	add r0, r8
	ldr r3, =(0x802D824 +1)


linker:
	bx r3
	
	
.align 2

.VAR:
	.word 0x20370D8 @var 0x8011