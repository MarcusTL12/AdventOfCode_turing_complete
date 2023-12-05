
; Input:
;   r0: pointer to first number in file
;   r1: pointer to memory location of seeds
; Output:
;   r0: points to newline character at the end of first line
;   r1: pointer to next free memory location after seeds
; Uses:
;   r2
label parse_seeds
    mov r1 _ stk
    call(parse_uint)
    mov stk _ r2
    mov r1 _ r2 | mem
    add | i2 r2 1 r1
    and | i2 r0 | fil 0xff r2
    jp | eq | i2 r2 '\n' parse_seeds_return
    add | i2 r0 1 r0
    jmp(parse_seeds)
    label parse_seeds_return
    return
