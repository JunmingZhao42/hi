#!/bin/sh
gcc -g -o fibo fibo.c

valgrind --tool=callgrind ./fibo
callgrind_annotate callgrind.out.* > analysis-c.txt
objdump -D fibo > assembly-c.txt
rm -f fibo callgrind.out.*

