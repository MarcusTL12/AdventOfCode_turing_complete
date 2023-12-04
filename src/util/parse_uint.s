#ifndef __parse_uint
#define __parse_uint

; Parse int from file
; input:
;   r0: offset into file
; output:
;   r0: offset to first non
;       numerical character
;   r1: parsed integer
; destroys:
;   r2
label parse_uint
    xor r1 r1 r1
    label parse_uint_loop

    ; Load byte from file
    and | i2 r0 | fil 0xff r2

    ; Check if is numeric
    jp | geq | i2 r2 '0' parse_uint_g
    return
    label parse_uint_g
    jp | leq | i2 r2 '9' parse_uint_l
    return
    label parse_uint_l

    ; Is numeric, update number
    mul | i2 r1 10 r1
    sub | i2 r2 '0' r2
    add r1 r2 r1

    ; Iterate
    add | i2 r0 1 r0
    jmp(parse_uint_loop)

#endif
