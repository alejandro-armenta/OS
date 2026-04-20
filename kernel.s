start:
    mov ax, cs
    mov ds, ax

    mov si, hello_string
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

        ret


hello_string db 'Hello World', 0
