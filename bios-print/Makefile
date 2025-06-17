LINKER = ld
ASSEMBLER = as  

APP:=bios-print

$(APP) : $(APP).bin
.PHONY: $(APP)

$(APP).bin: $(APP).o $(APP).elf
	objcopy -O binary $(APP).elf $(APP).bin

$(APP).debug : $(APP).elf
$(APP).elf: $(APP).o $(APP).ld
	$(LINKER) -m elf_i386 -z noexecstack -N -T $(APP).ld  $< -o $@
	objcopy --only-keep-debug $(APP).elf $(APP).debug
	strip -g $(APP).elf

$(APP).o : $(APP).asm
	$(ASSEMBLER) -march i386 --32 -g  --gdwarf-4 $< -o $@

qemu: $(APP).bin
	qemu-system-i386 -nographic -boot order=a -fda $(APP).bin

qemu-debug: $(APP).bin
	qemu-system-i386 -s -S -nographic -boot order=a -fda $(APP).bin

gdb: $(APP).bin $(APP).debug
	gdb -ex "target remote localhost:1234" -ex "b *0x7c00" -ex "set architecture i8086" $(APP).debug

clean:
	rm -rf *.o *.bin *.elf *.debug


.PHONY : clean help qemu qemu-debug gdb

help:
	@echo "-- "
	@echo "default: build $(APP).bin"	
	@echo "qemu: run $(APP).bin"
	@echo "-- debug "
	@echo "qemu-debug:: run $(APP).bin and wait for gdb"
	@echo "gdb: attach gdb to qemu"
	@echo "-- aux "
	@echo "dump: objdump $(APP).bin"
	@echo "clean: clean"


