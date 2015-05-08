.text
.align 2
.thumb
.thumb_func
 
@81FFC0 
main:
	ldr r0, =(0x20370BE)
	ldrh r1, [r0]
	mov r2, #0xFF
	add r2, r2, #0x28
	cmp r1, r2
	beq delTask
	add r1, r1, #0x1
	strh r1, [r0]
	ldr r0, =(0x300311E)
	ldrb r0, [r0]	
	lsr r0, r0, #0x1
	bcs delTask
	bx lr
       
delTask:
	push {lr}
	push {r1-r2}
	ldr r0, =(0x8820000 +1) @where I plan to insert this
	ldr r1, =(0x8077688 +1) @task-find_id_by_funcptr
	bl linker
	pop {r1-r2}	
	cmp r1, r2
	bge failed
	pop {pc}

failed:
	ldr r0, =(0x3005138)
	mov r1, #0xC
	strb r1, [r0]
	pop {pc}
	

linker:
	bx r1
	
linkerOne:
	bx r0
 
.align 2