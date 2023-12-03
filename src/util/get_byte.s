#ifndef __get_byte
#define __get_byte

; Input:
;   r0: mem offset
;   r1: byte offset from mem offset
; Output:
;   r2: byte
; Uses:
;   r0: becomes mem offset of word containing byte
;   r1: becomes 8 * (r1 % 8)
label get_byte
    div | cy | i2 r1 8 r1
    add r1 r0 r0
    shl | i2 ovf 3 r1
    shr r0 | mem r1 r2
    and | i2 r2 0xff r2
    return

#endif
