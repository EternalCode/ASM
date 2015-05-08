.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r1, lr}
	ldr r0, = (0x0203C000)
	ldr r1, .VAR
	ldrb r1, [r1]
	add r0, r0, r1
	ldr r1, .VAR
	ldr r0, [r0]
	strb r0, [r1]
	pop {r0-r1, pc}

.align 2
.VAR:
	.word 0x020270B4 + (0x8000 * 2)


