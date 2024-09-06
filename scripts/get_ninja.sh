#!/usr/bin/env bash 

version=v1.12.1
artifact=ninja-linux.zip
wget https://github.com/ninja-build/ninja/releases/download/$version/$artifact
unzip $artifact 
rm $artifact
