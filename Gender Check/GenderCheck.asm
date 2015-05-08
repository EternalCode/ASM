.text
.align 2
.thumb
.thumb_func

@Genderless = 0
@Female = 1
@Male = 2

main:
	push {r0-r4, lr}
	ldr r0, =(0x20370C0)
	ldrb r0, [r0]
	mov r1, #0x64
	mul r1, r1, r0
	ldr r0, =(0x2024284)
	add r0, r0, r1 @slot
	mov r4, r0

getGender:
	mov r1, #0xB
	ldr r2, =(0x803FBE8 +1) @get species
	bl linker
	mov r2, r0 @species
	push {r2}
	mov r0, r4
	mov r1, #0x0
	ldr r2, =(0x803FBE8 +1) @get PID
	bl linker
	pop {r2}
	mov r1, r0 @PID
	mov r0, r2 @species
	ldr r2, =(0x803F78C +1)
	bl linker

fixReturn:
	ldr r1, =(0x20370B8)
	mov r2, #0xFF
	sub r0, r2, r0
	cmp r0, r2
	bne store
	mov r0, #0x2
	
store:
	strb r0, [r1]
	pop {r0-r4, pc}

linker:
	bx r2

.align 2