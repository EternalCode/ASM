.text
.align 2
.thumb
.thumb_func

main:
	push {r4-r5}
	mov r4, r1 @save r1 contents
	ldr r0, =  0x828
	ldr r1, = (0x806E6D0 +1) @checkflag
	bl linkerOne
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	cmp r0, #0x1
	bne end
	mov r0, #0x1 @load rest of menu manually
	ldr r1, = (0x806ED94 +1) 
	bl linkerOne
	mov r0, #0x2
	ldr r1, = (0x806ED94 +1)
	bl linkerOne
	mov r0, #0x3
	ldr r1, = (0x806ED94 +1)
	bl linkerOne
	mov r0, #0x4
	ldr r1, = (0x806ED94 +1)
	bl linkerOne
	mov r0, #0x5
	ldr r1, = (0x806ED94 +1)
	bl linkerOne
	mov r0, #0x6
	ldr r1, = (0x806ED94 +1)
	bl linkerOne
	pop {r4-r5}
	pop {r0}
	bx r0
	

end:
	pop {r4-r5}
	ldr r0, =(0x806EDDA +1) @if no party
	bx r0


linkerOne:
	bx r1
	

.align 2