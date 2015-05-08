.text
.align 2
.thumb
.thumb_func

@at 08082A2A place hook

main:
	mov r0, #0x92
	lsl r0, r0, #0x2
    ldr r2, =(0x806E6D0 +1) @checkflag 0x92 *0x4 = 0x248
	bl linker
	cmp r0, #0x0
	beq setOld
	
rollForSwap:
	ldr r0, =(0x20370B8)
	mov r1, #0x1 @encounter change of swarmer vs normal chance
	strb r1, [r0]
	ldr r2, .random
	bl linker
	cmp r0, #0x0
	bne setOld
	
checkSwarmingMap:
	mov r0, #0x81 @var = (81 *80) + 1 = 0x407F
	lsl r0, #0x7
	sub r0, r0, #0x1
	ldr r2, =(0x806E568 +1)
	bl linker
	ldr r1, .SwarmTable
	mov r2, #0x4
	mul r0, r0, r2
	add r2, r0, r1
	add r2, r2, #0x2 @map data
	ldrh r0, [r2]
	ldr r1, =(0x2031DBC)
	ldrh r1, [r1]
	cmp r1, r0
	bne setOld

readSpecies:
	sub r1, r2, #0x2
	ldr r0, =(0x202402C) @src
	ldrh r1, [r1] @species
	cmp r1, #0x0 @check if species ID 0 (question mark)
	beq setOld
	cmp r1, #0xFF @check if species ID 0xFF (hacker made pointer error.)
	beq setOld
	mov r2, r6
	b end
	
setOld:
	ldr r0, =(0x202402C)
	mov r1, r4
	mov r2, r6
	
end:
	mov r3, #0x20
	ldr r4, =(0x803DD98 +1)
	bl linker2
	ldr r4, =(0x8082A36 +1)
	
linker2:
	bx r4
	
linker:
	bx r2
	

.align 2

.SwarmTable:
	.word 0x8800000
	
.random:
	.word 0x8770001


