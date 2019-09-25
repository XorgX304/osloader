cc : 
	nasm boot.asm
	# cat /home/lt/os/buildroot-2019.02.4/output/images/rootfs.ext2 >> boot 

run : cc
	qemu-system-x86_64 -drive format=raw,file=boot  # -s -S

dbg: cc
	qemu-system-x86_64 -drive format=raw,file=boot -s -S

