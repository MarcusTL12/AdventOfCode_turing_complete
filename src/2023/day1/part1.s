#include "../../util/defines.s"

const fp r0
const x r1
const acc r2
const d1 r3
const d2 r4
const i r5

xor fp fp fp
xor acc acc acc

; Loop over lines
label loop1

    xor d1 d1 d1
    xor d2 d2 d2
    xor i i i

    ; loop over chars in line
    label loop2
        and | i2 fp | fil 0xff x
        add | i2 fp 1 fp
        jp | i2 | eq x 0 loop1_end
        jp | i2 | eq x '\n' loop2_end

        sub | i2 x '0' x
        jp | ge | i2 x 9 loop2

        add | i2 i 1 i
        mov x _ d2
        jp | ge | i2 i 1 loop2
        mov x _ d1
        jmp(loop2)

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

#include "../../util/util.s"
