.text
.align 2
.thumb
.thumb_func

@hook from 0805CA4C via r0
                            
main:
	@flag check
checkFlag:
	mov r0, #0xFF 
	lsl r0, r0, #0x2
	add r0, r0, #0xA @0x3FC + 0xA = @406
	ldr r2, =(0x806E6D0 +1)
	push {r1, r3}
	bl linker
	pop {r1, r3}
	cmp r0, #0x1
	bne noCrash

setOW:
	ldr r0, =(0x20370B8)
	ldrb r0, [r0]
	cmp r0, #0xFF
	beq noCrash
	mov r3, r0
	
noCrash:
	mov r8, r3
	lsl r4, r4, #0x10
	lsr r4, r4, #0x10
	lsl r5, r5, #0x10
	ldr r0, =(0x805CA54 +1)
	bx r0
	
linker:
	bx r2
	
.align 2
