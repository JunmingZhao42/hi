#!/bin/sh

set -e

DIR=$1
NAME=$2

valgrind --tool=callgrind --cache-sim=yes --branch-sim=yes $DIR/$NAME

echo "Generating file ./$DIR/analysis-$NAME.txt"
callgrind_annotate callgrind.out.* > ./$DIR/analysis-$NAME.txt
objdump -D $DIR/$NAME > ./$DIR/assembly-$NAME.txt

rm callgrind.out.*
