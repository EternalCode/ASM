.text
.align 2
.thumb
.thumb_func

@0x3DACE: 00 00 00 4F 38 47 XX XX XX 08

main:
	push {r0-r3}
	mov r0, #0x1 @item ID
	mov r1, #0x1 @quantity
	ldr r2, =(0x8099F40 +1)
	bl linker
	cmp r0, #0x0
	beq normal
	mov r0, #0xA
	lsl r0, r0, #0x7
	add r0, r0, #0x55 @1/1365 chance with shiny charm
	b calcChance
	
normal:
	mov r0, #0x20
	lsl r0, r0, #0x7 @1/4096 chance normally
	
calcChance:
	ldr r1, =(0x20370B8)
	strh r0, [r1]
	ldr r2, .random
	bl linker
	cmp r0, #0xFF
	beq end
	mov r0, #0xFF
	ldr r1, =(0x20370BC)
	strb r0, [r1]
	ldr r1, =(0x20370B8)
	mov r0, #0x0
	strh r0, [r1]

end:
	pop {r0-r3}
	sub SP, SP, #0x20
	mov r7, r0
	ldr r4, [SP, #0x40]
	ldr r4, [SP, #0x48]
	mov r5, #0xE
	ldr r6, =(0x803DAD8 +1)
	bx r6
	
linker:
	bx r2
	
	
.align 2

.random:
	.word 0x8770001