.text
.align 2
.thumb
.thumb_func

@generate a roamer
@
@0x8000 = Species
@0x8001 = level
@0x8002 = Shiny (0xFF = shiny)
@0x8003 = Roamable maps pointer table's index
@Currently inserted at 08770060
@
main:
	push {r0-r7,lr}
	mov r0, #0x64 @size
	ldr r4, =(0x8002BB0 +1) @malloc
	bl linker
	mov r7,r0
	ldr r1, =(0x20370B8) @species
	ldrh r1, [r1]
	ldr r2, =(0x20370BA) @level
	ldrb r2, [r2]
	mov r3, #0x20
	ldr r4, =(0x803DA54 +1) @create
	bl linker
	mov r5, #0x0
	
GenerateIV:
	cmp r5, #0x3 @amount of perfect IV stats
	beq addRoamer
	ldr r0, =(0x20370B8)
	mov r1, #0x6
	strb r1, [r0]
	ldr r4, =(0x8770000 +1) @rand number inserted location
	bl linker
	mov r3, r0

checkFreshIV:
	mov r0, r7
	mov r1, #0x27
	add r1, r1, r3
	push {r3}
	ldr r4, =(0x803FBE8 +1)
	bl linker
	pop {r3}
	cmp r0, #0x1F
	beq GenerateIV

setIV:
	mov r0, r7
	mov r1, #0x1F
	ldr r2, =(0x20370D0)
	strb r1,[r2]
	mov r1, #0x27
	add r1, r1, r3
	ldr r4, =(0x804037C +1) @set IV 31
	bl linker
	add r5, r5, #0x1
	b GenerateIV
	
addRoamer:
	ldr r0, .ROAMERS
	sub r0, r0, #0x1
	ldrb r1, [r0]
	add r0, r0, #0x1
	mov r2, #0x68
	mul r1, r1, r2
	add r0, r0, r1 @destination
	mov r3, r0
	push {r3}
	mov r1, r7 @source
	mov r2, #0x64 @size
	ldr r4, =(0x8040B08 +1) @func
	bl linker
	mov r0,r7
	ldr r4, =(0x8002BC4 +1) @free memory
	bl linker
	pop {r3}
	add r3, #0x67
	ldr r0, =(0x20370BE)
	ldrb r1, [r0]
	strb r1, [r3]
	ldr r0, .ROAMERS
	sub r0, r0, #0x1
	ldrb r1, [r0]
	add r1, r1, #0x1
	strb r1, [r0]
	b end
	
linker:
	bx r4
	
end:
	pop {r0-r7, pc}

.align 2

.ROAMERS:
	.word 0x203D001