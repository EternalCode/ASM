.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r3, lr}
	ldr r0, =(0x20370C0) @this is var 0x8004
	ldrb r0, [r0]
	cmp r0, #0x5 @storage limit minus 1
	beq writeZero
	cmp r0, #0x5
	bhi PurgeAll
	mov r2, #0x5
	sub r2, r2, r0
	mov r3, #0x50
	mul r2, r2, r3 @size
	ldr r1, .STORAGE
	mul r0, r0, r3
	add r0, r0, r1 @dest
	add r3, r3, r0
	mov r1, r3      @src
	ldr r3, =(0x8040B08 +1) @func
	bl linker

writeZero:
	ldr r0, .STORAGE
	mov r1, #0xC8
	lsl r1, r1, #0x1
	add r0, r0, r1
	mov r1, #0x0
	mov r2, #0x50
	ldr r3, =(0x81E5ED8 +1)
	bl linker

updateCounters:
	ldr r0, .STORAGE
	sub r0, r0, #0x1
	ldrb r2, [r0]
	sub r2, r2, #0x1
	strb r2, [r0]
	pop {r0-r3, pc}

PurgeAll:
	ldr r0, .STORAGE
	mov r2, #0xF0
	lsl r2, #0x1
	mov r1, #0x0
	ldr r3, =(0x81E5ED8 +1)
	bl linker

SetCounterZero:
	ldr r0, .STORAGE
	sub r0, r0, #0x1
	mov r1, #0x0
	strb r1, [r0]
	pop {r0-r3, pc}
	

linker:
	bx r3	
	
.align 2

.STORAGE:
	.word 0x203C001 @storage location