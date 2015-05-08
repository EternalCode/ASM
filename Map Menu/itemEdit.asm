.text
.align 2
.thumb
.thumb_func

main:
	push {lr}
	ldr r0, =(0x81081D0 +1) @bag functions you told me to add
	bl weCheat
	ldr r0, =(0x81083F4 + 1)
	bl weCheat @end of bag stuff
	ldr r0, .MAP
	mov r1, #0x0
	ldr r3, = (0x807741C +1) @pass to task_add paramaters
	bl weCheat2
	pop {pc}

weCheat:
	bx r0

weCheat2:
	bx r3

.align 2

.MAP:
	.word (0x80A1C60 +1)