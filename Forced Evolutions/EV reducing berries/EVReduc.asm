.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r3, lr}
	ldr r0, = (0x20370C0)
	ldrb r1, [r0]
	ldr r0, =(0x2024284)
	mov r2, #0x64
	mul r1, r1, r2
	add r0, r0, r1
	mov r4, r0
	ldr r2, =(0x20370D0)
	ldrb r1, [r2]
	ldr r3, =(0x803FBE8 +1)
	bl linker
	ldr r2, =(0x20370D2)
	ldrb r3, [r2]
	sub r3, r3, r0
	cmp r3, #0x0
	bls setZero
	b end

setZero:
	mov r3, #0x0

end:
	mov r0, r4
	strh r3, [r2]
	ldr r2, =(0x20370D0)
	ldrb r1, [r2]
	ldr r3, =(0x804037C +1)
	bl linker
	pop {r0-r3, pc}

linker:
	bx r3

.align 2