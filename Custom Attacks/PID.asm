.text
.align 2
.thumb
.thumb_func

main:
	ldr r5, .VAR
	mov r4, #0x0

loop:
	mov r1, r5 @check if attacks are set
	ldrb r1, [r1]
	cmp r1, #0x0
	beq noCrash
	mov r1, #0x2 @calculate location of next attack
	mul r1, r1, r4
	add r1, r1, r5
	ldrh r1, [r1]
	mov r0, r8
	ldr r3, =(0x803E8B0 +1)
	bl linkerTwo
	add r4, r4, #0x1
	cmp r4, #0x4
	bne loop
	

noCrash:
	lsl r0, r0, #0x10
	mov r1, r9
	lsr r5, r1, #0x10
	ldr r3, [sp]
	ldr r1, = (0x803EA60 +1)
	cmp r0, r9
	bne linkerOne
	ldr r1, = (0x803EA56 +1)
	bx r1

linkerTwo:
	bx r3

linkerOne:
	bx r1
	

.align 2

.VAR:
	.word 0x020370B8