#include "../../util/defines.s"

const fp r0
const score r1
const len r2
const n r3
const a r4
const b r5

; Get length of file
sub | i1 | i2 0 1 r0
mov r0 | fil _ len

shr | i2 len 2 n

xor fp fp fp

label loop1
    and | i2 fp | fil 0xff a
    add | i2 fp 2 fp
    and | i2 fp | fil 0xff b
    add | i2 fp 2 fp

    sub | i2 a 'A' a
    sub | i2 b 'X' b

    sub b a r9
    add | i2 r9 4 r9
    div | cy | i2 r9 3 r9
    mul | i2 ovf 3 r9
    add r9 b r9
    add | i2 r9 1 score

    sub | i2 n 1 n
    jp | neq | i2 n 0 loop1


mov score _ r0
xor r1 r1 r1
call(print_uint)

halt _ _ _

#include "../../util/util.s"
