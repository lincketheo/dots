#!/usr/bin/env bash

version=v0.20.4 # this is for older version of GLIBC
exe=tree-sitter-linux-x64
artifact=$exe.gz

wget https://github.com/tree-sitter/tree-sitter/releases/download/$version/$artifact
gunzip $artifact
chmod u+x $exe
rm -f $exe $artifact
