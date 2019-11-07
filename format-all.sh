#! /bin/bash

grep -rFL "#pragma once" ./src | grep -F .h | cat

array=(src)
for i in "${array[@]}"
do
    for path in `find ./$i -name "*.cpp" -o -name "*.h" -o -name "*.hpp"`
    do
        `clang-format -i $path`
    done
done