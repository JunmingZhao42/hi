#!/bin/sh
cat fibo.🥞 | cpp -P > fibo1.🥞 && cake --pancake --main_return=true <fibo1.🥞 > fibo.S --target=x64
gcc -g -O0 -o fibopnk fibo.S pnk_ffi.c

valgrind --tool=callgrind --cache-sim=yes --branch-sim=yes ./fibopnk
callgrind_annotate --inclusive=yes callgrind.out.* > ./data/analysis-pnk.txt
objdump -D fibopnk > ./data/assembly-pnk.txt
rm -f fibo1.🥞 fibo.S fibopnk callgrind.out.*
