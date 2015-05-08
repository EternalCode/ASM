.text
.align 2
.thumb
.thumb_func	

@hook at 080259F0
@00 49 08 47 01 00 83 08

main:
	mov r1, #0xA4
	lsl r1, r1, #0x2
	add r0, r0, r1
	mov r1, r4
	ldr r4, =(0x20370B8)
	strh r1, [r4]
	push {r0-r4}

flagCheck:
	mov r0, #0x94
	lsl r0, r0, #0x2
	 ldr r2, =(0x806E6D0 +1) @checkflag 0x94 *0x4 = 0x250
	bl linker
	cmp r0, #0x0
	beq endTwo

moveToBankVar:
	mov r0, #0x82 @ r0 = var = 0x82
	lsl r0, #0x7 @ var = 0x82 * 0x80 = 4100
	sub r0, r0, #0x1 @4100 -1 = 0x40FF, this is the variable tracking bank deposit value. Change amount subtracted if your var is different
	mov r4, r0
	ldr r2, =(0x806E568 +1) @get var
	bl linker
	ldr r1, =(0x20370B8)
	ldrh r1, [r1]
	add r1, r1, r0
	mov r0, r4
	ldr r2, =(0x806E584 +1) @set var
	bl linker	
	
end:
	pop {r0-r4}
	mov r4, r1
	ldr r1, =(0x8025A00 +1)
	bx r1
	
endTwo:
	pop {r0-r4}
	mov r4, r1
	push {r4}
	ldr r4, =(0x809FDA0 +1)
	bl linker2
	pop {r4}
	ldr r1, =(0x8025A00 +1)
	bx r1
	
linker2:
	bx r4
	
linker:
	bx r2
	
.align 2

