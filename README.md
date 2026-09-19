# check.sh

A small shell script for testing C programs from the terminal. It compiles a file with strict flags (`-std=c99 -Wall -pedantic -Werror`) and compares the program's output against expected output files, byte for byte.

### Install

    mkdir -p ~/bin
    cp check.sh ~/bin/
    chmod +x ~/bin/check.sh

Make sure `~/bin` is on your `PATH`:

    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc    # macOS (zsh)
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc   # Linux (bash)

### Usage

Put test cases in a `tests/` folder next to your program:

    tests/1.in    input
    tests/1.out   exact expected output

Then run:

    check.sh program.c

Each test prints PASS or FAIL. For failures, the diff shows your output (`<`) against the expected output (`>`). A missing final newline shows up as `\ No newline at end of file`.