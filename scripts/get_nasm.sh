#!/usr/bin/env bash

version=2.16.02
platform=linux 
arch=x86_64
product=nasm-$version-0.fc39.$arch.rpm
link=https://www.nasm.us/pub/nasm/releasebuilds/$version/$platform/$product
wget $link
rpm2cpio $product | cpio -t
rpm2cpio $product | cpio -ivd ./usr/bin/nasm 
mv ./usr/bin/nasm .
rm -rf usr 
rm -rf $product
