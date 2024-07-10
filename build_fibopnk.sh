#!/bin/sh
cat fibo.🥞 | cpp -P > fibo1.🥞 && cake --pancake --main_return=true <fibo1.🥞 > fibo.S --target=x64
gcc -g -o fibopnk fibo.S pnk_ffi.c

valgrind --tool=callgrind ./fibopnk
callgrind_annotate callgrind.out.* > fibopnk_analysis.txt
rm -f fibo1.🥞 fibo.S fibopnk callgrind.out.*
