.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r1, lr}
	ldr r0, .Name
	ldr r0, [r0]
	add r1, r0, #0x1
	ldrb r1, [r1]
	cmp r1, #0x1 @girl
	beq Girl
	ldr r1, .CustomNameBoy
	ldr r2, [r1]
	add r1, r1, #0x4
	ldr r1, [r1]
	str r2, [r0]
	add r0, r0, #0x4
	str r1, [r0]
	pop {r0-r1, pc}

Girl:
	ldr r1, .CustomNameGirl
	ldr r2, [r1]
	add r1, r1, #0x4
	ldr r1, [r1]
	str r2, [r0]
	add r0, r0, #0x4
	str r1, [r0]
	pop {r0-r1, pc}


.align 2
.Name:
	.word 0x300500C

.CustomNameBoy:
	.word 0x@pointer to boy name

.CustomNameGirl:
	.word 0x@pointer to girl name