.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r4, lr}
	ldr r0, =(0x202370B8) @max
	ldr r1, =(0x202370BA) @min
	ldrb r1, [r1]
	mov r2, r0
	sub r2, r2, r1 @max -min
	bl generateRand
	mov r4, r3
	add r4, r4, r1 @rand between min and max
	ldr r3, =(0x202370C8)
	ldrb r3, [r3] @times watered
	sub r3, r3, #0x1
	mul r2, r2, r3 @apply DPPT berry yield formula
	add r2, r2, r4
	lsr r2, r2, #0x2
	add r2, r2, r1
	ldr r1, =(0x202370D0) @store result in 0x800D
	strb r2, [r0]
	pop {r0-r4, pc}

generateRand:
	push {r0-r2}
	ldr r3, =(0x8044EC8 +1)
	bl linker
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r2}
	mov r1, r2
	push {r2}
	ldr r3, =(0x81E4684 +1)
	bl linker
	ldrb r3,  [r0]
	pop {r0-r2}
	bx lr

linker:
	bx r3
	
	
.align 2

