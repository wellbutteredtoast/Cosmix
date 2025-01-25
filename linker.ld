ENTRY(_start)

SECTIONS {
    . = 0x100000;  /* Set the start of the kernel at a higher memory address (1MB) */
    
    .multiboot : {
        *(.multiboot)   /* Multiboot header goes first */
    }

    .text : {
        *(.text)        /* Kernel code */
    }

    .data : {
        *(.data)        /* Kernel data */
    }

    .bss : {
        *(.bss)         /* Uninitialized data */
    }

    . = ALIGN(0x1000); /* Align to 4KB boundary */

    /* Create a gap to allow room for the program header */
    . = . + 0x1000;
}
