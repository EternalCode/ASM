.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r7, lr}
	ldr r6, =(0x2024029)
	ldrb r6, [r6]
	mov r5, #0x0

PokeLoop:
	cmp r6, r5
	beq end
	mov r0, #0x64
	mul r0, r0, r5
	mov r1, r0
	ldr r0, =(0x2024284)
	add r0, r0, r1
	mov r7, r0 @save pointer in r7
	mov r1, #0x19
	ldr r3, =(0x803FBE8 +1)
	bl linker
	ldr r2, .EXP
	ldrb r4, [r2] @add 
	add r2, r2, #0x1
	ldrh r1, [r2]
	mov r3, #0xFF
	mul r3, r3, r1
	add r3, r3, r4
	add r3, r3, r0
	mov r0, r7
	ldr r2, =(0x20370B8)
	str r3, [r2] @put data at pointer
	mov r1, #0x19
	ldr r3, =(0x804037C +1)
	bl linker
	mov r0, r7
	ldr r3, =(0x803E47C +1)
	bl linker
	add r5, r5, #0x1
	b PokeLoop
	
end:
	ldr r0, .EXP
	mov r1, #0x0
	strb r1, [r0]
	add r0, r0, #0x1
	strb r1, [r0]
	add r0, r0, #0x1
	strb r1, [r0]
	pop {r0-r7, pc}
	
linker:
	bx r3
	
.align 2

.EXP:
	.word 0x203BFFD