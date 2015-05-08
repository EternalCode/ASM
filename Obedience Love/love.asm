.text
.align 2
.thumb
.thumb_func

@insert at 0x801D3E0
main:
	mov r4, #0x82
	lsl r4, r4, #0x4
	mov r2, #0x0

badgeLoop:
	mov r0, r4
	ldr r6, =(0x806E6D0 +1)
	bl linkerOne
	cmp r0, #0x1
	bne trainLevel
	add r4, r4, #0x1
	add r2, r2, #0x1
	cmp r2, #0x8
	beq obey
	b badgeLoop

trainLevel:
	@no flags set = lvl 20. Increment by 10 per additional flag
	mov r0, #0xA
	mov r2, #0x82
	lsl r2, r2, #0x4
	sub r4, r4, r2
	mul r4, r4, r0
	add r4, #0x14

PokemonLevel:
	ldrh r0, [r5]
	mul r0, r7
	ldr r6, = (0x2024284)
	add r0, r0, r6
	mov r1, #0x38
	ldr r6, = (0x803FBE8 +1)
	bl linkerOne
	cmp r0, r4
	ble obey
	


isHappy:
	@if it loves you and you don't have badges, it will obey
	@if it doesn't love you and you don't have badges it will disobey
	ldrh r0, [r5]
	mul r0, r7
	ldr r6, = (0x2024284)
	add r0, r0, r6
	mov r1, #0x20
	ldr r6, =(0x803FBE8 +1)
	bl linkerOne
	cmp r0, #0x7F @this is half possible of max happiness tone to your liking
	bls disobey

obey:
	mov r0, #0x1
	b end
	

disobey:
	ldr r0, =(0x801D414 +1) @you can simply mov r0 to 0x0 too
	bx r0

end:
	mov r2, #0x0
	ldr r1, =(0x801D42A +1)
	bx r1


linkerOne:
	bx r6
	
	

.align 2
