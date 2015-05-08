.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r3, lr}
	ldr r1, =(0x300500C)
	ldrh r2, [r1, #0xE]
	mov r3, #0x3C
	mul r2, r2, r3
	ldrb r3, [r1, #0x10]
	add r2, r2, r3
	ldr r3, =(0x20370C4)
	strh r2, [r3]
	pop {r0-r3, pc}

.align 2

