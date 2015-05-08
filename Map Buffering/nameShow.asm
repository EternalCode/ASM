.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r7, lr}
	mov r0, #0x81 @var = (81 *80) + 1 = 0x4081
	lsl r0, #0x7
	add r0, r0, #0x1 @map bank variable
	ldr r4, =(0x806E568 +1)
	bl linker
	mov r5, r0
	mov r0, #0x81 @var = (81 *80) + 2 = 0x4082
	lsl r0, #0x7
	add r0, r0, #0x2 @map number variable
	ldr r4, =(0x806E568 +1)
	bl linker
	mov r6, r0
	@r5 = map bank, r6 = map number
	ldr r7, .conversionTable
	
loop:
	ldrb r0, [r7]
	cmp r0, #0xFF
	beq notFound @end of table
	cmp r0, r5
	bne next @map bank doesn't match
	add r4, r7, #0x1
	ldrb r0, [r4]
	cmp r0, r6
	bne next @map number doesn't match
	add r4, r4, #0x1
	ldrb r1, [r4] @match found
	b display
next:
	add r7, r7, #0x3
	b loop
	
notFound:
	mov r1, #0xFF @write string terminator, to not glitch game
	
display:
	ldr r0, =(0x2021D18) @location to store string	
	@ldr r4, =(0x2036DFC) @map header
	@ldrb r1, [r4, #0x14] @map name number
	mov r2, #0x0
	ldr r4, =(0x80C4D78 +1)
	bl linker
	
end:
	pop {r0-r7, pc}

linker:
	bx r4

.align 2

.conversionTable:
	.word 0x8780000