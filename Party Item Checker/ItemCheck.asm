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
	mov r1, #0xC
	ldr r2, =(0x803FBE8 +1)
	bl linker
	ldr r3, .ITEM
	ldrb r3, [r3]
	cmp r0, r3
	beq PokeMatch

next:
	add r5, r5, #0x1
	b PokeLoop
	

PokeMatch:
	ldr r4, .MON
	ldrh r4, [r4]
	cmp r4, #0x0
	beq found
	ldr r2, =(0x803FBE8 +1)
	mov r0, #0x64
	mul r0, r0, r5
	mov r1, r0
	ldr r0, =(0x2024284)
	add r0, r0, r1
	mov r1, #0xB
	bl linker
	ldr r4, .MON
	ldrh r4, [r4]
	cmp r0, r4
	bne next

found:
	ldr r2, .MON
	strb r5, [r2]
	pop {r0-r6, pc}
	

none:
	ldr r0, .MON
	mov r1, #0x6
	strb r1, [r0]
	pop {r0-r6, pc}	
	
linker:
	bx r2
	
	
.align 2

.ITEM:
	.word 0x020270B8 + (0x8001 * 2) @ITEM ID
.MON:
	.word 0x020270B8 + (0x8000 *2) @PKMN SPECIES