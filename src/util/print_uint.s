#ifndef __print_uint
#define __print_uint

; Print uint to terminal
; Input:
;   r0: int to print
;   r1: byte offset in mem
;
; Uses:
;   r0: buffer
;   r2: num digits left
;   r1: int offset in mem
;   r3: byte offset in int
label print_uint

    xor r2 r2 r2
    label print_uint_loop1
    div | cy | i2 r0 10 r0
    add | i2 ovf '0' stk
    add | i1 1 r2 r2
    jp | neq | i2 r0 0 print_uint_loop1

    div | cy | i2 r1 8 r1
    shl | i2 ovf 3 r3

    label print_uint_loop2
    jp | neq | i2 r2 0 print_uint_noreturn
    return
    label print_uint_noreturn

    shl stk r3 r0
    or r0 r1 | mem r1 | mem
    sub | i2 r2 1 r2

    add | i2 r3 8 r3
    jp | le | i2 r3 64 print_uint_loop2

    xor r3 r3 r3
    add | i2 r1 1 r1
    jmp(print_uint_loop2)

#endif
