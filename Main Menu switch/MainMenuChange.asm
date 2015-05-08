.text
.align 2
.thumb
.thumb_func

main:
	mov r0, #0x94 @flag 0x250 divided by 4 (change if you want)
	lsl r0, #0x2
	ldr r1, =(0x806E6D0 +1)
	bl linker
	cmp r0, #0x0
	bne showMine

end:
	mov r0, #0x1
	ldr r1, =(0x806ED70 +1)
	bx r1
 
showMine:
	ldr r0, =(0x806EE34 +1)
	bl linker2
	pop {r0}
	bx r0
 
linker2:
	bx r0
 
linker:
	bx r1

.align 2