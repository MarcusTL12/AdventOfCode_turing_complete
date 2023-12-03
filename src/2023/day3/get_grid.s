
; Input:
;   r0: x index
;   r1: y index
; Output:
;   r2: character in grid
label get_grid
    jp | geq r0 lx get_grid_oob
    jp | geq r1 ly get_grid_oob

    mul r1 lx r1
    add r1 r0 r1
    mov | i1 grid_offset _ r0
    jmp(get_byte) ; tail call

label get_grid_oob
    mov | i1 '.' _ r2
    return

#include "../../util/get_byte.s"
