.text
.align 2
.thumb
.thumb_func

main: 
	@get type given slot
	push {r0-r2, lr}
	ldr r1, =(0x20370B8) @var 0x8000 -slot
	ldrb r1, [r1]
	mov r0, #0x64
	mul r1, r1, r0 @slot to check
	ldr r0, =(0x2024284)	
	add r0, r0, r1
	mov r1, #0xB
	ldr r2, =(0x803FBE8 +1)
	bl linker
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r1, r0, #0x3
	sub r1, r1, r0
	lsl r1, r1, #0x2
	ldr r2, =(0x8254784)
	add r1, r1, r2
	ldrb r0, [r1, #0x6]
	ldr r1, =(0x20370B8)
	strb r0, [r1]
	pop {r0-r2, pc}

linker:
	bx r2	
	

.align 2
