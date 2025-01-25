#!/bin/bash

rm -rf ./build/*               # Cleaning out build in case anything is left

mkdir -p build/boot/kernel     # Directory for the kernel
mkdir -p build/boot/grub       # Directory for GRUB configuration
mkdir -p build/tmp             # Temporary files (e.g., object files)
mkdir -p build/bin             # Final binaries (ISO output)

gcc -Wall -Wextra -Werror -ffreestanding -nostdlib -nostartfiles -m32 -o ./build/tmp/kernel.bin ./src/kernel/kmain.c -T ./linker.ld
cp ./build/tmp/kernel.bin ./build/boot/kernel/kernel.bin
cp ./grub.cfg ./build/boot/grub/grub.cfg
grub-mkrescue --output=cosmix.iso ./build/
rm -rf ./build/tmp/*

echo "Opening QEMU!"
qemu-system-x86_64 -cdrom cosmix.iso