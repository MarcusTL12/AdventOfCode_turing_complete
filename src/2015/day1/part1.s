
const len r3
const fp r0
const acc r4
const max r5
const x r1

# Get length of file
sub | i1 | i2 0 1 r0
mov r0 | fil _ len
sub | i2 len 1 len

xor fp fp fp

# Loop over groups
label loop1

xor acc acc acc
# Loop over group
label loop2
add | i1 8 pc stk
mov | i1 parse_uint _ pc

add x acc acc

add | i1 1 fp fp

# Loop if not double lineshift
and | i2 fp | fil 0xff x
jp | neq | i2 x '\n' loop2

jp | le acc max notmax
mov acc _ max
label notmax

jp | le fp len loop1

mov max _ r0
xor r1 r1 r1
add | i2 pc 8 stk
mov | i1 print_uint _ pc

halt

#!include ../../util/util.s
