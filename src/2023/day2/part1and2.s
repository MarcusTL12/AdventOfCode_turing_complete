#include "../../util/defines.s"

const fp r0
const x r1
const red r3
const green r4
const blue r5
const id r9
const acc_part1 r10
const acc_part2 r11
const len r12

; Get length of file
sub | i1 | i2 0 1 r0
mov r0 | fil _ len
sub | i2 len 1 len

xor fp fp fp
mov | i1 1 _ id

; Loop over lines
label loop1

    xor red red red
    xor green green green
    xor blue blue blue

    add | i2 fp 5 fp
    ; Look for ':'
    label id_loop
        add | i2 fp 1 fp
        and | i2 fp | fil 0xff x
        jp | neq | i2 x ':' id_loop
    add | i2 fp 2 fp

    ; loop over colors
    label loop2
        call(parse_uint)
        add | i2 fp 1 fp
        and | i2 fp | fil 0xff r2

        jp | neq | i2 r2 'r' not_red
        add | i2 fp 3 fp
        jp | le x red done_max
        mov x _ red
        jmp(done_max)
        label not_red

        jp | neq | i2 r2 'g' not_green
        add | i2 fp 5 fp
        jp | le x green done_max
        mov x _ green
        jmp(done_max)
        label not_green

        jp | neq | i2 r2 'b' not_blue
        add | i2 fp 4 fp
        jp | le x blue done_max
        mov x _ blue
        label not_blue

        label done_max

        and | i2 fp | fil 0xff x
        jp | eq | i2 x '\n' loop2_end
        add | i2 fp 2 fp
        jmp(loop2)
    label loop2_end

    jp | ge | i2 red 12 not_possible
    jp | ge | i2 green 13 not_possible
    jp | ge | i2 blue 14 not_possible
    add acc_part1 id acc_part1
    label not_possible

    mul red green x
    mul blue x x
    add acc_part2 x acc_part2

    add | i2 id 1 id

    add | i2 fp 1 fp
    jp | le fp len loop1

mov acc_part1 _ r0
xor r1 r1 r1
call(print_uint)

mov acc_part2 _ r0
mov | i1 80 _ r1
call(print_uint)

halt _ _ _

#include "../../util/util.s"
