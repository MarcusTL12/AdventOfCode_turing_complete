#include "../../util/defines.s"

const fp r0

const nseeds_mem 4
const seeds_mem 10

mov | i1 7 _ fp
mov | i1 seeds_mem _ r1
call(parse_seeds)

halt _ _ _

#include "common.s"

#include "../../util/parse_uint.s"
