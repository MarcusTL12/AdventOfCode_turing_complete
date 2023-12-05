
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

; Input:
;   r0: pointer to start of first map in file
;   r1: pointer to memory location of maps
; Output:
;   r1: pointer to next free memory location after seeds
; Uses:
;   r2, r3, r4
label parse_maps
    label parse_maps_look_for_newline_loop
        add | i2 r0 1 r0
        and | i2 r0 | fil 0xff r2
        jp | neq | i2 r2 '\n' parse_maps_look_for_newline_loop

    ; We now point to character before first number in map
    ; Parse numbers into memory until double newline

    mov r1 _ r4
    mov | i1 0 _ r4 | mem
    add | i2 r1 1 r3

    label parse_maps_main_loop
        add | i2 r0 1 r0
        call(parse_uint)
        mov r1 _ r3 | mem
        add | i2 r4 | mem 1 r4 | mem
        add | i2 r3 | r3
        and | i2 r0 | fil 0xffff r1
        jp | neq | i2 r1 "\n\n" parse_maps_main_loop

    mov r3 _ r1
    add | i2 r0 2 r0
    jp | eq | i2 r0 | fil 0 parse_maps
    return
