.text
.align 2
.thumb
.thumb_func

@inserted currently at 08770490

main:
	push {r0-r7}
	ldr r0, =(0x20370C2)
	ldrb r0, [r0]
	cmp r0, #0xFF
	beq checkDeletion
	b end

checkDeletion:
	ldr r0, =(0x2023E8A)
	ldrb r0, [r0]
	cmp r0, #0x1 
	beq deleteRoamer @player killed roamer
	cmp r0, #0x7
	beq deleteRoamer @player captured roamer
	b end
	
deleteRoamer:
	ldr r0, =(0x20370B8)
	ldr r1, =(0x20370C4)
	ldrb r1, [r1]
	strb r1, [r0]
	ldr r0, =(0x20370C2)
	mov r1, #0x0
	strb r1, [r0]
	ldr r0, =(0x8770180 +1)
	bl linker
	
end:
	pop {r0-r7}
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	cmp r0, #0x1
	beq earlyBreak
	mov r0, r5
	ldr r1, =(0x806D600 +1)
	bx r1

earlyBreak:
	ldr r0, =(0x806D650 +1)

linker:
	bx r0
	
	
.align 2
