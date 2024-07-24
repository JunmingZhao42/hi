#!/bin/sh

set -e
gcc -O0 -g -o fibo fibo.c

valgrind --tool=callgrind --cache-sim=yes --branch-sim=yes ./fibo
callgrind_annotate callgrind.out.* > ./data/analysis-c.txt
objdump -D fibo > ./data/assembly-c.txt
rm -f fibo callgrind.out.*

