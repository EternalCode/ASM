.text
.align 2
.thumb
.thumb_func

@add swarmer

main:
	push {r0-r5, lr}
	ldr r0, =(0x20370B8)
	ldrh r0, [r0] @species
	ldr r1, =(0x20370BA)
	ldrh r1, [r1] @map [Bank (1 byte)][Map Number (1 bytes)]

set:
	ldr r3, .Swarmers

loop:
	ldr r4, [r3]
	cmp r4, #0x0
	beq store
	add r3, r3, #0x4 @loop until next free space
	b loop

store:
	lsl r0, r0, #0x10
	orr r0, r0, r1 
	str r0, [r3]
	
end:
	pop {r0-r5, pc}
	

.align 2

.Swarmers:
	.word 0x203C324

