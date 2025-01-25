# This script is from https://gist.github.com/pedrominicz/93ef0510a20f990b8dc99877fd51a438
# All credit goes to them and them exclusively

#!/bin/sh
# https://github.com/cfenollosa/os-tutorial/tree/master/11-kernel-crosscompiler
# http://geekos.sourceforge.net/docs/crossgcc.html
# https://github.com/nativeos/pkgbuild-i386-elf-toolchain/blob/master/i386-elf-gcc/PKGBUILD
# http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html
# https://gcc.gnu.org/install/configure.html

TARGET=i386-elf
# Add `$PREFIX/bin` to your `$PATH`.
PREFIX=/opt/i386-elf

TMPDIR=$(mktemp -d)
pushd $TMPDIR

curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz
tar xf binutils-2.34.tar.gz
mkdir binutils-2.34-build
cd binutils-2.34-build
../binutils-2.34/configure --target=$TARGET --prefix=$PREFIX --enable-interwork --enable-multilib --disable-nls --disable-werror
make -j 8 all
sudo make install
cd ..

PATH="$PATH:$PREFIX/bin"

curl -O https://ftp.gnu.org/gnu/gcc/gcc-9.2.0/gcc-9.2.0.tar.gz
tar xf gcc-9.2.0.tar.gz
cd gcc-9.2.0
./contrib/download_prerequisites
cd ..
mkdir gcc-9.2.0-build
cd gcc-9.2.0-build
../gcc-9.2.0/configure --target=$TARGET --prefix=$PREFIX --disable-nls --enable-languages=c --enable-interword --enable-multilib
make -j 8 all-gcc
make -j 8 all-target-libgcc
sudo make install-gcc
sudo make install-target-libgcc

popd
rm -rf $TMPDIR