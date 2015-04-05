.text
.align 2
.thumb
.thumb_func

main:
	push {lr}
	ldr r1, =(0x3005024) @Phase 1
	ldr r0, =(0x81248B0 +1) @launch pase 2
	str r0, [r1]
	ldr r1, =(0x203B0C4) @Phase 2
	ldr r0, =(0x87FEFC1) @Script launcher
	str r0, [r1]
	mov r0, #0x1
	pop {r1}
	bx r1
	
.align 2