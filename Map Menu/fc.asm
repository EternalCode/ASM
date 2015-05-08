.text
.align 2
.thumb
.thumb_func

main:
	cmp r5, #0x0
	beq end
	push {r6}
	ldr r6, =(0x80041B8 +1)
	bl linker
	pop {r6}

end:
	add SP, SP, #0x8
	pop {r4}
	pop {r0}
	bx r0
	
linker:
	bx r6
	
	

.align 2

