.text
.align 2
.thumb
.thumb_func

main:
	push {r0, r4, lr}
	ldr r0, .FROM
	ldr r1, [r0]
	cmp r1, #0x0 @party
	beq addParty

addStorage:
	ldr r0, .STORAGE
	sub r0, r0, #0x1
	ldrb r1, [r0]
	cmp r1, #0x6 @limit of storage. Change depending on your space situation
	beq end
	add r0, r0, #0x1
	mov r2, #0x50

skipline:
	mul r1, r1, r2
	add r0, r0, r1 @destination
	ldr r1, =(0x20370C0)
	ldrb r1, [r1]
	ldr r2, .PARTY
	mov r3, #0x64
	mul r1, r1, r3
	add r1, r1, r2 @source
	mov r2, #0x50 @size
	ldr r3, =(0x8040B08 +1) @func
	bl linker
	@need to fix up Player's party slots
	ldr r1, =(0x20370C0)
	ldrb r1, [r1]
	cmp r1, #0x5
	beq writeLastZero
	mov r2, #0x5
	sub r2, r2, r1
	mov r3, #0x64
	mul r2, r2, r3 @size
	ldr r0, .PARTY
	mul r1, r1, r3
	add r0, r0, r1 @dest
	add r3, r3, r0
	mov r1, r3      @src
	ldr r3, =(0x8040B08 +1) @func
	bl linker
	

writeLastZero:
	ldr r0, =(0x2024478)
	mov r1, #0x0
	mov r2, #0x64
	ldr r3, =(0x81E5ED8 +1)
	bl linker

correctCounters:
	ldr r0, .STORAGE
	sub r0, r0, #0x1
	ldrb r2, [r0]  @pks in storage counter
	ldr r1, =(0x2024029)
	ldrb r3, [r1] @pks in party
	add r2, r2, #0x1
	strb r2, [r0]
	sub r3, r3, #0x1
	strb r3, [r1]
	b end
	


addParty:
	ldr r0, =(0x2024029)
	ldrb r0, [r0]
	cmp r0, #0x6
	beq end
	ldr r1, .PARTY
	mov r2, #0x64
	mul r0, r0, r2
	add r0, r0, r1 @destination
	mov r4, r0
	ldr r3, .STORAGE
	ldr r1, =(0x20370C0) @var 0x8004 determines which slot of storage to take from
	ldrb r1, [r1]
	mov r2, #0x50 @size
	mul r1, r1, r2
	add r1, r1, r3 @source
	ldr r3, =(0x8040B08 +1) @func
	bl linker
	@update stats 
	mov r0, r4
	ldr r3, =(0x803E47C +1)
	bl linker
	@adjust the storage
	ldr r0, =(0x20370C0)
	ldrb r0, [r0]
	cmp r0, #0x5 @storage limit minus 1
	beq writeZero
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
	ldr r1, =(0x2024029)
	ldrb r3, [r1]
	sub r2, r2, #0x1
	strb r2, [r0]
	add r3, r3, #0x1
	strb r3, [r1]

end:
	pop {r0-r4, pc}	

linker:
	bx r3	
	
.align 2

.FROM:
	.word 0x20270B8 + (0x8000 *2)

.STORAGE:
	.word 0x203C001 @storage location

.PARTY:
	.word 0x2024284 @player's party