.text
.align 2
.thumb
.thumb_func

main:
	ldr r4, .Var
	ldrb r4, [r4]
	cmp r4, #0x0
	beq Normal
	b end

Normal:
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10

end:
	lsl r1, r1, #0x18
	lsr r3, r1, #0x18
	ldr r0, =(0x20244DC)
	ldr r5, = (0x803F870 +1)
	bx r5
	

.align 2

.Var:
	.word 0x20370B8 @0x8000
