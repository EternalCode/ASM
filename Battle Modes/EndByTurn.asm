.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r1,lr}
	ldr r0, =(0x20370CC)
	ldrb r0, [r0]
	ldr r1, =(0x3994FA3)
	ldrb r1, [r1]
	cmp r1, r0
	bne end
	ldr r0, =(0x2023E8A)
	mov r1, #0x5
	strb r1, [r0]	
end:
	pop {r0-r1, pc}
	
	
.align 2
