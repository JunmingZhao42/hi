#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define FIBO_NUM 10000
#define MAX_SIZE 32

typedef struct {
    uint64_t items[MAX_SIZE];
    uint32_t head;
    uint32_t tail;
} queue;

static char cml_memory[1024*2];
extern void *cml_heap;
extern void *cml_stack;
extern void *cml_stackend;

extern void cml_main(void);
extern void enqueue(queue *q, uint64_t value);
extern uint64_t dequeue(queue *q);

void cml_exit(int arg) {
    printf("ERROR! We should not be getting here\n");
}

void cml_err(int arg) {
    if (arg == 3) {
        printf("Memory not ready for entry. You may have not run the init code yet, or be trying to enter during an FFI call.\n");
    }
  cml_exit(arg);
}

/* Need to come up with a replacement for this clear cache function. Might be worth testing just flushing the entire l1 cache, but might cause issues with returning to this file*/
void cml_clear() {
    printf("Trying to clear cache\n");
}

void init_pancake_mem() {
    unsigned long cml_heap_sz = 1024;
    unsigned long cml_stack_sz = 1024;
    cml_heap = cml_memory;
    cml_stack = cml_heap + cml_heap_sz;
    cml_stackend = cml_stack + cml_stack_sz;
}

void ffitransfer32(unsigned char *c, long clen, unsigned char *a, long alen) {
    uint32_t value = *(uint32_t *) c;
    *(uint32_t *) a = value;
}

void ffiprint_int(unsigned char *c, long clen, unsigned char *a, long alen) {
    // print clen
    printf("%lu\n", clen);
}

int main() {
    init_pancake_mem();
    cml_main();

    uintptr_t *heap = (uintptr_t *) cml_heap;
    queue *global_queue = (queue *) &heap[1];

    for (int i = 2; i <= FIBO_NUM; i++) {
        uint64_t a = dequeue(global_queue);
        uint64_t b = dequeue(global_queue);
        uint64_t next_fib = a + b;
        enqueue(global_queue, b);
        enqueue(global_queue, next_fib);
    }

    // Dequeue twice to get to the last calculated Fibonacci number
    dequeue(global_queue);
    uint64_t fib = dequeue(global_queue);

    return 0;
}