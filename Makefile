all: run clean

bootloader: boot.bin kernel.bin 
	cat boot.bin kernel.bin > bootloader

boot.bin: boot.asm
	nasm $<  -f bin -o $@

kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -s -o $@ -Ttext 0x1000 $^ --oformat binary 

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	gcc -m32 -fno-pie -ffreestanding -c $< -o $@

run: bootloader
	qemu-system-i386 -nographic -boot order=a -fda $<

clean:
	rm -f *.o *.bin bootloader

.PHONY: clean

help: 
	@echo "run : run bootloader in qemu"
	@echo "bootloader: build bootloader"
	@echo "clean: cleanup"
	@echo "help: help"


