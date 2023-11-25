#ifndef __defines
#define __defines

#define jmp(x) mov | i1 x _ pc
#define call(x) add | i1 8 pc stk jmp(x)
#define return mov stk _ pc

#endif
