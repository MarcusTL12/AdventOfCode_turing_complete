#include "../../util/defines.s"

const grid_offset 20
const numbers_offset 2
const len r3
const lx r4
const ly len
const issymb r5
const num r9
const ans r10
const n_found r11
const ptr r12
const xhold r13
const yhold r14

; Get length of file
sub | i1 | i2 0 1 r0
mov r0 | fil _ len

xor r0 r0 r0
mov | i1 grid_offset _ r1

; Read input into memory
label read_loop
    mov r0 | fil _ r1 | mem
    add | i2 r0 8 r0
    add | i2 r1 1 r1
    jp | le r0 len read_loop


mov | i1 grid_offset _ r0
xor lx lx lx

; Look for newline character to determine width of grid
label width_loop1
    mov r0 | mem _ r1
    mov | i1 8 _ r15
    label width_loop2
        add | i2 lx 1 lx
        and | i2 r1 0xff r2
        jp | eq | i2 r2 '\n' width_loop_end
        shr | i2 r1 8 r1
        sub | i2 r15 1 r15
        jp | neq | i2 r15 0 width_loop2
    add | i2 r0 1 r0
    jmp(width_loop1)
label width_loop_end

; ly = len / lx
div len lx ly

xor r1 r1 r1

; Look for *
label search_loop_y
    xor r0 r0 r0
    label search_loop_x
        mov r0 _ stk
        mov r1 _ stk
        call(get_grid)
        mov stk _ r1
        mov stk _ r0

        jp | neq | i2 r2 '*' search_loop_x_continue

        xor n_found n_found n_found
        mov | i1 numbers_offset - 1 _ ptr

        mov r0 _ xhold
        mov r1 _ yhold

        sub | i1 | i2 0 1 r1
        label sub_loop_y
            sub | i1 | i2 0 1 r0
            label sub_loop_x
                mov r0 _ stk
                mov r1 _ stk
                add xhold r0 r0
                add yhold r1 r1
                call(get_grid)
                mov stk _ r1
                mov stk _ r0

                sub | i2 r2 '0' r2
                jp | ge | i2 r2 '9' not_number

                mov r0 _ stk
                mov r1 _ stk
                add xhold r0 r0
                add yhold r1 r1
                call(find_start)

                jp | eq | i2 n_found 0 add_coords

                jp | neq r1 ptr | mem add_coords
                sub | i2 ptr 1 ptr
                mov ptr | mem _ r2
                add | i2 ptr 1 ptr
                jp | neq r0 r2 add_coords
                jmp(not_add_coords)

                label add_coords
                jp | eq | i2 n_found 2 break_subloop
                add | i2 n_found 1 n_found
                add | i2 ptr 1 ptr
                mov r0 _ ptr | mem
                add | i2 ptr 1 ptr
                mov r1 _ ptr | mem

                label not_add_coords

                mov stk _ r1
                mov stk _ r0

                label not_number

                add | i2 r0 1 r0
                jp | leq | i2 r0 1 sub_loop_x
            add | i2 r1 1 r1
            jp | leq | i2 r1 1 sub_loop_y

        jp | neq | i2 n_found 2 break_subloop

        sub | i2 ptr 3 ptr
        mov ptr | mem _ r0
        add | i2 ptr 1 ptr
        mov ptr | mem _ r1
        call(parse_number)
        mov r2 _ num

        add | i2 ptr 1 ptr
        mov ptr | mem _ r0
        add | i2 ptr 1 ptr
        mov ptr | mem _ r1
        call(parse_number)
        mul r2 num num
        add num ans ans

        label break_subloop

        mov xhold _ r0
        mov yhold _ r1

        label search_loop_x_continue
        add | i2 r0 1 r0
        jp | le r0 lx search_loop_x
    add | i2 r1 1 r1
    jp | le r1 ly search_loop_y

mov ans _ r0
xor r1 r1 r1
call(print_uint)

halt _ _ _

; Input:
;   r0: x
;   r1: y
; Output
;   r0: x_start
label find_start
    mov r0 _ stk
    mov r1 _ stk
    sub | i2 r0 1 r0
    call(get_grid)
    mov stk _ r1
    mov stk _ r0

    sub | i2 r2 '0' r2
    jp | leq | i2 r2 '9' find_start_loop
    return
    label find_start_loop
    sub | i2 r0 1 r0
    jmp(find_start)

; Input:
;   r0: x
;   r1: y
; Output
;   r2: number
label parse_number
    xor r2 r2 r2

    label parse_number_loop
        mov r2 _ stk
        mov r0 _ stk
        mov r1 _ stk
        call(get_grid)
        mov stk _ r1
        mov stk _ r0
        mov r2 _ ovf
        mov stk _ r2

        sub | i2 ovf '0' ovf
        jp | leq | i2 ovf '9' parse_loop_continue
        return
        label parse_loop_continue
        add | i2 r0 1 r0
        mul | i2 r2 10 r2
        add r2 ovf r2
        jmp(parse_number_loop)


#include "get_grid.s"

#include "../../util/print_uint.s"
