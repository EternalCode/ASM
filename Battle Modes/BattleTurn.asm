.text
.align 2
.thumb
.thumb_func

@Insert at 0x13CB0: 00 48 00 47 XX XX XX 08
@XX XX XX = pointer to this routine +1 in reverse hex

main:
	push {r0-r7}
	@check flag 0x2F8 to toggle routines (0xBE*4 = 0x2F8)
	mov r0, #0xBE
	lsl r0, r0, #0x2
	ldr r2, =(0x806E6D0 +1)
	bl linker
	cmp r0, #0x0
	beq skip
	ldr r4, .table

loop:
	ldr r1, [r4]
	mov r0, r1
	ldrb r0, [r0]
	cmp r0, #0xFF @check table entry is free space
	beq skip
	push {r4}
	bl linker @call table routine
	pop {r4}
	add r4, r4, #0x4 @get next table routine
	b loop
	
skip:
	pop {r0-r7}
	ldr r1, = 0x3004F90
	ldrb r0, [r1, #0x13]
	cmp r0, #0xFE
	bhi replacer
	add r0, #0x1
	strb r0, [r1, #0x13]
 
replacer:
	ldr r2, = (0x8013CBC + 1)
 
linker:
	bx r2

.align 2

.table:
	0x[pointer to Routine table]
