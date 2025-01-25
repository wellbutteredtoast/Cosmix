// This header magic is required to get GRUB to see the kernel entrypoint.
// At least it works! And we only needed stdint!

#include <stdint.h>

void _start();

#define MULTIBOOT_HEADER_MAGIC 0x1BADB002
#define MULTIBOOT_HEADER_FLAGS (0)
#define MULTIBOOT_HEADER_CHECKSUM -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)

struct multiboot_header {
    unsigned int magic;
    unsigned int flags;
    unsigned int checksum;
    uintptr_t header_addr;
    uintptr_t load_addr;
    uintptr_t load_end_addr;
    uintptr_t bss_end_addr;
    uintptr_t entry_addr;
};

__attribute__((section(".multiboot"))) struct multiboot_header header = {
    MULTIBOOT_HEADER_MAGIC,
    MULTIBOOT_HEADER_FLAGS,
    MULTIBOOT_HEADER_CHECKSUM,
    0, 0, 0, 0, (uintptr_t)_start  // Entry point is _start
};

// Unbuffered insecure printing, as God intended.
void print_s(const char *str) {
    char *video = (char *)0xB8000;
    while (*str) {
        *video = *str++;        // Write character to screen
        *(video + 1) = 0x0F;    // Set color to white text on black
        video += 2;             // Move to the next character cell  
    }
}

void _start() {

    print_s("Welcome to the Cosmix Kernel, Version 1.01!\n");

    while (1) {

    }
}