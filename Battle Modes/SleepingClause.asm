.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r3,lr}
	mov r2, #0x0 @pokemon counter
	mov r3, #0x0 @sleeping counter

loop:
	cmp r2, #0x5
	beq validateBattle
	ldr r0, =(0x202402C + 0x50)
	mov r1, #0x64
	mul r1, r1, r2
	add r0, r0, r1
	ldrb r0, [r0]
	lsl r0, r0, #0x5
	lsr r0, r0, #0x5
	cmp r0, #0x0 @check sleeping
	beq next
	add r3, r3, #0x1
next:
	add r2, r2, #0x1
	b loop

validateBattle:
	cmp r3, #0x1 @check amount sleeping <=1
	ble end
	ldr r0, =(0x2023E8A)
	mov r1, #0x5
	strb r1, [r0]	

end:
	pop {r0-r3, pc}
	
	
.align 2
