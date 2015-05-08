.text
.align 2
.thumb
.thumb_func
 
 @0x5D66E: 00 00 00 49 08 47 C1 FF 81 08
 
main:
	push {r0-r3}
	ldr r0, =(0x20370BC)
	ldrb r1, [r0]
	add r1, r1, #0x1
	strb r1, [r0]
	pop {r0-r3}
	sub SP, SP, #0x10
	mov r4, r0
	ldr r0, =(0x2037078)
	ldrb r1, [r0, #0x4]
	lsl r0, r1, #0x4
	add r0, r0, r1
	lsl r0, r0, #0x2
	ldr r1, =(0x805D67C +1)
	bx r1
	
linker:
	bx r2
 
.align 2