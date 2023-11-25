
; Parse int from file
; input:
;   r0: offset into file
; output:
;   r0: offset to first non
;       numerical character
;   r1: parsed integer
; destroys:
;   r2
label parse_uint
xor r1 r1 r1
label parse_uint_loop

; Load byte from file
and | i2 r0 | fil 0xff r2

; Check if is numeric
jp | geq | i2 r2 '0' parse_uint_g
mov stk _ pc ; return
label parse_uint_g
jp | leq | i2 r2 '9' parse_uint_l
mov stk _ pc ; return
label parse_uint_l

; Is numeric, update number
mul | i2 r1 10 r1
sub | i2 r2 '0' r2
add r1 r2 r1

; Iterate
add | i2 r0 1 r0
mov | i1 parse_uint_loop _ pc

; Print uint to terminal
; Input:
;   r0: int to print
;   r1: byte offset in mem
;
; Uses:
;   r0: buffer
;   r2: num digits left
;   r1: int offset in mem
;   r3: byte offset in int
label print_uint

xor r2 r2 r2
label print_uint_loop1
div | cy | i2 r0 10 r0
add | i2 ovf '0' stk
add | i1 1 r2 r2
jp | neq | i2 r0 0 print_uint_loop1

div | cy | i2 r1 8 r1
shl | i2 ovf 3 r3

label print_uint_loop2
jp | neq | i2 r2 0
    print_uint_noreturn
mov stk _ pc
label print_uint_noreturn

shl stk r3 r0
or r0 r1 | mem r1 | mem
sub | i2 r2 1 r2

add | i2 r3 8 r3
jp | le | i2 r3 64 print_uint_loop2

xor r3 r3 r3
add | i2 r1 1 r1
mov | i1 print_uint_loop2 _ pc
