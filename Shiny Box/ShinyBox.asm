.text
.align 2
.thumb
.thumb_func

main:
	@08044472 ins 01 4D 28 47 00 00 01 00 84 08
	mov r4, r0
	add r0, r0, #0x1E
	ldrb r0, [r0]
	cmp r0, #0x0
	bne setPal
	mov r0, r4
	mov r1, #0x1
	mov r2, #0x0
	ldr r3, =(0x803FBE8 +1)
	bl linker
	ldr r5, =(0x804447C +1)
	bx r5

setPal:
	mov r0, #0x1
	pop {r4, r5}
	pop {r1}
	bx r1

linker:
	bx r3
	
	
.align 2
