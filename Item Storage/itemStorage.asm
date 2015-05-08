.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r7, lr}
	mov r4, #0x0 @bag_counter = 0
	mov r7, #0x0
loop:
	cmp r4, #0x5 @while bag _counter <= 4
	bhi end
	ldr r0, =(0x203988C) @r0 = Pointer( Bag_location_array[bag_pocket, space])
	mov r1, r4
	lsl r1, r1, #0x3
	add r0, r0, r1 @ r0 = Pointer( [bag_counter, space])
	add r5, r0, #0x4
	ldrb r5, [r5]@loop duration = byte(space)
	ldr r3, [r0] @r0 = Bag_pocket
	mov r6, #0x0
	
itemLoop:
	cmp r6, r5 @while (pocket_index <= pocket_space)
	bhs next_pocket
	ldrh r0, [r3] @item
	mov r1, r7
	lsl r1, r1, #0x2
	ldr r2, .STORAGE
	add r2, r2, r1
	strh r0, [r2] @STORAGE.append(Item ID from pocket)
	add r2, r2, #0x2
	add r0, r3, #0x2
	push {r2-r7}
	ldr r3, =(0x8099DA0 +1)
	bl linker
	pop {r2-r7}
	strh r0, [r2] @STORAGE.append(item quantity)
	add r7, r7, #0x1
	add r3, r3, #0x4
	add r6, r6, #0x1 @pocket_index ++
	b itemLoop

next_pocket:
	add r4, r4, #0x1@bag_counter ++
	b loop

		
linker:
	bx r3

end:
	pop {r0-r7, pc}
	
.align 2

.ITEMS:
	.word 0x203988C

.STORAGE:
	.word 0x203C280 @ItemStorage
