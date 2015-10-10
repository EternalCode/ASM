.text
.align 2
.thumb
.thumb_func

@timer task

main:
	push {lr}
	ldr r2, =(0x203BFF9)
	ldrb r1, [r2]
	cmp r1, #0x20
	beq delTask
	add r1, r1, #0x1
	strb r1, [r2]
	pop {pc}
	
delTask:
	mov r1, #0x0
	strb r1, [r2]
	ldr r3, =(0x8077508 +1)
	bl linker
	pop {pc} 

linker:
	bx r3


.align 2
