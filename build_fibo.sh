#!/bin/sh
gcc -g -o fibo fibo.c

valgrind --tool=callgrind ./fibo
callgrind_annotate callgrind.out.* > fibo_analysis.txt
rm -f fibo callgrind.out.*

