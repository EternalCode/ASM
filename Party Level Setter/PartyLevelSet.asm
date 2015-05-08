.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r7, lr}
	mov r7, #0x0

loop:
	ldr r6, =(0x2024029)
	ldrb r6, [r6]
	cmp r7, r6
	beq end
	ldr r0, =(0x2024284)
	mov r1, #0x64
	mul r1, r1, r7
	add r0, r0, r1@addr
	mov r4, r0

set_level:
	mov r1, #0xB
	ldr r3, = (0x803FBE8 +1) @get species
	bl linker
	mov r2, r0
	ldr r6, =(0x8253AE4)
	ldr r1, =(0x8254784)
	lsl r0, r2, #0x3
	sub r0, r0, r2
	lsl r0, r0, #0x2
	add r1, r1, r0
	ldrb r0, [r1, #0x13]
	mov r5, #0xCA
	lsl r5, r5, #0x1
	mul r0, r0, r5
	add r0, r0, r6
	ldr r1, .VAR
	ldrb r1, [r1]
	mov r3, #0x4
	mul r1, r1, r3
	add r1, r1, r0
	ldr r1, [r1]
	ldr r2, = (0x20370D0)
	str r1, [r2]
	mov r0, r4
	mov r1, #0x19
	ldr r3, =(0x804037C +1)
	bl linker
	mov r0, r4
	ldr r3, =(0x803E47C +1)
	bl linker
		
next:
	add r7, r7, #0x1
	b loop	

end:
	pop {r0-r7, pc}
	
linker:
	bx r3
	

.align 2

.VAR:
	.word 0x020270B8 + (0x8000 *2)