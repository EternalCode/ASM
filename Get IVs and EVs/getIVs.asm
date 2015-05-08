.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r5, lr}
	mov r4, #0x0
	
loop:
	cmp r4, #0x5
	bhi end
	ldr r0, =(0x20370C0) @var 0x8004 = slot number
	ldrb r0, [r0]
	mov r1, #0x1
	mul r1, r1, r4
	ldr r3, =(0x20370BE)
	ldrb r3, [r3]
	cmp r3, #0x0
	beq EVs
	add r1, r1, #0x27 @IV
	b continue
	
EVs:
	add r1, r1, #0x1A
	
continue:
	ldr r2, =(0x803FBE8 +1)
	bl linker
	mov r1, r0
	@get var
	ldr r2, =(0x20370C2) @using vars 0x8005-0x800A
	mov r0, #0x2
	mul r0, r0, r4
	add r2, r2, r0
	strb r1, [r2] @store IV in var
	add r4, r4, #0x1
	b loop

linker:
	bx r2
	
end:
	pop {r0-r5, pc}

.align 2