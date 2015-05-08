.text
.align 2
.thumb
.thumb_func

main:
	mov r0, #0x9C
	lsl r0, #0x2
	push {r1-r7}
    ldr r2, =(0x806E6D0 +1)
	bl linker
	pop {r1-r7}
	cmp r0, #0x0
	beq old
nick:
	ldr r0, =(0x202402C)
	sub r0, r7, r0
	mov r1, #0x64
	ldr r2, =(0x81E4018 +1) @slot number
	bl linker
	mov r3, r0
	ldr r1, = (0x20370B8) @table entry position
	ldrb r1, [r1]
	mov r2, #0xB
	mul r1, r1, r2
	ldr r0, .TABLE
	add r0, r0, r1 @table start position
	mul r3, r3, r2
	add r0, r0, r3 @name to give
	mov r1, r7
	add r1, r1, #0x8 @nickname location
	mov r4, #0x0
nameLoop:
	cmp r4, #0xB
	beq end
	ldrb r3, [r0]
	strb r3, [r1]
	add r1, r1, #0x1
	add r0, r0, #0x1
	add r4, r4, #0x1
	b nameLoop

end:
	ldr r0, =(0x8040ADA +1)
	bx r0
	

old:
	mov r2, #0x0
	mov r3, r7
	add r3, #0x8
oldLoop:
	add r0, r3, r2
	add r1, r4, r2
	ldrb r1, [r1]
	strb r1, [r0]
	add r2, r2, #0x1
	cmp r2, #0x9
	ble oldLoop
	ldr r0, =(0x8040ADA +1)
	bx r0
	

linker:
	bx r2

.align 2

.TABLE:
	.word 0x8760000
