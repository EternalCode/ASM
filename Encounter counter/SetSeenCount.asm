.text
.align 2
.thumb
.thumb_func

main:
	ldr r0, = (0x202402C)
	mov r1, #0xB
	ldr r2, = (0x803FBE8 +1)
	bl linker
	ldr r1, .SAVEBLOCK
	add r1, r1, r0
	ldrb r1, [r0]
	strb r1, [r0 + #0x1]

noCrash:
	ldr r0, = (0x2023BC8)
	ldr r0, [r0]
	cmp r0, #0x0
	bne end
	ldr r1, =(0x801351C +1)
	bx r1
end:
	pop {r0}
	bx r0

linker:
	bx r2

.align 2
.SAVEBLOCK:
	.word 0x0203C000
