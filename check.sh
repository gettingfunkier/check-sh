#!/bin/sh
# check.sh - compile a C file with strict flags and run it against test cases
#
# usage: check.sh file.c
#
# Tests: a tests/ folder next to file.c, with pairs:
#   N.in  = input for the program
#   N.out = exact expected output (including final newline)
#
# Output: PASS or FAIL per test; for failures the diff is shown
#   (< lines = test output, > lines = expected output)
#
# Note: -Werror turns warnings into errors, so code with warnings is never tested

TESTDIR=tests

if [ $# -ne 1 ]; then
    echo "usage: check.sh file.c" >&2
    exit 1
fi

if [ ! -d "$TESTDIR" ]; then
    echo "no $TESTDIR/ folder in $(pwd)" >&2
    exit 1
fi


gcc -std=c99 -Wall -pedantic -Werror "$1" -o prog || exit 1


for t in "$TESTDIR"/*.in; do
    if ./prog < "$t" | diff - "${t%.in}.out" > /dev/null; then
        echo "PASS $t"
    else
        echo "FAIL $t"
        ./prog < "$t" | diff - "${t%.in}.out"
    fi
done
