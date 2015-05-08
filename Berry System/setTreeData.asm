.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r2, lr}
	ldr r0, =(0x20370BC)@get tree data
	ldrh r0, [r0]
	ldr r1, .SAVEBLOCK
	mov r2, #0x6
	mul r0, r0, r6
	add r0, r0, r1
	ldr r1, =(0x20370C2) @put values in vars
	ldrb r2, [r1]
	strb r2, [r0] @current stage
	add r0, r0, #0x1
	add r1, r1, #0x2
	ldrh r2, [r1]
	strh r2, [r0] @time planted
	add r0, r0, #0x2
	add r1, r1, #0x2
	ldrb r2, [r1]
	strb r2, [r0] @was watered
	add r0, r0, #0x1
	add r1, r1, #0x2
	ldrb r2, [r1]
	strb r2, [r0]@times watered
	add r0, r0, #0x1
	add r1, r1, #0x2
	ldrb r2, [r1]
	strb r2, [r0]@PlantID
	pop {r0-r2, pc}
	

.align 2
.SAVEBLOCK:
	.word 0x203C000
	

