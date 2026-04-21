start:

    ;first place of our bootloader
    mov ax, 07C0h
    
    mov ds, ax

    ;si is the address of the string to print
    mov si, title_string

    call print_string

    mov si, message_string

    call print_string

    call load_kernel_from_disk

    ;aqui empieza a cargar todos los sectores 15
    ;aqui es el es

    ;este es un far jump
    ;cs changes to 0900 but ds not

    jmp 0900h:0000

load_kernel_from_disk:

    mov ax, [curr_sec_to_load]

    sub ax, 2

    mov bx, 512d

    mul bx

    ;offset 00000
    mov bx, ax

    mov ax, 0900h

    ;move to data segment es
    mov es, ax

    ;full memory address
    ;es:bx

    mov ah, 02h ;reads sectors from the hard disk and loads them into memory
    
    ;read only 1 sector
    mov al, 01h
    
    ;track 0
    mov ch, 0h

    ;second sector
    mov cl, [curr_sec_to_load]

    ;head number
    mov dh, 0h

    ;hard disk 0
    mov dl, 80h

    ;provides services of hard disks
    int 13h

    ;jump if carry
    jc kernel_load_error

    sub byte [number_of_sectors_to_load], 1

    add byte [curr_sec_to_load], 1

    ;el 0 ya no lo cuenta
    cmp byte [number_of_sectors_to_load], 0

    jne load_kernel_from_disk

    ret

    kernel_load_error:

        mov si, load_error_string

        call print_string

        jmp $

print_string:

    mov ah, 0Eh 


    print_char:

        ;loads from si one byte and puts it into al
        lodsb

        cmp al, 0

        je print_finished

        ;print the content of the register al into screen one byte
        int 10h

        jmp print_char


    print_finished:

        mov al, 10d

        int 10h


        ;read current cursor position

        mov ah, 03h

        mov bh, 0

        int 10h

        ;reset cursor to 0

        mov ah, 02h

        mov dl, 0

        int 10h

        ret

;este es un offset no un address completo
;0:490
;07C0h:490

title_string db 'the bootloader of Alex kernel',0

message_string db 'the kernel is loading...',0

load_error_string db 'the kernel cannot be loaded...',0

number_of_sectors_to_load db 15d

curr_sec_to_load db 02d


;desde aqui hasta el inicio - 510 son de ceros
times 510 - ($-$$) db 0

;magic code
dw 0xAA55










