.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r7, lr}
	ldr r0, =(0x2024284)
	mov r1, #0x0
	mov r2, #0x1
	mov r4, r1
	mov r7, r1
	ldr r6, =(0x80CDDA8 +1)
	bl linker
	bx r10
	pop {r0-r7, pc}

linker:
	bx r6

	

.align 2
