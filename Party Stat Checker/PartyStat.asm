.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r6, lr}
	ldr r6, =(0x2024029)
	ldrb r6, [r6]
	mov r5, #0x0

PokeLoop:
	cmp r6, r5
	beq none
	mov r0, #0x64
	mul r0, r0, r5
	mov r1, r0
	ldr r0, =(0x2024284)
	add r0, r0, r1
	ldr r1, .INDEX
	ldrb r1, [r1]
	ldr r2, =(0x803FBE8 +1)
	bl linker
	ldr r3, .ARG
	ldrb r3, [r3]
	cmp r0, r3
	bge PokeMatch

next:
	add r5, r5, #0x1
	b PokeLoop
	

PokeMatch:
	ldr r3, .ARG
	strb r5, [r3]
	pop {r0-r6, pc}

none:
	ldr r3, .ARG
	mov r5, #0x6
	strb r5, [r3]
	pop {r0-r6, pc}
	
linker:
	bx r2
	
.align 2


.ARG:
	.word 0x020270B8 + (0x8000 *2) 

.INDEX:
	.word 0x020270B8 + (0x8001 *2)