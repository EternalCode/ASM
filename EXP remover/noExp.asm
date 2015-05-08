.text
.align 2
.thumb
.thumb_func

@at 0X21CFA: 00 00 00 49 08 47 XX XX XX 08

main:
	push {r0-r3}
	mov r0, #0xFF
	lsl r0, r0, #0x1
	add r0, r0, #0x4
	ldr r2, =(0x806E6D0 +1) @checkflag 0xFF *0x2 + 4 = 0x202
	bl linker
	cmp r0, #0x1
	beq skip
	pop {r0-r3}
	cmp r0, #0x64
	beq noCrash
	ldr r0, =(0x8021D24 +1)
	bx r0
	
skip:
	pop {r0-r3}
	
noCrash:
	ldr r1, [r5]
	add r1, #0x53
	ldrb r0, [r1]
	ldr r2, =(0x8021D04 +1)

linker:
	bx r2
		
.align 2