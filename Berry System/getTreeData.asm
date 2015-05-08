.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r2, lr}
	ldr r0, =(0x20370D0)@get tree data
	ldrh r0, [r0]
	ldr r1, .SAVEBLOCK
	mov r2, #0x6
	mul r0, r0, r6
	add r0, r0, r1
	ldr r1, =(0x20370C2) @put values in vars
	ldrb r2, [r0]
	strb r2, [r1] @current stage
	add r0, r0, #0x1
	add r1, r1, #0x2
	ldrh r2, [r0]
	strh r2, [r1] @time planted
	add r0, r0, #0x2
	add r1, r1, #0x2
	ldrb r2, [r0]
	strb r2, [r1] @was watered
	add r0, r0, #0x1
	add r1, r1, #0x2
	ldrb r2, [r0]
	strb r2, [r1]@times watered
	add r0, r0, #0x1
	add r1, r1, #0x2
	ldrb r2, [r0]
	strb r2, [r1]@PlantID

updateStage:
	@check time passed and update
	ldr r1, = (0x300500C)
	ldrh r2, [r1, #0xE] @hours
	mov r3, #0x3C
	mul r2, r2, r3
	ldrb r3, [r1, #0x10]@minutes
	add r2, r2, r3 @current time in minutes
	ldr r3, =(0x20370C4)
	ldrh r3, [r3]
	sub r2, r2, r3
	mov r3, #0x0
	mov r1, #0x20

loop:
	cmp r1, r2
	blo setWater
	lsl r1, r1, #0x1
	add r3, r3, #0x1
	b loop
	
setWater:
	ldr r1, =(0x20370C2)
	ldrh r1, [r1]
	cmp r3, r2
	ble end
	ldr r2, =(0x20370C2)
	strb r3, [r2]
	ldr r2, =(0x20370C6)
	mov r3, #0x0
	strb r3, [r2]
	pop {r0-r2, pc}
	

.align 2
.SAVEBLOCK:
	.word 0x203C000
	

