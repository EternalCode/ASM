.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r2, lr}
	ldr r0, =(0x[pointer to minsPlayed.asm location] +1)
	bl linker
	ldr r0, .PlayTime
	ldr r0, [r0]
	add r0, r0, #0x11 @seconds played
	ldrb r0, [r0]
	ldr r1, =(0x20370D0)
	ldrh r1, [r1]
	mov r2, #0x3C
	mul r1, r1, r2
	add r1, r1, r0 @total seconds played
	lsr r1, r1, #0x8
	lsl r1, r1, #0x8
	ldr r0, =(0x20370D4)
	str r1, [r0] @6 bytes representing time played in seconds
	
	
end:
	pop {r0-r2, pc}

linker:
	bx r3


.align 2
.PlayTime:
	.word 0x300500C
