.text
.align 2
.thumb
.thumb_func	


main:
	push (r0-r3, lr}
	ldr r0, .random
	ldr r1, =(0x20370B8) @generate first half of ID
	mov r2, #0xFF
	lsl r2, r2, #0x8
	add r2, r2, #0xFF
	strh r2, [r1]
	bl linker
	mov r3, r0
	ldr r1, =(0x20370B8) @generate second half of ID
	mov r2, #0xFF
	lsl r2, r2, #0x8
	add r2, r2, #0xFF
	strh r2, [r1]
	push {r3}
	bl linker
	pop {r3}
	lsl r0, r0, #0x10
	lsr r3, r3, #0x10
	orr r3, r3, r0
	ldr r0, =(0x300500C)
	ldr r0, [r0]
	add r0, r0, #0xA
	ldr r1, =(0x20370BA)
	ldrb r1, [r1]
	add r0, r0, r1
	strh r3, [r0] @set ID
	cmp r1, #0x1
	bne setRam
	pop {r0-r3, pc}
	
setRam:
	ldr r1, =(0x2020000) @set RAM Pointer to TID
	strh r3, [r1]
	pop {r0-r3, pc}
	
	
linker:
	bx r0
	
	
.align 2

.random:
	.word 0xrandom