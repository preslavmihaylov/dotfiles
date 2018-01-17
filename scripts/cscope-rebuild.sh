#!/bin/bash

cscope -Rbqv
mv cscope.* $CSCOPE_SRC/ || true
mv ncscope.* $CSCOPE_SRC/ || true
