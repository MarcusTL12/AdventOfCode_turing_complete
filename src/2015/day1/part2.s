#include "../../util/defines.s"

const len r3
const fp r0
const acc r4
const max1 r5
const max2 r9
const max3 r10
const x r1

; Get length of file
sub | i1 | i2 0 1 r0
mov r0 | fil _ len
sub | i2 len 1 len

xor fp fp fp

; Loop over groups
label loop1

    xor acc acc acc
    ; Loop over group
    label loop2
        call(parse_uint)

        add x acc acc

        add | i1 1 fp fp

        ; Loop if not double lineshift
        and | i2 fp | fil 0xff x
        jp | neq | i2 x '\n' loop2

    jp | le acc max3 notmax3
    swap(acc, max3)
    label notmax3

    jp | le acc max2 notmax2
    swap(acc, max2)
    label notmax2

    jp | le acc max1 notmax1
    swap(acc, max1)
    label notmax1

    jp | le fp len loop1

add max2 max3 max3
add max1 max3 max3

mov max3 _ r0
xor r1 r1 r1
call(print_uint)

halt _ _ _

#include "../../util/util.s"
