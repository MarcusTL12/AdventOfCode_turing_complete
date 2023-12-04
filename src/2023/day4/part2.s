#include "../../util/defines.s"

const fp r0

const ans r11
const nafter r12
const nbefore r13
const nlines r14
const len r15

const line_offset 10

; Get length of file
sub | i1 | i2 0 1 r0
mov r0 | fil _ len

xor fp fp fp

label look_for_colon_loop
    add | i2 fp 1 fp
    and | i2 fp | fil 0xff r1
    jp | neq | i2 r1 ':' look_for_colon_loop

add | i2 fp 2 fp

label count_before_loop
    add | i2 fp 3 fp
    add | i2 nbefore 1 nbefore
    and | i2 fp | fil 0xff r1
    jp | neq | i2 r1 '|' count_before_loop

add | i2 fp 1 fp

label count_after_loop
    add | i2 fp 3 fp
    add | i2 nafter 1 nafter
    and | i2 fp | fil 0xff r1
    jp | neq | i2 r1 '\n' count_after_loop

add | i2 fp 1 fp
div len fp nlines

xor fp fp fp
mov nlines _ stk
add | i1 line_offset nbefore r2

label parse_lines_loop
    mov r2 _ stk
    call(parse_line)
    mov stk _ r2

    mov r1 _ r2 | mem
    add | i2 r2 1 r2

    sub | i2 nlines 1 nlines
    jp | neq | i2 nlines 0 parse_lines_loop

mov stk _ nlines
mov nlines _ stk

add | i1 line_offset nbefore r2
add nlines r2 r2

label fill_ones_loop
    mov | i1 1 _ r2 | mem
    add | i2 r2 1 r2

    sub | i2 nlines 1 nlines
    jp | neq | i2 nlines 0 fill_ones_loop

mov stk _ nlines
mov nlines _ r9

add | i1 line_offset nbefore r2

label count_tickets_loop
    add nlines r2 r3
    add r3 | mem ans ans
    add | i2 r3 1 r4
    jp | eq | i2 r2 | mem 0 count_tickets_loop_continue
    label add_tickets_loop
        add r4 | mem r3 | mem r4 | mem
        add | i2 r4 1 r4

        sub | i2 r2 | mem 1 r2 | mem
        jp | neq | i2 r2 | mem 0 add_tickets_loop

    label count_tickets_loop_continue
    add | i2 r2 1 r2
    sub | i2 r9 1 r9
    jp | neq | i2 r9 0 count_tickets_loop

mov ans _ r0
xor r1 r1 r1
call(print_uint)

halt _ _ _

#include "parse_line.s"

#include "../../util/parse_uint.s"
#include "../../util/print_uint.s"
