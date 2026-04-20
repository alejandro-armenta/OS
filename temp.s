
db 'a', 'b', 'c'

our_variable db 'abc', 0

;alocate 100 bytes of memory
times 100 db 0


print_character_S_with_BIOS:

    mov ah, 0Eh

    mov al, 'S'

    int 10h

    ret

;aqui no pasa nada

    mov bx, 5

loop_start:

    cmp bx, 0

    je loop_end

    times 5 call print_character_S_with_BIOS

    ;call print_character_S_with_BIOS

    dec bx

    jmp loop_start

loop_end:

    


;