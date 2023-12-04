#include "../../util/defines.s"

const grid_offset 20
const len r3
const lx r4
const ly len
const issymb r5
const num r9
const ans r10

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

; Look for start of number
label search_loop_y
    xor r0 r0 r0
    label search_loop_x
        mov r0 _ stk
        mov r1 _ stk
        call(get_grid)
        mov stk _ r1
        mov stk _ r0

        sub | i2 r2 '0' r2
        jp | leq | i2 r2 '9' parse_init
        jmp(search_loop_x_continue)

        label search_loop_return

        jp | eq | i2 issymb 1 search_loop_has_symb

        mov r0 _ stk
        mov r1 _ stk
        call(get_grid)
        mov stk _ r1
        mov stk _ r0
        jp | neq | i2 r2 '.' search_loop_has_symb

        mov r0 _ stk
        mov r1 _ stk
        sub | i2 r1 1 r1
        call(get_grid)
        mov stk _ r1
        mov stk _ r0
        jp | neq | i2 r2 '.' search_loop_has_symb

        mov r0 _ stk
        mov r1 _ stk
        add | i2 r1 1 r1
        call(get_grid)
        mov stk _ r1
        mov stk _ r0
        jp | neq | i2 r2 '.' search_loop_has_symb

        jmp(search_loop_x_continue)
        label search_loop_has_symb

        add num ans ans

        label search_loop_x_continue
        add | i2 r0 1 r0
        jp | le r0 lx search_loop_x
    add | i2 r1 1 r1
    jp | le r1 ly search_loop_y

mov ans _ r0
xor r1 r1 r1
call(print_uint)

halt _ _ _

label parse_init

; Check left, up left and down left for symbol
xor issymb issymb issymb

sub | i2 r0 1 r0
mov r0 _ stk
mov r1 _ stk
call(get_grid)
mov stk _ r1
mov stk _ r0
jp | eq | i2 r2 '.' not_symb1
mov | i1 1 _ issymb
label not_symb1

mov r0 _ stk
mov r1 _ stk
sub | i2 r1 1 r1
call(get_grid)
mov stk _ r1
mov stk _ r0
jp | eq | i2 r2 '.' not_symb2
mov | i1 1 _ issymb
label not_symb2

mov r0 _ stk
mov r1 _ stk
add | i2 r1 1 r1
call(get_grid)
mov stk _ r1
mov stk _ r0
jp | eq | i2 r2 '.' not_symb3
mov | i1 1 _ issymb
label not_symb3

add | i2 r0 1 r0
xor num num num

label parse_loop
    ; Get digit
    mov r0 _ stk
    mov r1 _ stk
    call(get_grid)
    mov stk _ r1
    mov stk _ r0

    sub | i2 r2 '0' r2
    jp | ge | i2 r2 '9' search_loop_return

    ; Add to number if is digit
    mul | i2 num 10 num
    add num r2 num

    ; Check above and below for symbols
    mov r0 _ stk
    mov r1 _ stk
    sub | i2 r1 1 r1
    call(get_grid)
    mov stk _ r1
    mov stk _ r0
    jp | eq | i2 r2 '.' not_symb_loop1
    mov | i1 1 _ issymb
    label not_symb_loop1

    mov r0 _ stk
    mov r1 _ stk
    add | i2 r1 1 r1
    call(get_grid)
    mov stk _ r1
    mov stk _ r0
    jp | eq | i2 r2 '.' not_symb_loop2
    mov | i1 1 _ issymb
    label not_symb_loop2

    add | i2 r0 1 r0
    jmp(parse_loop)

#include "get_grid.s"

#include "../../util/print_uint.s"
