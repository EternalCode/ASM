.text
.align 2
.thumb
.thumb_func


main:
	push {r0-r6, lr}
	ldr r0, =(0x20370B8) @slot of pkmn to modify
	ldrb r1, [r0]
	mov r2, #0x64
	mul r1, r1, r2
	ldr r0, =(0x2024284)
	add r0, r0, r1	
	mov r6, r0
	ldr r2, .trainerData @table to trainer data
	ldr r0, =(0x20370BA) @var 0x8001 = trainer's ID
	ldrb r0, [r0]
	sub r0, r0, #0x1
	mov r1, #0x28
	mul r1, r1, r0
	add r2, r2, r1 @pointer to trainer's name
	mov r4, r2
	mov r0, r6 @pokemon
	mov r1, #0x7
	ldr r3, =(0x804037C +1) @set OT name
	bl linker
	mov r0, r6 @pokemon
	mov r2, r4
	sub r2, r2, #0x1 @gender byte
	lsl r2, r2, #0x18
	lsr r2, r2, #0x1F @Isolate first bit on the last byte, which is gender
	mov r1, #0x31
	ldr r3, =(0x804037C +1) @set OT gender
	bl linker
	pop {r0-r6, pc}
	

linker:
	bx r3

.align 2

.battleType:
	.word 0x2022B4C

.trainerData:
	.word 0x823EAF4
