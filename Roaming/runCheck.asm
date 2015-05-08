.text
.align 2
.thumb
.thumb_func

@inserted at 08770370

main:
	push {r0-r5, lr}
	ldr r0, =(0x20370C2) @toggled by var 0x8005 == 0xFF 
	ldrb r1, [r0]
	cmp r1, #0xFF
	bne end

fleeChecks:
	ldr r0, =(0x2023D68) @Player is attacking
	ldrb r0, [r0]
	cmp r0, #0x0
	beq end
	ldr r0, =(0x2023D6B) @check player's Pokemon's turn to attack
	ldrb r0, [r0]
	cmp r0, #0x0
	beq end

@wild Pokemon's turn to go

trapCheck:
	ldr r0, =(0x2023C8F) @moves preventing fleeing
	ldrb r0, [r0]
	cmp r0, #0x4
	bls durationMoveCheck
	
trapCheckTwo:
	cmp r0, #0x7
	ble end	

durationMoveCheck:
	ldr r0, =(0x2023C8D) @duration of a move active on target
	ldrb r0, [r0]
	cmp r0, #0x0
	bne end
	
abilityCheck:	
	ldr r0, =(0x2023C04) @ability of player's Pokemon
	ldrb r0, [r0]
	cmp r0, #0x17 @shadow trap
	beq end
	cmp r0, #0x47 @arena trap
	bne magnetRise
	ldr r1, =(0x2023C5D)
	ldrb r2, [r1]
	cmp r2, #0x2 @flying type
	beq magnetRise
	add r1, r1, #0x1
	ldrb r1, [r1]
	cmp r1, #0x2 @secondary flying type
	beq magnetRise
	ldr r1, =(0x2023C5C)
	ldrb r1, [r1]
	cmp r1, #0x1A @levitate
	bne end

magnetRise:
	cmp r0, #0x2A @magnet pull, check if steel type
	bne runAway

checkTypeSteel:
	ldr r0, =(0x2023C5D)
	ldrb r1, [r0]
	cmp r1, #0x8
	beq end
	add r0, r0, #0x1
	ldrb r0, [r0]
	cmp r0, #0x8
	beq end
	
runAway:
	ldr r0, =(0x2023E8A)
	mov r1, #0x6
	strb r1, [r0]

saveState:
	ldr r0, .ROAMERS
	add r0, r0, #0x1
	ldr r1, =(0x20370C4)
	ldrb r1, [r1]
	mov r2, #0x68
	mul r1, r1, r2
	add r0, r0, r1 @dest
	mov r4, r0
	ldr r1, =(0x202402C) @src
	mov r2, #0x64 @size
	ldr r3, =(0x8040B08 +1) @func
	bl linker
	
changeRoamingLocation:
	mov r0, r4
	add r0, r0, #0x67
	ldrb r1, [r0] @map pointers table index
	ldr r2, .TABLE
	lsl r1, r1, #0x2
	add r2, r2, r1
	add r2, r2, #0x1 @pointer to roamable maps data
	ldr r1, [r2] @data
	ldrb r2, [r1] @amount of maps
	ldr r3, =(0x20370BB8)
	strb r2, [r5]
	push {r0-r4}
	ldr r3, =(0x8770000 +1) @random function
	bl linker
	mov r5, r0
	pop {r0-r4}
	lsl r5, r5, #0x1
	add r1, r1, #0x1
	add r5, r5, r1 @map to set to
	sub r0, r0, #0x2
	ldrh r5, [r5]
	strh r5, [r0] @update roaming maps	
	
end:
	pop {r0-r5, pc}

linker:
	bx r3

.align 2

.ROAMERS:
	.word 0x203D000

.TABLE:
	.word 0x87FFFFF