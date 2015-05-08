.text
.align 2
.thumb_func
 
@ Assemble into free space and then
@ At 080CA840: 00 48 00 47 (POINTER_TO_HERE + 1)
 
main:
    ldr r2, .VAR
    ldrb r2, [r2]
 
    ldrb r0, [r1, #6] @ Type 1
    cmp r0, r2
    beq is_type
    ldrb r0, [r1, #7] @ Type 2
    cmp r0, r2
    bne not_type
   
is_type:
    mov r0, r5
    pop {r4-r6}
    pop {r1}
    bx r1
   
not_type:
    ldr r0, =(0x80CA858 + 1)
    bx r0

.align 2
.VAR:
	.word 0x020270B8 + (0x8000 * 2)