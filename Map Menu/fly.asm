.text
.align 2
.thumb
.thumb_func

main:
	push {lr}
	ldr r1, .RETURN
	mov lr, r1
	push {r1, lr}
	ldr r0, =(0x8124A8C +1)
	mov r1, #0x0
	ldr r3, = (0x807741C + 1)
	bl weCheat
	pop {pc}

weCheat:
	bx r3	

.align 2

.RETURN:
	.word (0x8124664 +1)