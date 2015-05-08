.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r5, lr}
	@mov r0, #0x[flag/4]
	@lsl r0, r0, #0x2
	@ldr r3, =(0x806E6D0 +1)
	@bl linker
	@cmp r0, #0x0
	@beq end
	ldr r0, =(0x2023E8A)
	ldrb r0, [r0]
	cmp r0, #0x0
	beq realEnd
	mov r5, #0x0

loop:
	ldr r0, =(0x2024029)
	ldrb r4, [r0]
	cmp r5, r4
	beq end
	ldr r0, =(0x2024284)
	mov r1, #0x64
	mul r1, r1, r5 @slot
	add r0, r0, r1 @address
	mov r3, r0
	mov r1, #0xB
	push {r3-r5}
	ldr r3, =(0x803FBE8 +1)
	bl linker
	pop {r3-r5}
	cmp r0, #0xC2
	beq skip
	cmp r0, #0xC3
	beq skip
	mov r0, r3
	mov r1, #0x39 @C_HP
	push {r4-r5}
	ldr r3, =(0x803FBE8 +1)
	bl linker
	pop {r4-r5}
	cmp r0, #0x0
	beq adjustSlots

skip:
	add r5, r5, #0x1
	b loop


adjustSlots:
	cmp r5, #0x5
	bge writeLastZero	
	mov r2, #0x5
	sub r2, r2, r5
	mov r0, #0x64
	mul r2, r2, r0 @size
	mov r1, r5
	mul r1, r1, r0
	ldr r0, =(0x2024284)
	add r0, r0, r1 @dest
	mov r1, #0x64
	add r1, r0, r1 @src
	push {r4-r5}
	ldr r3, =(0x8040B08 +1)
	bl linker
	pop {r4-r5}


writeLastZero:
	ldr r0, =(0x2024478)
	mov r1, #0x0
	mov r2, #0x64
	push {r4-r5}
	ldr r3, =(0x81E5ED8 +1)
	bl linker
	pop {r4-r5}

correctCounters:
	ldr r0, =(0x2024029)
	ldrb r1, [r0]
	sub r1, r1, #0x1
	strb r1, [r0]
next:
	mov r5, #0x0
	b loop	

end:
	ldr r0, =(0x2024029)
	ldrb r0, [r0]
	cmp r0, #0x0
	bne realEnd
	mov r0, #0x5E
	lsl r0, r0, #0x4
	ldr r3, =(0x806E6A8 +1)
	bl linker
	b realEnd


linker:
	bx r3

realEnd:
	pop {r0-r5, pc}


.align 2