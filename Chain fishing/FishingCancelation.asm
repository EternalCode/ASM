.text
.align 2
.thumb
.thumb_func

@inserted at 08736000 @978C80
@5D2C2: 00 00 00 4D 28 47 XX XX XX 08

main:
	@make sure boolean is not set. if it is, clear chain
	push {r0-r5}
	ldr r0, =(0x20370BC)
	ldrb r0, [r0]
	mov r1, #0x2
	ldr r5, =(0x81E4684 + 1)
	bl linker
	cmp r0, #0x1
	beq resetChain
	ldr r0, =(0x20370B8)
	mov r1, #0xFF
	lsl r1, r1, #0x8
	add r1, r1, #0xFF
	strh r1, [r0]
	ldr r5, .random
	bl linker
	ldr r1, =(0x20370BC)
	ldrb r1, [r1]
	lsl r1, r1, #0x7
	cmp r0, r1
	ble setShiny
	pop {r0-r5}
	b fishing_start
	
setShiny:
	ldr r0, =(0x20370BC)
	mov r1,#0xFE
	strb r1, [r0]
	pop {r0-r5}
	b fishing_start
	
resetChain:
	ldr r0, =(0x20370BC)
	mov r1, #0x0
	strb r1, [r0]
	pop {r0-r5}

fishing_start:
	mov r4, r0
	lsl r4, r4, #0x18
	lsr r4, r4, #0x18
	ldr r5, =(0x805D304 +1)
	mov r0, r5
	ldr r1, =(0x805D2CC +1)
	bx r1
	
	
linker:
	bx r5

.align 2

.random:
	.word 0x8978BD1@0x8770001