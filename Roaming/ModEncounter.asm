.text
.align 2
.thumb
.thumb_func

@inserted at 07702A0

main:
	push {r0-r7}
	@check if any pokemon roam this map
	ldr r5, .ROAMERS
	ldrb r5, [r5]
	mov r6, #0x0
	
loop:
	cmp r6, r5
	beq noCrash
	ldr r0, .ROAMERS
	mov r1, #0x68
	mul r1, r1, r6
	add r0, r0, r1
	add r0, r0, #0x66
	ldrh r2, [r0] @roaming maps
	ldr r0, =(0x2031DBC)
	ldrh r0, [r0]
	cmp r0, r2
	beq rollForSwap

next:
	add r6, r6, #0x1
	b loop
	
rollForSwap:
	push {r0-r4}
	ldr r0, =(0x20370B8)
	mov r1, #0x1 @encounter chance 1/r1
	strb r1, [r0]
	ldr r4, =(0x8770000 +1) @rand
	bl linker
	cmp r0, #0x0 
	beq changeEncounter
	pop {r0-r4}
	b next

changeEncounter:
	pop {r0-r4}
	ldr r0, .ROAMERS
	add r0, r0, #0x1
	mov r1, #0x68
	mul r1, r1, r6
	add r1, r1, r0 @source
	ldr r0, =(0x202402C) @dest
	mov r2, #0x64 @size
	push {r6}
	ldr r4, =(0x8040B08 +1) @func
	bl linker
	pop {r6}
	ldr r0, =(0x20370C4)
	mov r1, r6
	strb r1, [r0]
	ldr r0, =(0x20370C2)
	mov r1, #0xFF
	strb r1, [r0]
	pop {r0-r7}
	ldr r4, =(0x8082A74 +1) @end
	bx r4

noCrash:
	ldr r0, =(0x20370C2)
	mov r1, #0x0
	strb r1, [r0]
	pop {r0-r7}
	cmp r4, #0xC9
	beq place
	ldr r2, =(0x8044EC8 +1)
	bl linkerTwo
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	ldr r1, =(0x8082A1C +1)
	bx r1

place:
	ldr r0, =(0x8082A3C +1)
	bx r0
	
linker:
	bx r4
	
linkerTwo:
	bx r2


.align 2

.ROAMERS:
	.word 0x203D000