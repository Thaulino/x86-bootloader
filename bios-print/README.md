## 

## Debug Guide

Run qemu with debug flags in order to stop execution until dgb is attached  

```
qemu-system-i386 -nographic -boot  order=a -fda bios-print.bin  -s -S
```
or
```
make qemu-debug
```

Attach with gdb, set architecture ( for real mode ), set break point at address where the bios loads the boot code ( 0x7c00 )

````
gdb -ex "target remote localhost:1234" -ex "b *0x7c00" -ex "set architecture i8086" bios-print.debug
````
or
```
make gdb
```

View register
```
layout reg
```

View next Code
```
x/10i $cs*16+$eip
```

View memory
```
x/10i 
```
