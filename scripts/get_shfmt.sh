#!/usr/bin/env bash 

version=v3.8.0
artifact=shfmt_${version}_linux_amd64

wget https://github.com/mvdan/sh/releases/download/$version/$artifact
chmod u+x $artifact
rm $artifact
