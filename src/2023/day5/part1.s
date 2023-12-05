#include "../../util/defines.s"

const nseeds_mem 4
const seeds_mem 10
const maps_ptr_mem 5

const nmaps 7

mov | i1 7 _ r0
mov | i1 seeds_mem _ r1
call(parse_seeds)

; Save number of seeds
mov | i1 nseeds_mem _ r2
sub | i2 r1 seeds_mem r2 | mem

; Save start location of maps mem
mov | i1 maps_ptr_mem _ r2
mov r1 _ r2 | mem

; Memory layout of map:
; First number of rows in map
; Then all numbers in map
; Then next map

add | i2 r0 2 r0
mov_mem2reg(maps_ptr_mem, r1)
call(parse_maps)

halt _ _ _

#include "common.s"

#include "../../util/parse_uint.s"
