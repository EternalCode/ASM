.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r7, lr}
	mov r4, #0xBA
	mov r5, #0x0
loop:
	cmp r5, r4
	bhs end
	ldr r0, .STORAGE
	lsl r1, r5, #0x2
	add r0, r0, r1
	ldrh r3, [r0]
	cmp r3, #0x0
	beq next_item
	add r1, r0, #0x2
	ldrh r1, [r1]
	mov r0, r3
	push {r4-r6}
	ldr r2, =(0x809A084 +1)	
	bl linker
	pop {r4-r6}

next_item:
	add r5, r5, #0x1
	b loop

linker:
	bx r2

	
end:
	pop {r0-r7, pc}
	
.align 2

.STORAGE:
	.word 0x203C280 @ItemStorage
