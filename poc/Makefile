cc: 
	nasm boot.asm
	nasm sector_2.asm
	nasm sector_3.asm
	cat sector_2 >> boot
	cat sector_3 >> boot
	rm -rf sector_2 sector_3

run : cc
	qemu-system-x86_64 -drive format=raw,file=boot  # -s -S

dbg : cc
	qemu-system-x86_64 -drive format=raw,file=boot  -s -S

