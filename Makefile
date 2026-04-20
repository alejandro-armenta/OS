ASM = nasm

BOOTLOADER_FILE = bootloader.s
KERNEL_FILE = kernel.s

build: $(BOOTLOADER_FILE)

	$(ASM) -f bin $(BOOTLOADER_FILE) -o bootloader.o
	$(ASM) -f bin $(KERNEL_FILE) -o kernel.o

	dd if=bootloader.o of=kernel.img

	dd seek=1 conv=sync if=kernel.o of=kernel.img bs=512

	unset GTK_PATH
	unset GIO_MODULE_DIR


	qemu-system-x86_64 -s kernel.img
	

clean:

	rm -f *.o
	rm kernel.img
