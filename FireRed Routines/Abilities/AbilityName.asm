.text
.align 2
.thumb
.thumb_func


main:
	push {r0-r4, lr}
	ldr r1, =(0x20370C0) @var 0x8004
	ldrb r1, [r1]
	mov r2, #0x64
	mul r1, r1, r2
	ldr r0, =(0x2024284)
	add r0, r0, r1 @slot
	mov r4, r0 @save slot
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
	bne getAbilityName  @if it has a second ability (not null)
	@we will retrieve it's name, else retrieve 1st ability
	
firstAbility:
	sub r4, r4, #0x1

getAbilityName:
	ldrb r4, [r4]
	ldr r0, .AbilityNames
	mov r1, #0xD
	mul r1, r1, r4
	add r0, r0, r1 @ability's name pointer
	mov r1, #0x0

	
writeToBuffer:
	cmp r1, #0xD
	beq end
	mov r4, r0
	add r4, r4, r1
	ldrb r4, [r4] @char
	ldr r3, =(0x2021D18) @location to store string	
	add r3, r3, r1
	strb r4, [r3] @append char to buffer
	add r1, r1, #0x1
	b writeToBuffer

end:
	pop {r0-r4, pc}
	

linker:
	bx r3

.align 2

.BaseStatTable:
	.word 0x8254784

.AbilityNames:
	.word 0x824FC40