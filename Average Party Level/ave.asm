.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r5, lr}
	ldr r3, =(0x2024029)
	ldrb r3, [r3]
	mov r4, #0x0
	mov r5, #0x0

Loop:
	cmp r3, r4
	beq end
	mov r0, #0x64
	mul r0, r0, r4
	mov r1, r0
	ldr r0, =(0x2024284)
	add r0, r0, r1 @pkmn
	mov r1, #0x38
	ldr r2, =(0x803FBE8 +1)
	bl linker
	add r5, r5, r0
	add r4, r4, #0x1
	b Loop
	

end:
	mov r0, r5
	mov r1, r4
	ldr r2, =(0x81E4018 +1)
	bl linker
	ldr r1, =(0x20370D0)
	ldrb r0, [r1]
	pop {r0-r5, pc}
	
linker:
	bx r2
	
.align 2