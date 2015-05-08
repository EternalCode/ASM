.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r2, lr}
	ldr r0, .VAL
	ldr r0, [r0]
	ldr r2, .VAR
	str r0, [r2]
	ldr r1, =(0x80A1C60 +1)
	ldr r0, =(0x8109C50 + 1)
	bx r0
	

.align 2

.VAR:
	.word 0x203AD30
.VAL:
	.word 0x08810000