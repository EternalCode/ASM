.text
.align 2
.thumb
.thumb_func

@0x6D5F6: 01 4A 10 47 00 00 C1 60 73 08

main:
	push {r0-r1}
	ldr r0, =(0x20370BC)
	mov r1, #0x0
	strb r1,[r0]
	pop {r0-r1}

end:
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	cmp r0, #0x1
	beq linker
	mov r0, r5
	ldr r1, =(0x806D600 +1)
	bx r1

linker:
	ldr r0, =(0x806D650 +1)
	bx r0
	
	
.align 2