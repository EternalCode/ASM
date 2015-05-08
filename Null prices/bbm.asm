.text
.align 2
.thumb
.thumb_func

@0809B426 bx r1 offset
@text display modifier

main:
	cmp r0, #0x0
	beq nullPrice
	
nullPrice:
	mov r0, r4
	mov r1, #0xAE
	strb r1, [r0]
	add r0, r0, #0x1
	strb r1, [r0]
	mov r1, #0xFF
	add r0, r0, #0x1
	strb r1, [r0]
	ldr r0, =(0x809B436 +1)
	bx r0
	
	
.align 2