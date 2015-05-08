.text
.align 2
.thumb
.thumb_func

main:
	ldr r0, .Ball
	ldrb r0, [r0]
	cmp r0, #0x1 @masterball
	beq capture
	mov r0, #0x0
	mov r1, #0x5
	ldr r3, =(0x800E194 +1)
	bl linker
	ldr r0, =(0x802D4A0 +1)
	bx r0

capture:
	ldr r0, =(0x802D4B4 +1)
	bx r0

linker:
	bx r3
	
.align 2

.Ball:
	.word 0x2023D68