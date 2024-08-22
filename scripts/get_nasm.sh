#!/usr/bin/env bash

# Versions conflict with glibc - if you're not working on a dinosoaur computer, use 
# the latest version
version=2.15
platform=linux 
arch=x86_64
flavor=fc31
product=nasm-$version-0.$flavor.$arch.rpm
link=https://www.nasm.us/pub/nasm/releasebuilds/$version/$platform/$product
wget $link
rpm2cpio $product | cpio -t
rpm2cpio $product | cpio -ivd ./usr/bin/nasm 
mv ./usr/bin/nasm .
rm -rf usr 
rm -rf $product
