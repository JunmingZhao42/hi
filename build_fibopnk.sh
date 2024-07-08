#!/bin/sh
cat fibo.🥞 | cpp -P > fibo1.🥞 && cake --pancake --main_return=true <fibo1.🥞 > fibo.S --target=x64
gcc -o fibopnk fibo.S pnk_ffi.c