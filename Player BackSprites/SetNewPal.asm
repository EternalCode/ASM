.text
.align 2
.thumb
.thumb_func

main:
	mov r0, #0x94
	lsl r0, #0x2
	push {r1-r6}
	ldr r2, =(0x806E6D0 +1)
	bl linker
	pop {r1-r6}
	cmp r0, #0x0
	beq Normal
	ldr r2, .Var
	ldrb r2, [r2]
	mov r4, r2

Normal:
	mov r0, r4
	lsl r0, r0, #0x10
end:
	lsl r1, r1, #0x18
	ldr r2, =(0x8239FD4)
	lsr r0, r0, #0xD
	add r0, r0, r2
	ldr r2, =(0x803475C +1)
	
linker:
	bx r2
	

.align 2

.Var:
	.word 0x20370B8 @0x8000
