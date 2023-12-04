#include "../../util/defines.s"

const fp r0

const ans r11
const nafter r12
const nbefore r13
const nlines r14
const len r15

const line_offset 20

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

label main_loop
    call(parse_line)
    jp | eq | i2 r1 0 main_loop_continue

    sub | i2 r1 1 r1
    mov | i1 1 _ r2
    shl r2 r1 r2
    add r2 ans ans

    label main_loop_continue
    sub | i2 nlines 1 nlines
    jp | neq | i2 nlines 0 main_loop

mov ans _ r0
xor r1 r1 r1
call(print_uint)

halt _ _ _

; Input
;   r0/fp: pointer to start of line in file
; Output
;   r1: number of numbers that show up both before and after line
;   r0: start of next line
; Uses
;   r3, r4, r5, r9
label parse_line
    xor r9 r9 r9

    label parse_line_look_for_colon_loop
        add | i2 fp 1 fp
        and | i2 fp | fil 0xff r1
        jp | neq | i2 r1 ':' parse_line_look_for_colon_loop

    mov | i1 line_offset _ r3
    mov nbefore _ r4

    label parse_line_number_loop_1
        label parse_line_look_for_number_loop_1
            add | i2 fp 1 fp
            and | i2 fp | fil 0xff r1
            sub | i2 r1 '0' r1
            jp | ge | i2 r1 '9' parse_line_number_loop_1
        call(parse_uint)
        mov r1 _ r3 | mem
        add | i2 r3 1 r3

        sub | i2 r4 1 r4
        jp | neq | i2 r4 0 parse_line_number_loop_1

    mov nafter _ r4

    label parse_line_number_loop_2
        label parse_line_look_for_number_loop_2
            add | i2 fp 1 fp
            and | i2 fp | fil 0xff r1
            sub | i2 r1 '0' r1
            jp | ge | i2 r1 '9' parse_line_number_loop_2
        call(parse_uint)
        mov r3 _ r5
        label parse_line_check_if_exist_loop
            sub | i2 r5 1 r5
            jp | eq r1 r5 | mem parse_line_found
            jp | ge | i2 r5 line_offset parse_line_check_if_exist_loop

        jmp(parse_line_not_found)

        label parse_line_found
        add | i2 r9 1 r9
        label parse_line_not_found

        sub | i2 r4 1 r4
        jp | neq | i2 r4 0 parse_line_number_loop_2

    mov r9 _ r1
    add | i2 fp 1 fp
    return



#include "../../util/parse_uint.s"
#include "../../util/print_uint.s"
