.text
.align 2
.thumb
.thumb_func

@Insert at 0xE2E0: 01 4D 28 47 00 00 XX XX XX 08

main
	push {r0-r4}
	mov r0, #0xBF @flag to check divided by 4
	lsl r0, r0, #0x2
	ldr r1, =(0x806E6D0 +1)
	bl linker
	cmp r0, #0x0
	beq noCrash
	ldr r4, .table

loop:
	ldr r1, [r4]
	mov r0, r1
	ldrb r0, [r0]
	cmp r0, #0xFF @check table entry is free space
	beq noCrash
	push {r4}
	bl linker @call table routine
	pop {r4}
	add r4, r4, #0x4 @get next table routine
	b loop
	

noCrash:
	pop {r0-r4}
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	mov r10, r0
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	ldr r2, =(0x2022874)
	ldr r0, =(0x800E2EA +1)
	bx r0

linker:
	bx r1
	
	
.align 2

.table:
	0x[pointer to routine table]
