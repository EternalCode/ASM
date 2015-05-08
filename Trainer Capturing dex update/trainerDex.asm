.text
.align 2
.thumb
.thumb_func	

main:
	push {r0-r2}
	ldr r2, .OpponentID
	ldr r2, [r2]
	mov r4, #0x0
	
loop:
	cmp r4, #0x5
	beq default
	ldr r0, .OpponentParty
	mov r1, #0x64
	mul r1, r1, r4
	add r0, r0, r1
	mov r1, r0
	ldr r0, [r0]
	cmp r0, r2
	beq writeSlot
	add r4, r4, #0x1
	b loop
	
default:
	ldr r1, .OpponentParty

writeSlot:
	mov r4, r1
	mov r0, r4
	mov r1, #0xB
	mov r2, #0x0
	push {r3}
	ldr r3, =(0x803FBE8 +1)
	bl linker
	pop {r3}
	mov r5, r0
	pop {r0-r2}
	ldr r0, =(0x802D96E +1)
	bx r0
	
	
linker:
	bx r3
	
	
.align 2

.OpponentID:
	.word 0x2023C84

.OpponentParty:
	.word 0x202402C
