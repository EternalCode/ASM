.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r2, lr}
	ldr r0, =(0x20370D0)@get tree data location
	ldrh r0, [r0]
	ldr r1, .SAVEBLOCK
	mov r2, #0x6
	mul r0, r0, r2
	add r0, r0, r1
	mov r2, #0x0
	mov r1, r2

loop:
	cmp r2, #0x7
	beq end
	strb r1, [r0]
	add r0, r0, #0x1
	add r2, r2, #0x1
	b loop

end:
	pop {r0-r2, pc}
	

.align 2
.SAVEBLOCK:
	.word 0x203C000
	

