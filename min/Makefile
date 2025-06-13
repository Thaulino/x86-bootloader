boot: boot.bin
boot.bin: boot.asm
	nasm -f bin boot.asm -o $@

dump: boot.bin
	objdump -D -b binary -mi386 -Maddr16,data16,intel boot.bin

clean: 
	rm boot.bin

qemu: boot.bin
	qemu-system-x86_64 -nographic  $<

help: 
	@echo "boot: build boot.bin"	
	@echo "dump: objdump boot.bin"
	@echo "qemu: run boot.bin"
	@echo "clean: clean"
		
