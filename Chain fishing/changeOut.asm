.text
.align 2
.thumb
.thumb_func

@inserted at 08737000
@978C10

@0805D316: 00 00 00 49 08 47 01 70 73 08

main:
	mov r1, #0x8
	ldrsh r0, [r4, r1]
	lsl r0, r0, #0x2
	add r0, r0, r5
	ldr r1, [r0]
	
change:
	ldr r0, =(0x805D7C0 +1)
	cmp r0, r1
	bne normal
	
reset:
	ldr r1, =(0x87FFE80 +1) @abilityID
	bl linker
	ldr r1, =(0x20370B8)
	ldrb r0, [r1]
	cmp r0, #0x15
	beq higherCatchChance
	cmp r0, #0x3C
	bne noCatch
	
higherCatchChance:
	mov r0, #0x2
	strh r0, [r1]
	push {r2-r3}
	ldr r1, .random
	bl linker
	pop {r2-r3}
	cmp r0, #0x1
	beq reFish
	
noCatch:
	ldr r1, =(0x805D7C0 +1)
	b normal
	
reFish:
	ldr r1, =(0x805D5EC +1)
	
normal:
	ldr r0, =(0x805D320 +1)
	bx r0
	
	
linker:
	bx r1
	
linkerTwo:
	bx r2

.align 2

.random:
	.word 0x8978BD1 @8770001