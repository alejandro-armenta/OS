start:
    
    mov ax, 07C0h
    
    mov ds, ax


    ;si is the address of the string to print
    mov si, title_string

    call print_string

    mov si, message_string

    call print_string


    call load_kernel_from_disk

    jmp 0900h:0000


load_kernel_from_disk:

    mov ax, 0900h

    ;here it is the address of the kernel and the offset 
    mov es, ax

    mov ah, 02h ;reads sectors from the hard disk and loads them into memory
    
    ;read only 1 sector
    mov al, 01h
    
    ;track 0
    mov ch, 0h

    ;second sector
    mov cl, 02h

    ;head number
    mov dh, 0h

    ;hard disk 0
    mov dl, 80h

    ;the content will be stored on memory address 0 offset
    mov bx, 0h

    ;provides services of hard disks
    int 13h

    ;jump if carry
    jc kernel_load_error

    ret


kernel_load_error:


