.text
.align 2
.thumb
.thumb_func	


main:
	push {r0-r5, lr}
	ldr r0, =(0x300500C)
	ldr r0, [r0]
	add r0, r0, #0x10
	ldrb r0, [r0] @mins
	mov r1, #0x1 @how often to add interest (range is from 0x1 to 0x3B)
	ldr r2, =(0x81E4684 +1)
	bl linker2
	cmp r0, #0x0
	beq end
	
calculateInterest:
	mov r0, #0x82 @ r0 = var = 0x82
	lsl r0, #0x7 @ var = 0x82 * 0x80 = 4100
	sub r0, r0, #0x1 @4100 -1 = 0x40FF, this is the variable tracking bank deposit value. Change amount subtracted if your var is different
	mov r5, r0
	ldr r4, =(0x806E568 +1) @get var
	bl linker
	mov r1, #0xA @0xA = 10%
	mov r4, r0
	mul r0, r0, r1 @multiply (percent * 100) * (Original price)
	mov r1, #0x64
	ldr r2, =(0x81E4018 +1) @integer divide by 100 = rounded price
	bl linker2
	add r1, r0, r4 @finalized total
	mov r0, r5
	ldr r4, =(0x806E584 +1) @set var
	bl linker
	b end
	
linker:
	bx r4

linker2:
	bx r2
	
end:	
	pop {r0-r5, pc}
	
.align 2

