.text
.align 2
.thumb
.thumb_func


main:
	push {r0-r4, lr}
	ldr r0, =(0x2024284)
	mov r1, #0xB
	ldr r3, =(0x803FBE8 +1) @get species
	bl linker

getSpeciesBaseStats:
	ldr r2, .BaseStatTable
	mov r1, #0x1C
	mul r1, r1, r0 
	add r2, r2, r1 @base stats table for species

checkAbility:
	mov r0, r4 @slot
	mov r4, r2 @save base stats table for species
	mov r1, #0x2E
	ldr r3, =(0x803FBE8 +1) @get ability bit of Pokemon in slot specified by 0x8004
	bl linker

getAbility:
	add r0, r0, #0x16 @first ability location + ability bit = ability number
	add r4, r4, r0 @this is the ability number
	ldrb r1, [r4]
	cmp r1, #0x0
	bne setReturn
	
firstAbility:
	sub r4, r4, #0x1
	
setReturn:
	ldr r1, =(0x20370B8)
	ldrb r4, [r4]
	strb r4, [r1]

end:
	pop {r0-r4, pc}
	

linker:
	bx r3

.align 2

.BaseStatTable:
	.word 0x8254784

.AbilityNames:
	.word 0x824FC40