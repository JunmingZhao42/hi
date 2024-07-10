#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define MAX_SIZE 32
#define FIBO_NUM 10000
typedef struct {
    uint64_t items[MAX_SIZE];
    uint32_t head;
    uint32_t tail;
} queue;

bool isEmpty(queue *q) {
    return (q->head % MAX_SIZE) == (q->tail % MAX_SIZE);
}

bool isFull(queue *q) {
    return ((q->tail + 1) % MAX_SIZE) == (q->head % MAX_SIZE);
}

void enqueue(queue *q, uint64_t value) {
    if (isFull(q)) {
        printf("queue is full\n");
        return;
    }

    q->items[q->tail] = value;
    q->tail = (q->tail + 1) % MAX_SIZE;
}

uint64_t dequeue(queue *q) {
    if (isEmpty(q)) {
        printf("queue is empty\n");
        return 0;
    }
    uint64_t value = q->items[q->head];
    q->head = (q->head + 1) % MAX_SIZE;
    return value;
}

int main() {
    queue my_queue = {0};
    my_queue.head = 0;
    my_queue.tail = 0;

    enqueue(&my_queue, 0);  // F(0) = 0
    enqueue(&my_queue, 1);  // F(1) = 1

    for (int i = 2; i <= FIBO_NUM; i++) {
        uint64_t a = dequeue(&my_queue);
        uint64_t b = dequeue(&my_queue);
        uint64_t next_fib = a + b;
        enqueue(&my_queue, b);
        enqueue(&my_queue, next_fib);
    }

    // Dequeue twice to get to the last calculated Fibonacci number
    dequeue(&my_queue);
    uint64_t fib = dequeue(&my_queue);

    // printf("Fibonacci number F(%d): %lu\n", FIBO_NUM, fib);
    return 0;
}
