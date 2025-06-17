/*
 * setup.ld
 *
 * Linker script 
 */
OUTPUT_FORMAT("elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS
{
    /* Load address of this code ( done by BIOS ) */
    . = 0x7C00; 
    .text		: { *(.text) }

    /* Ensure the binary is 512 bytes with the signature */
    # . = 0x7DFE;
    # .bsboot     : { *(.bscode) }
    .sig : AT(0x7DFE) { /* 0x7C00 + 0x200 - 2 = 0x7DFE */
        BYTE(0x55)
        BYTE(0xAA)
     }
    
}