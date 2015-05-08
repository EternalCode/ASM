.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r3, lr}
	ldr r0, .STORAGE
	mov r1, #0x0
	mov r2, #0xBA
	ldr r3, =(0x81E5ED8 +1)
	bl linker
	pop {r0-r3, pc}

linker:
	bx r3
	
	
.align 2

.ITEMS:
	.word 0x203988C

.STORAGE:
	.word 0x203C280 @ItemStorage
