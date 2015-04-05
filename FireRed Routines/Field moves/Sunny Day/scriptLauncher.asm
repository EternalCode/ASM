.text
.align 2
.thumb
.thumb_func

main:
	push {r4, lr}
	ldr r0, =(0x203B0A0)@selected mon
	ldrb r0, [r0, #0x9]
	ldr r1, =(0x20386E0)
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [r1]
	ldr r0, =(0x8740350)
	ldr r4, =(0x8069AE4 +1)
	bl linker
	pop {r4, pc}
	
linker:
	bx r4
	
.align 2