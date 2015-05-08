.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r5, lr}
	mov r3, #0x0

loop:
	cmp r3, #0x6
	beq StorageToParty
	ldr r0, .UNUSED
	mov r1, #0x50
	mul r1, r1, r3
	add r0, r0, r1  @dest
	ldr r2, .PARTY
	mov r1, #0x64
	mul r1, r1, r3
	add r1, r1, r2 @src
	mov r2, #0x50 @size
	push {r3}
	ldr r4, =(0x8040B08 +1)
	bl linker
	pop {r3}
	add r3, r3, #0x1
	b loop

StorageToParty:
	mov r3, #0x0

loop2:
	cmp r3, #0x6
	beq UnusedToStorage
	ldr r0, .PARTY
	mov r1, #0x64
	mul r1, r1, r3
	add r0, r0, r1  @dest
	ldr r2, .STORAGE
	mov r1, #0x50
	mul r1, r1, r3
	add r1, r1, r2 @src
	mov r2, #0x50 @size
	push {r3}
	ldr r4, =(0x8040B08 +1)
	bl linker
	pop {r3}
	ldr r0, .PARTY
	mov r1, #0x64
	mul r1, r1, r3
	add r0, r0, r1  @dest
	push {r3}
	ldr r4, =(0x803E47C +1) @calc stats
	bl linker
	pop {r3}
	add r3, r3, #0x1
	b loop2

UnusedToStorage:
	ldr r0, .STORAGE @dest
	ldr r1, .UNUSED @src
	mov r2, #0xF0@size
	lsl r2, r2, #0x1
	ldr r4, =(0x8040B08 +1)
	bl linker

updateCounters:
	ldr r0, .STORAGE
	sub r0, r0, #0x1
	ldrb r0, [r0]
	ldr r1, = (0x20370B8)
	strb r0, [r1]
	ldr r0, =(0x2024029)
	ldrb r0, [r0]
	ldr r2, .STORAGE
	sub r2, r2, #0x1
	strb r0, [r2]
	ldr r0, =(0x2024029)
	ldrb r1, [r1]
	strb r1, [r0]
	pop {r0-r5, pc}
		

linker:
	bx r4
	
.align 2

.UNUSED:
	.word 0x202402C  @this is exactly 600 bytes of space

.STORAGE:
	.word 0x203C001 @storage location; use JPAN's save block hack if you want

.PARTY:
	.word 0x2024284 @player's party