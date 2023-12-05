#ifndef __defines
#define __defines

#define jmp(x) mov | i1 x _ pc
#define call(x) add | i1 8 pc stk jmp(x)
#define return mov stk _ pc

#define swap(a, b) xor a b a xor b a b xor a b a

#define jf(x) add | i1 x * 4 pc pc
#define jr(x) sub | i2 pc x * 4 pc

#define mov_mem2reg(c, r) mov | i1 c _ r mov r | mem _ r
#define mov_reg2mem(r, m) mov | i1 c _ ovf mov r _ ovf | mem

#endif
