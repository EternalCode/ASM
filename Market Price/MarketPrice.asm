.text
.align 2
.thumb
.thumb_func

main:
	add r0, r0, r4
	ldrh r0, [r0, #0x10]
	mov r4, r0
	push {r2-r3}
	mov r0, #0x98
	lsl r0, r0, #0x2
	ldr r2, =(0x806E6D0 +1) @check flag 0x260
	bl linker
	cmp r0, #0x0
	beq noChange
	
calculateNewPrice:
	ldr r1, =(0x20370B8)
	ldrh r1, [r1]
	mov r0, r4
	mul r0, r0, r1 @multiply (percent * 100) * (Original price)
	mov r1, #0x64
	ldr r2, =(0x81E4018 +1) @integer divide by 100 = rounded price
	bl linker
	mov r1, r4

checkModification:
	ldr r2, =(0x20370BA) @var 0x8001
	ldrb r2, [r2]
	cmp r2, #0x0 @increase by percent
	bne decreasePrice
	add r0, r0, r1 @finalized total
	b end
	
noChange:
	mov r0, r4
	b end
	
decreasePrice:
	sub r0, r1, r0
	
end:
	pop {r2-r3}
	pop {r4}
	pop {r1}
	bx r1
	
linker:
	bx r2
	
.align 2

