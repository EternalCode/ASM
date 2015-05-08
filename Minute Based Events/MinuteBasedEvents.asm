.text
.align 2
.thumb
.thumb_func	

@inserted at 770040

main:
	push {r0-r7}
	mov r4, #0x0
	
loop:
	ldr r0, .TABLE
	mov r1, #0x4
	mul r1, r1, r4
	add r0, r0, r1
	ldr r0, [r0] @load routine
	mov r1, r0
	lsr r1, r1, #0x18
	cmp r1, #0xFF
	beq noCrash @if end of routine table, break out
	bl linker
	add r4, r4, #0x1
	b loop
	
linker:
	bx r0
	

noCrash:
	pop {r0-r7}
	ldrb r0, [r1, #0x10]
	cmp r0, #0x59
	bls end
	strb r3, [r1, #0x10]
	ldr r0, =(0x80548B0 +1)
	bx r0

end:
	pop {r0}
	bx r0

.align 2

.TABLE:
	.word 0x8812000
