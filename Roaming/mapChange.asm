.text
.align 2
.thumb
.thumb_func

@inserting hook at 080548A8
@inserted routine at 08770201
@Table of pointers format: (start at word aligned offset - 1)
@[Entries(1 byte)][pointers (4 bytes)]
@Map banks format: (start at half word aligned offset -1)
@[Entries (1 byte)][map bank (1 byte)][map number (1 byte)]


main:
	push {r0-r5}
	ldr r0, =(0x300500C)
	ldr r0, [r0]
	add r0, r0, #0x10
	ldrb r0, [r0] @mins
	mov r1, #0x2
	ldr r2, =(0x81E4684 +1)
	bl linker
	cmp r0, #0x0
	beq newLocations
	
noCrash:
	pop {r0-r5}
	ldrb r0, [r1, #0x10]
	cmp r0, #0x59
	bls end
	strb r3, [r1, #0x10]
	ldr r0, =(0x80548B0 +1)
	bx r0

end:
	pop {r0}
	bx r0


newLocations:
	ldr r0, .ROAMERS
	ldrb r3, [r0] @counter
	mov r4, #0x0

loop:
	cmp r4, r3
	beq noCrash
	mov r1, #0x68
	add r0, r0, r1
	ldrb r1, [r0] @table index
	ldr r2, .TABLE
	lsl r1, #0x2
	add r2, r2, r1
	add r2, r2, #0x1 @pointer
	ldr r1, [r2] @data
	ldrb r2, [r1] @amount of maps
	ldr r5, =(0x20370B8)
	strb r2, [r5]
	push {r0-r4}
	ldr r2, =(0x8770000 +1) @random
	bl linker
	mov r5, r0
	pop {r0-r4}
	lsl r5, r5, #0x1
	add r1, r1, #0x1
	add r5, r5, r1 @map to set to
	sub r0, r0, #0x2
	ldr r5, [r5]
	strh r5, [r0] @update new roam map
	add r0, r0, #0x2
	add r4, r4, #0x1
	b loop	
	
	
linker:
	bx r2


.align 2

.ROAMERS:
	.word 0x203D000
	
.TABLE:
	.word 0x87FFFFF
