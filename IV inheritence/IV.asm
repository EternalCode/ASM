.text
.align 2
.thumb
.thumb_func

main:
	push {r3, r6}
	mov r6, lr
	mov r0, r5
	mov r1, #0xC
	ldr r2, =(0x803FD44 +1)
	bl linker
	mov r3, r0
	mov r0, r5
	add r0, r0, #0x8C
	mov r1, #0xC
	ldr r2, =(0x803FD44 +1)
	bl linker
	cmp r0, #0x1 @masterball lol. Change to item you want :D
	beq inherit
	cmp r3, #0x1 @Parent2 has masterball :D
	beq inherit

end:
	mov lr, r6
	pop {r3, r6}
	mov r0, SP
	mov r1, r5
	ldr r3, = (0x8045AC0 +1)
	bl linkerTwo
	ldr r0, =(0x8046100+1)
	bx r0

inherit:
	mov r3, #0x5
	bl generateRand
	ldrh r3, [r3]
	push {r4, r7}
	mov r4, #0x27
	add r4, r4, r3 @uninherited stat
	mov r7, #0x0

loop:
	cmp r7, #0x6
	beq prepareEnd
	cmp r7, r4
	beq next
	mov r3, #0x1
	bl generateRand @get a random parent's specified IV
	mov r0, r3
	ldrh r0, [r0]
	mov r1, #0x8C
	mul r0, r0, r1
	add r0, r0, r5
	mov r1, #0x27
	add r1, r1, r7
	ldr r2, =(0x803FBE8 +1)
	bl linker
	ldr r2, = (0x20370D0) @set IV to child
	strh r0, [r2]
	mov r1, #0x27
	add r1, r1, r7
	mov r0, SP
	ldr r3, =(0x804037C +1)
	bl linkerTwo	
next:
	add r7, r7, #0x1
	b loop
	 
prepareEnd:
	mov r0, SP
	ldr r3, =(0x803E47C +1) @calc stats
	bl linker
	pop {r4, r7}
	b end

generateRand:
	ldr r2, =(0x8044EC8 +1) @get a random between 0 - r3 (r3 = HW)
	bl linker
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	mov r1, r3
	ldr r3, =(0x81E4684 +1)
	bl linkerTwo
	ldr r3, = 0x20370D0 @could just move it to r3 I suppose
	strh r0, [r3]
	bx lr
		

linker:
	bx r2

linkerTwo:
	bx r3


.align 2

