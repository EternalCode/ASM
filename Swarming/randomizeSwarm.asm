.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r5, lr}
	@check swarm flag
	mov r0, #0x92
	lsl r0, r0, #0x2
    ldr r2, =(0x806E6D0 +1) @checkflag 0x92 *0x4 = 0x248
	bl linker
	cmp r0, #0x0
	beq end
	
checkTime:
	ldr r0, =(0x300500C)
	ldr r0, [r0]
	add r0, r0, #0x10
	ldrb r0, [r0] @mins
	mov r1, #0x1 @how often to change swarm (range is from 0x1 to 0x3B)
	ldr r2, =(0x81E4684 +1)
	bl linker
	cmp r0, #0x0
	bne end
	
changeSwarm:
	ldr r1, =(0x20370B8)
	ldr r0, .PossibleSwarms
	ldrb r0, [r0]
	strb r0, [r1] 
	ldr r2, .random @pick a random swarm
	bl linker
	mov r2, r0
	mov r0, #0x81 @var = (81 *80) + 1 = 0x407F
	lsl r0, #0x7
	sub r0, r0, #0x1
	mov r1, r2
	push {r2}
	ldr r2, =(0x806E584 +1) @set var 0x407F to random
	bl linker
	pop {r2}
	mov r1, #0x4
	mul r1, r1, r2 
	ldr r0, .SwarmTable @formatted, [Species 2 bytes] [map data: 2 bytes]
	add r0, r0, r1
	ldr r0, [r0] @current swarmer data
	lsl r1, r0, #0x10
	lsr r1, r1, #0x10 @species
	lsr r3, r0, #0x10 @map data

setVars:
	mov r0, #0x81 @var = 81 *80  = 0x4080
	lsl r0, #0x7
	push {r3}
	ldr r2, =(0x806E584 +1) @set var 0x4080 to species
	bl linker
	pop {r3}
	mov r0, #0x81 @var = (81 *80) + 2 = 0x4082
	lsl r0, #0x7
	add r0, r0, #0x2
	mov r1, r3
	lsr r1, r1, #0x8 @map number
	push {r3}
	ldr r2, =(0x806E584 +1) @set var 0x4082 to map number
	bl linker
	pop {r3}
	mov r0, #0x81 @var = (81 *80) + 2 = 0x4081
	lsl r0, #0x7
	add r0, r0, #0x1
	mov r1, r3
	lsl r1, r1, #0x18
	lsr r1, r1, #0x18 @map bank
	push {r3}
	ldr r2, =(0x806E584 +1) @set var 0x4081 to map bank
	bl linker
	pop {r3}
		

end:
	pop {r0-r5, pc}

linker:
	bx r2
	
.align 2

.random:
	.word 0x8770001

.SwarmTable:
	.word 0x8800000

.PossibleSwarms:
	.word 0x87FFFFF