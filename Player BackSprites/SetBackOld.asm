.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r1, lr}
	ldr r0, .Player
	ldr r0, [r0]
	add r0, r0, #0x8
	ldr r1, .Save
	ldrb r1, [r1]
	strb r1, [r0]	
	pop {r0-r1, pc}

.align 2
.Player:
	.word 0x300500C
.Save:
	.word 0x203C231 @save current