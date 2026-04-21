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

	

	#dd if=bootloader.o of=kernel.img

	#dd seek=1 conv=sync if=kernel.o of=kernel.img bs=512

	#unset GTK_PATH
	#unset GIO_MODULE_DIR


	#qemu-system-x86_64 -s kernel.img
	

clean:

	rm -f *.o
	rm kernel.img
