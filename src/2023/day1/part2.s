#include "../../util/defines.s"

const fp r0
const x r2
const d1 r4
const d2 r5
const i r9
const acc r10

xor fp fp fp
xor acc acc acc

; Loop over lines
label loop1

    xor d1 d1 d1
    xor d2 d2 d2
    xor i i i

    jp | i2 fp | fil 0 loop1_end

    mov | i1 2 _ r1
    call(read_line)
    mov fp _ stk
    mov r1 _ r0
    sub | i2 r1 2 r1

    label loop2
        mov | i1 2 _ r0
        mov r1 _ stk
        call(parse_start)
        mov stk _ r1

        jp | eq | i2 x 0 loop2_continue

        add | i2 i 1 i
        mov x _ d2
        jp | ge | i2 i 1 loop2_continue
        mov x _ d1

        label loop2_continue
        add | i2 r0 1 r0
        sub | i2 r1 1 r1
        jp | neq | i2 r1 0 loop2

    mov stk _ fp

    label loop2_end

    mul | i2 d1 10 d1
    add d1 d2 d1
    add d1 acc acc

    jmp(loop1)

label loop1_end

mov acc _ r0
xor r1 r1 r1
call(print_uint)

halt _ _ _

; Input:
;   r0: pointer to start of memory
;   r1: length of line
; Output:
;   r2: digit if found, 0 otherwise
; Uses:
;   r3
label parse_start
    sub | i2 r0 | mem '0' r2
    jp | leq | i2 r2 '9' parse_start_return

    ; Might be text

    jp | le | i2 r1 3 parse_start_return_nodigit
    mov r0 _ r3

    ; Check for three character numbers

    jp | neq | i2 r0 | mem 'o' parse_start_not_one
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'n' parse_start_not_one
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'e' parse_start_not_one
    mov | i1 1 _ r2
    return
    label parse_start_not_one
    mov r3 _ r0

    jp | neq | i2 r0 | mem 't' parse_start_not_two
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'w' parse_start_not_two
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'o' parse_start_not_two
    mov | i1 2 _ r2
    return
    label parse_start_not_two
    mov r3 _ r0

    jp | neq | i2 r0 | mem 's' parse_start_not_six
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'i' parse_start_not_six
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'x' parse_start_not_six
    mov | i1 6 _ r2
    return
    label parse_start_not_six
    mov r3 _ r0

    jp | le | i2 r1 4 parse_start_return_nodigit

    jp | neq | i2 r0 | mem 'f' parse_start_not_five
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'o' parse_start_not_four
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'u' parse_start_not_four
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'r' parse_start_not_four
    mov | i1 4 _ r2
    return
    label parse_start_not_four
    mov r3 _ r0

    jp | neq | i2 r0 | mem 'f' parse_start_not_five
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'i' parse_start_not_five
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'v' parse_start_not_five
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'e' parse_start_not_five
    mov | i1 5 _ r2
    return
    label parse_start_not_five
    mov r3 _ r0
    mov r3 _ r0

    jp | neq | i2 r0 | mem 'n' parse_start_not_nine
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'i' parse_start_not_nine
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'n' parse_start_not_nine
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'e' parse_start_not_nine
    mov | i1 9 _ r2
    return
    label parse_start_not_nine
    mov r3 _ r0

    jp | le | i2 r1 5 parse_start_return_nodigit

    jp | neq | i2 r0 | mem 't' parse_start_not_three
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'h' parse_start_not_three
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'r' parse_start_not_three
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'e' parse_start_not_three
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'e' parse_start_not_three
    mov | i1 3 _ r2
    return
    label parse_start_not_three
    mov r3 _ r0

    jp | neq | i2 r0 | mem 's' parse_start_not_seven
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'e' parse_start_not_seven
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'v' parse_start_not_seven
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'e' parse_start_not_seven
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'n' parse_start_not_seven
    mov | i1 7 _ r2
    return
    label parse_start_not_seven
    mov r3 _ r0

    jp | neq | i2 r0 | mem 'e' parse_start_return_nodigit
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'i' parse_start_return_nodigit
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'g' parse_start_return_nodigit
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 'h' parse_start_return_nodigit
    add | i2 r0 1 r0
    jp | neq | i2 r0 | mem 't' parse_start_return_nodigit
    mov | i1 8 _ r2
    return

    label parse_start_return_nodigit
    mov | i1 0 _ r2
    label parse_start_return
    return


; Input:
;   r0: pointer to file
;   r1: pointer to memory
; Output:
;   r0: pointer to next line
;   r1: pointer to newline character in memory
; Uses:
;   r2
label read_line
    and | i2 r0 | fil 0xff r2
    mov r2 _ r1 | mem
    add | i2 r0 1 r0
    add | i2 r1 1 r1
    jp | neq | i2 r2 '\n' read_line
    return

#include "../../util/util.s"
