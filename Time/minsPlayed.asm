.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r2, lr}
	ldr r0, .PlayTime
	ldr r0, [r0]
	add r0, r0, #0xE @hours
	ldrh r1, [r0]
	mov r3, #0x3C
	mul r1, r1, r3 @minute representaiton of hour
	add r0, r0, #0x2 @mins
	ldrb r2, [r0]
	add r1, r1, r2 @get total ingame mins spent
	ldr r0, =(0x20370D0) @store minutes played in lastresult
	strh r1, [r0]
	pop {r0-r2, pc}


.align 2
.PlayTime:
	.word 0x300500C
