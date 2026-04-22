ASM = nasm

CC = gcc

BOOTLOADER_FILE = bootloader.asm

INIT_KERNEL_FILE = starter.asm

KERNEL_FILES = main.c

KERNEL_FLAGS = -Wall -m32 -c -ffreestanding -fno-asynchronous-unwind-tables -fno-pie

KERNEL_OBJECT = -o kernel.elf

build: $(BOOTLOADER_FILE) $(INIT_KERNEL_FILE)

	#this is the bootloader
	$(ASM) -f bin $(BOOTLOADER_FILE) -o bootloader.o

	#this is assembly part of the kernel
	$(ASM) -f elf32 $(INIT_KERNEL_FILE) -o starter.o

	#this is the kernel in C
	$(CC) $(KERNEL_FLAGS) $(KERNEL_FILES) $(KERNEL_OBJECT)

	ld -melf_i386 -Tlinker.ld starter.o kernel.elf -o alekernel.elf

	objcopy -O binary alekernel.elf alekernel.bin

	dd if=bootloader.o of=kernel.img

	#this copies 5 sectors
	dd seek=1 conv=sync if=alekernel.bin of=kernel.img bs=512 count=5

	#initializes with zero padding 2046 sectors
	dd seek=6 conv=sync if=/dev/zero of=kernel.img bs=512 count=2046

	qemu-system-x86_64 -s kernel.img
	

clean:

	rm -f *.o
	rm -f *.img
	rm -f *.elf
	rm -f *.bin

