.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r2, lr}
	ldr r0, .PlayTime
	ldr r0, [r0]
	add r0, r0, #0xE @hours
	ldr r2, =(0x20370B8)
	ldrh r1, [r0]
	strh r1, [r2]
	add r0, r0, #0x2 @mins
	ldr r2, =(0x20370BA)
	ldrb r1, [r0]
	strb r1, [r2]
	add r0, r0, #0x1 @seconds
	ldr r2, =(0x20370BC)
	ldrb r1, [r0]
	strb r1, [r2]
	pop {r0-r2, pc}


.align 2
.PlayTime:
	.word 0x300500C
