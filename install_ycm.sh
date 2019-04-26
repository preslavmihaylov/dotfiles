#!/bin/bash

# NOTE: This installation will work only if your vim is v. 7.4, 1578 or higher and it has python or python3
# To ensure these preconditions are met:
# 1. type vim --version and search for version number and Extra patches. Verify they meet criteria
# 2. enter vim and type :echo has('python') || has('python3'). If the result is 1, you are good to go

cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer --go-completer --ts-completer
