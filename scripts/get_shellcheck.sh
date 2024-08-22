#!/usr/bin/env bash 

version=stable
outdir=shellcheck-stable
artifact=$outdir.linux.x86_64.tar.xz
exe=shellcheck
wget https://github.com/koalaman/shellcheck/releases/download/$version/$artifact
tar -xf $artifact
cp $outdir/$exe .
rm -rf $outdir
rm -rf $artifact
