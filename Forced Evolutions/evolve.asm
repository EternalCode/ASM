.text
.align 2
.thumb
.thumb_func

main:
	push {r0-r7, lr}
	ldr r0, .SLOT
	ldrh r0, [r0]
	mov r1, #0x64
	mul r0, r0, r1
	ldr r1, =(0x2024284)
	add r0, r0, r1
	mov r7, r0
	mov r1, #0xB
	ldr r3, =(0x803FBE8 +1)
	bl linker
	mov r5, r0
	bl getEvolvedForm
	mov r6, r0
	mov r0, r7
	mov r1, #0x38
	ldr r3, =(0x803FBE8 +1)
	bl linker
	mov r4, r0

SetEvolve:
	mov r0, r7
	ldr r2, .VAR
	mov r1, r6
	strh r1, [r2]
	mov r1, #0xB
	ldr r3, =(0x804037C +1)
	bl linker
	mov r0, r7
	ldr r3, =(0x803E47C +1)
	bl linker

AddToDex:
	mov r0, r6
	ldr r3, =(0x8043298 +1)
	bl linker
	mov r0, r6
	mov r1, #0x2
	ldr r3, =(0x8088E74 +1)
	bl linker
	mov r0, r6
	mov r1, #0x3
	ldr r3, =(0x8088E74 +1)
	bl linker

FinishCalc:
	mov r0, r7
	mov r1, #0x38
	ldr r3, =(0x803FBE8 +1)
	bl linker
	cmp r0, r4
	bne AdjustLvl
	b Nickname

getEvolvedForm:
	mov r1, #0x4
	mul r1, r1, r0
	add r0, r0, r1
	lsl r0, r0, #0x03
	ldr r3, = (0x8259754)
	add r1, r0, r3
	ldrh r0, [r1, #0x2]
	ldrh r2, [r1, #0x4]
	cmp r0, r2
	bgt setter
	bx lr

setter:
	mov r0, r2
	bx lr

Nickname:
	mov r0, r7
	ldr r1, =(0x2021CD0)
	mov r2, r1
	mov r1, #0x2
	ldr r3, =(0x803FBE8 +1)
	bl linker
	ldr r0, =(0x8245EE0)@speciesName
	mov r1, #0xB
	mul r1, r1, r5
	add r1, r1, r0
	mov r5, r1
	ldr r1, =(0x2021CD0)
	mov r4, r1
	mov r0, #0x0
	
checkEqual:
	cmp r0, #0xA
	beq setName
	add r5, r5, #0x1
	ldrb r1, [r5]
	add r4, r4, #0x1
	ldrb r2, [r4]
	cmp r2, r1
	bne end
	cmp r2, #0xFF
	beq checkOne
	b contLoop

checkOne:
	cmp r1, #0xFF
	beq setName
	b end

contLoop:
	add r0, r0, #0x1
	b checkEqual

setName:
	ldr r2, =(0x8245EE0)
	mov r0, #0xB
	mul r6, r6, r0
	add r6, r6, r2
	mov r0, r7
	mov r2, r6
	mov r1, #0x2
	ldr r3, =(0x804037C +1)
	bl linker
	b end

random:
	b end
	
	
AdjustLvl:
	cmp r0, r4
	beq Nickname
	mov r2, r0
	mov r0, r7
	mov r1, #0x19
	ldr r3, =(0x803FBE8 +1)
	bl linker
	mov r1, r0
	lsr r0, #0x4
	cmp r2, r4
	bls subtract
	add r1, r1, r0
	b updateExp
	
subtract:
	sub r1, r1, r0

updateExp:
	ldr r2, .VAR
	str r1, [r2]
	mov r1, #0x19
	mov r0, r7
	ldr r3, =(0x804037C +1)
	bl linker
	mov r0, r7
	ldr r3, =(0x803E47C +1)
	bl linker
	mov r0, r7
	mov r1, #0x38
	ldr r3, =(0x803FBE8 +1)
	bl linker
	b AdjustLvl


end:
	pop {r0-r7, pc}
	
 
linker:
	bx r3
	

.align 2

.VAR:
	.word 0x020270B8 + (0x8000 *2)
.SLOT:
	.word 0x020270B8 + (0x8001 *2)
 