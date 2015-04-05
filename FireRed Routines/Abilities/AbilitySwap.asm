.text
.align 2
.thumb
.thumb_func


main:
	push {r0-r4, lr}
	ldr r1, =(0x20370C0) @var 0x8004
	ldrb r1, [r1]
	mov r2, #0x64
	mul r1, r1, r2
	ldr r0, =(0x2024284)
	add r0, r0, r1 @slot
	mov r4, r0 @save slot
	mov r1, #0x2E
	ldr r3, =(0x803FBE8 +1)
	bl linker
	cmp r0, #0x1
	beq setZero
	mov r0, #0x1
	b setNew

setZero:
	mov r0, #0x0
	
setNew:
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	ldr r2, =(0x20370D0) @set inverse
	strb r0, [r2]
	mov r0, r4
	mov r1, #0x2E
	ldr r3, =(0x804037C +1)
	bl linker
	pop {r0-r4, pc}

linker:
	bx r3

.align 2
