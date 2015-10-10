.text
.align 2
.thumb
.thumb_func

@r3 arguement is a word
@first half = x pos
@second half = y pos

main:
	push {r4-r7, lr}
	mov r4, r8
	mov r5, r9
	mov r6, r10
	push {r4-r6}
	sub SP, SP , #0x4

npc_rom_data:
	mov r8, r0  @r0 = npc ROM ID
	mov r9, r1  @r1 = npc bank number
	mov r10, r2 @r2 = npc map bank
	mov r7, r3  @r3 = X and Y pos
	ldr r4, =(0x805FD5C +1) @NPC data from ID and map
	bl linker
	
copy_npc_data:
	mov r5, r0
	mov r0, #0x18
	ldr r4, =(0x8002B9C +1) @malloc
	bl linker
	mov r1, r5              @src
	mov r5, r0              @dest
	mov r2, #0x18           @size
	ldr r4, =(0x81E5E78 +1) @memcpy
	bl linker
	mov r0, r5
	
set_personalized_xy_pos:
	mov r2, r7 
	lsr r2, r7, #0x10
	strh r2, [r0, #0x4] @x pos
	lsl r2, r7, #0x10
	lsr r2, r2, #0x10
	strh r2, [r0, #0x6] @y pos
	
instanciate_npc_by_ROM_data:
	mov r0, r5   @NPC Data
	mov r1, r9   @Map number
	mov r2, r10  @Map Bank
	mov r3, #0x0 @x value to add to pos
	str r3, [SP] @y value to add to pos
	ldr r4, =(0x805E72C +1)
	bl linker
	mov r6, r0
	mov r0, r5
	ldr r4, =(0x8002BC4 +1) @free
	bl linker
	
end:
	mov r0, r6
	add SP, SP, #0x4
	pop {r4-r6}
	mov r8, r4
	mov r9, r5
	mov r10, r6
	pop {r4-r7, pc}
	
linker:
	bx r4
	
.align 2



