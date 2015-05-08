.text
.align 2
.thumb
.thumb_func

main:	
	push {r0-r1, lr}
	ldr r0, =(0x2023E8A)
	ldrb r1, [r0]
	cmp r1, #0x1
	bhi setZero
	b end

setZero:
	cmp r1, #0x5
	beq end
	mov r1, #0x0
	strb r1, [r0]

end:
	pop {r0-r1, pc}