.text
.align 2
.thumb
.thumb_func
 
main:
        ldr r4, .table
 
loop:
        ldr r2, [r4]
        cmp r2, #0x00
        beq skip
        bl linker @call table routine
        add r4, #0x4 @get next table routine
        b loop
       
skip:
        ldr r1, = 0x3004F90
        ldrb r0, [r1, #0x13]
        cmp r0, #0xFE
        bhi replacer
        add r0, #0x1
        strb r0, [r1, #0x13]
 
replacer:
        ldr r2, = (0x8013CBC + 1)
 
linker:
        bx r2
 
.align 2
 
.table:
        .word 0x8844FC0