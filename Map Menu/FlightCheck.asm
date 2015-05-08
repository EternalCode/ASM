.text
.align 2
.thumb
.thumb_func

main:
	push {lr, r1}
	ldr r0, .VAR @set paramaters for special
	mov r1, #0x2
	strb r0, [r1]
	ldr r1 = (0x80CA804 +1) @check flying type
	bl .CALLER
	cmp r0, #0x6
	bge NORMALMAP @if no flying open normal map
	ldr pc, =(0x8820000 +1) @open flying map
	b END

NORMALMAP:
	ldr r1, =(0x880A1CC0 +1)
	bl CALLER
	b END

CALLER:
	bx r1

END:
	pop {pc}
	

.align 2
.VAR:
	.word 0x020270B4 + (0x8000 * 2)

