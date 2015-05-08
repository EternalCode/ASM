.text
.align 2
.thumb
.thumb_func

@purge roamer at slot 0x8000
@Currently inserted at 08770180
@
main:
	push {r0-r7, lr}
	ldr r0, =(0x20370B8)
	ldrb r0, [r0]
	ldr r1, .ROAMERS
	sub r1, r1, #0x1
	ldrb r1, [r1]
	cmp r1, r0
	bls end @fail-safe exit to save noobs from bugging RAM
	cmp r0, r1
	beq writeLastZero
	mov r2, r1
	sub r2, r2, r0
	mov r3, #0x68
	mul r2, r2, r3 @size
	ldr r1, .ROAMERS
	mul r0, r0, r3
	add r0, r0, r1 @dest
	add r3, r3, r0
	mov r1, r3 @src
	ldr r4, =(0x8040B08 +1) @func
	bl linker
	
writeLastZero:
	ldr r0, .ROAMERS
	sub r0, r0, #0x1
	ldrb r1, [r0]
	sub r1, r1, #0x1
	mov r2, #0x68
	mul r1, r1, r2
	add r0, r0, #0x1
	add r0, r0, r1 @src
	mov r1, #0x0 @value
	mov r2, #0x68 @size
	ldr r4, =(0x81E5ED8 +1)
	bl linker
	
updateCounters:
	ldr r0, .ROAMERS
	sub r0, r0, #0x1
	ldrb r1, [r0]
	sub r1, r1, #0x1
	strb r1, [r0]
	
end:
	pop {r0-r7, pc}
	
linker:
	bx r4

.align 2

.ROAMERS:
	.word 0x203D001