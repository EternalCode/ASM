.text
.align 2
.thumb
.thumb_func

main:
	mov r3, #0x0
	mov r5, r3
	b loop

loop:
	cmp r3, #0x6
	bge end
	ldr r0, =(0x202402C)
	mov r1, #0x64
	mul r1, r1, r3
	add r0, r0, r1
	mov r1, #0x39
	ldr r4, =(0x803FBE8 +1)
	bl linkFour
	cmp r0,  #0x0
	bne increment
	add r3, r3, #0x1
	b loop

increment:
	add r5, r5, #0x1
	ldr r0, =(0x202402C)
	mov r1, #0x64
	mul r1, r1, r3
	add r0, r0, r1
	mov r2, r0
	add r3, r3, #0x1
	b loop

end:
	cmp r5, #0x1
	bne skip
	mov r0, r2
	mov r5, r0
	mov r1, #0x39
	ldr r2, =(0x803FBE8 + 1) @get current health
	bl linkerTwo
	mov r4, r0 @r4 = currentHP
	mov r0, r5
	mov r1, #0x3A
	ldr r2, =(0x803FBE8 + 1) @get max health
	bl linkerTwo
	sub r0, r0, r4
	@cmp r0, r4
	@bge skip @if more than half, no text display

SlideAndText:
	@slide trainer (copied like you said touched
	ldr  r5, =(0x2023BC4) @b_active_side
	ldrb r1, [r5]
	mov r0, r4
	push {r3}
	ldr r3, =(0x8034750 +1)
	bl linkThree
	pop {r3}
	ldrb r0, [r5]  @ a1
	push {r3}
	ldr r3, =(0x80751D8 +1) @battle_get_per_side_status
	bl linkThree
	pop {r3}
	mov r1, r0
	lsl r1, r1, #0x18
	lsr r1, r1, #0x18
	mov r0, r4
	ldr r5, =(0x803F864 +1) @template_build_for_pokemon_or_trainer
	bl linkFive
	ldr  r5, =(0x2023BC4) @b_active_side - putting it back in r5
	ldr  r6, = (0x20244DC) @objt_pokemon
	mov  r8, r7
	ldr  r0, =dword_8239F8C
	lsl r4, r4, #2
	add r4, r4, r0
	ldrb r0, [r4]
	mov r4, #8
	sub r4, r4, r0
	lsl r4, r4, #0x12
	mov r0, #0x5
	lsl r0, #0x14
	add r4, r4, r0
	asr   r4, r4, #0x10
	ldrb r0, [r5]
	ldr r3, =(0x807685C +1)
	bl linkThree
	mov r3, r0
	lsl r3, r3, #0x18
	lsr r3, r3, #0x18
	mov r0, r6    @ Make an instance of the trainer
	mov  r1, r8
	mov r2, r4
	push {r5}
	ldr r5, =(0x8006F8C +1) @template_instanciate_forward_search
	bl linkFive
	pop {r5}
	@make trainer show up now???

skip:
	ldr r1, = 0x3004F90
	ldrb r0, [r1, #0x13]
	cmp r0, #0xFE
	bhi replacer
	add r0, #0x1
	strb r0, [r1, #0x13]

replacer:
	ldr r2, = (0x8013CBC + 1)

linkerTwo:
	bx r2

linkerOne:
	bx r1

linkThree:
	bx r3

linkEight:
	bx r8

linkFive:
	bx r5

linkFour:
	bx r4



.align 2
