.text
.align 2
.thumb
.thumb_func

@follow me script

@Follower Data: [ROM ID] [ROM Map num] [ROM Map bank] [Logged movement] 4 bytes

@apply logged movement follower if current movement loggable and non-zero
@log current player movement 031-044, 08-020
@continue

main:
	mov r1, r5
	push {r4-r7}
	mov r6, r0
	mov r7, r1

checkPlayerIsMoving:
	mov r0, r7
	bl checkValidMovement
	cmp r0, #0x1
	bne end
	
applyMovementFollower:
	ldr r4, =(0x203BFFA) @follower-data
	ldr r1, [r4]
	cmp r1, #0x0 @case no follower
	beq end
	ldr r5, =(0x203BFF9)
	ldrb r5, [r5]
	cmp r5, #0x0
	bne blehend
	ldrb r1, [r4] @ROM ID follower
	ldr r0, =(0x2036E38 + 0x8)
	
loop:
	ldrb r2, [r0]
	cmp r2, r1
	beq applymovelocalnpc
	add r0, r0, #0x24
	b loop
	
applymovelocalnpc:
	sub r0, r0, #0x8
	ldrb r1, [r4, #0x3]
	cmp r1, #0x15
	beq logPlayerMovement
	cmp r1, #0x16
	beq logPlayerMovement
	cmp r1, #0x17
	beq logPlayerMovement
	cmp r1, #0x14
	beq logPlayerMovement
	push {r4}
	mov r4, r0
	mov r0, r7 
	bl genCMD
	mov r1, r0
	mov r0, r4
	pop {r4}
	
logPlayerMovement:
	strb r7, [r4, #0x3]
	b doMovement
	
doMovement:
	push {r1}
	mov r4, r0
	ldr r5, =(0x805B4B0 +1)
	bl linker
	mov r0, r4
	ldr r5, =(0x8063D34 +1)
	bl linker
	mov r0, r4
	pop {r1}
	mov r4, r1
	ldr r5, =(0x8063CA4 +1)
	bl linker
	
end:
	mov r0, r6
	mov r1, r7
	mov r2, r4
	pop {r4-r7}
	mov r4, r5
	push {r2}
	ldr r5, =(0x8063CA4 +1)
	bl linker
	pop {r2}
	cmp r2, #0x14
	beq altEnd
	mov r0, r4
	ldr r5, =(0x805C05A +1)
	b linker
	
altEnd:
	ldr r0, =(0x87FFC80 +1)
	mov r1, #0x1
	ldr r5, =(0x807741C +1)
	bl linker
	pop {r4-r5}
	pop {pc}

contEnd:
	add r4, r4, #0x1
	strb r4, [r0]
		
blehend:
	pop {r4-r7}
	ldr r5, =(0x805C05E +1)
	
linker:
	bx r5


@r0 = player's current movement cmd
@r1 = logged last movement cmd

genCMD:
	push {r4-r7, lr}
	mov r6, r0
	mov r7, r1
	ldr r2, =(0x20370C0)
	strh r1, [r2]
	cmp r7, #0x4E
	bge defcmd
	@if player is jumping or sliding we default to running speed
	cmp r0, #0x14
	beq highSpeed
	cmp r0, #0x15
	beq highSpeed
	cmp r0, #0x16
	beq highSpeed
	cmp r0, #0x17
	beq highSpeed
	cmp r0, #0x31 @sliding
	bge highSpeed
	bl getSpeed 	@get player's current movement's speed
	mov r4, r0
	b normMove
	
defcmd:
	mov r0, r7
	pop {r4-r7, pc}
	
highSpeed:
	mov r4, #0x3
	
normMove:
	mov r0, r7
	bl getDir		@get follower's movement direction
	@make movement cmd given direction and speed
	mov r1, r4
	bl makeMove
	pop {r4-r7, pc}
	
makeMove:
	push {r4-r5, lr}
	mov r4, r0 @dir
	mov r5, r1 @speed
	mov r0, r7
	bl getSpeed
	cmp r0, r5
	beq defMove
	mov r1, r5
	mov r0, r4
	
	cmp r1, #0x3
	beq ffast
	cmp r1, #0x2
	beq nnorm
		
sslow:
	cmp r0, #0x1
	beq slow_walk_up
	cmp r0, #0x2
	beq slow_walk_left
	cmp r0, #0x3
	beq slow_walk_right
	mov r0, #0x8
	b endMove

nnorm:
	cmp r0, #0x1
	beq walk_up
	cmp r0, #0x2
	beq walk_left
	cmp r0, #0x3
	beq walk_right
	mov r0, #0x10
	b endMove

ffast:
	cmp r0, #0x1
	beq fast_walk_up
	cmp r0, #0x2
	beq fast_walk_left
	cmp r0, #0x3
	beq fast_walk_right
	mov r0, #0x1D
	b endMove

defMove:
	mov r0, r7
	b endMove
	
slow_walk_left:
	mov r0, #0xA
	b endMove

slow_walk_up:
	mov r0, #0x9
	b endMove

slow_walk_right:
	mov r0, #0xB
	b endMove

walk_left:
	mov r0, #0x12
	b endMove

walk_right:
	mov r0, #0x13
	b endMove

walk_up:
	mov r0, #0x11
	b endMove

fast_walk_left:
	mov r0, #0x1F
	b endMove

fast_walk_right:
	mov r0, #0x20
	b endMove

fast_walk_up:
	mov r0, #0x1E
	
endMove:
	pop {r4-r5, pc}
	
getDir:
	push {lr}
	cmp r0, #0x8
	beq down
	cmp r0, #0xC
	beq down
	cmp r0, #0x10
	beq down
	cmp r0, #0x1D
	beq down
	cmp r0, #0x3D
	beq down
	cmp r0, #0x41
	beq down
	cmp r0, #0x31
	beq up

	cmp r0, #0x9
	beq up
	cmp r0, #0xD
	beq up
	cmp r0, #0x11
	beq up
	cmp r0, #0x1E
	beq up
	cmp r0, #0x3E
	beq up
	cmp r0, #0x42
	beq up
	cmp r0, #0x32
	beq up

	cmp r0, #0xA
	beq left
	cmp r0, #0xE
	beq left
	cmp r0, #0x12
	beq left
	cmp r0, #0x1F
	beq left
	cmp r0, #0x43
	beq left
	cmp r0, #0x3F
	beq left
	cmp r0, #0x33
	beq left
	
	cmp r0, #0x34
	beq right
	cmp r0, #0xB
	beq right
	cmp r0, #0xF
	beq right
	cmp r0, #0x13
	beq right
	cmp r0, #0x20
	beq right
	cmp r0, #0x44
	beq right 
	
right:
	mov r0, #0x3
	b dirEnd
	
up:
	mov r0, #0x1
	b dirEnd
	
left:
	mov r0, #0x2
	b dirEnd

down:
	mov r0, #0x4
	b dirEnd
	
nomovement:
	mov r0, #0x5

	
dirEnd:
	pop {pc}
	
getSpeed:
	push {lr}
	cmp r0, #0x14
	bge fast
	cmp r0, #0x10
	bge norm
	cmp r0, #0x8
	bge slow
	mov r0, #0x0
	b endSpeed
	
slow:
	mov r0, #0x1
	b endSpeed
	
norm:
	mov r0, #0x2
	b endSpeed
	
fast:
	mov r0, #0x3
	
endSpeed:
	pop {pc}

	
checkValidMovement:
	push {lr}
	cmp r0, #0x4
	ble noMove
	cmp r0, #0x4E
	bge valMove
	cmp r0, #0x31
	bge valMove
	cmp r0, #0x20
	ble valMove
	
noMove:
	mov r0, #0x0
	b moveEnd
	
valMove:
	mov r0, #0x1
	
moveEnd:
	pop {pc}
	
.align 2
