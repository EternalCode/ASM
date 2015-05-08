.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r2}
	ldr r0, .Counters
	ldrb r1, [r0]
	cmp r1, #0xFF
	beq increment

increment:
	mov r1, r0
	add r1, #0x1
	ldrh r2, [r1]
	add r2, #0x1
	strh r2, [r1]
	mov r2, #0x0
	strb r2, [r0]
	pop {r0-r2}

end:
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0x1
	beq linker
	mov r0, r5
	ldr r1, =(0x806D600 +1)
	bx r1

linker:
	ldr r0, =(0x806D650 +1)
	bx r0
	
	
.align 2

.Counters:
	.word 0x203BFFD @location to store exp counters