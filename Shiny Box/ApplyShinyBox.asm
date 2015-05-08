.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r1, lr}
	ldr r0, =(0x20370C0) @var 0x8004 for slot
	ldrb r0, [r0]
	mov r1, #0x64
	mul r0, r0, r1
	ldr r1, =(0x2024284) @this is for party.
	add r1, r1, r0
	add r1, r1, #0x1E
	mov r0, #0x1
	strb r1, [r0]
	pop {r0-r1, pc}	
	
.align 2
