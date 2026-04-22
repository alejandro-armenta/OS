;lo iba a builear como 32
bits 16

extern kernel_main

start:
    
    ;real address mode
    ;cs 0900h
    ;ip 0000

    mov ax, cs

    mov ds, ax

    call load_gdt

    call init_video_mode

    call enter_protected_mode

    call setup_interrupts

    ;far jump este es el segundo descriptor
    ;este se guarda en cs
    call 08h:start_kernel


;se initializa con el primero y se escribe con el segundo

setup_interrupts:

    call remap_pic

    call load_idt

    ret

remap_pic:

    ;inicializa el pic 
    mov al, 11h

    ;initializa el pic master
    out 0x20, al

    ;initializa el pic slave
    out 0xa0, al


    ;move to 32 and 40    
    mov al, 32d

    out 0x21, al

    mov al, 40d

    out 0xa1, al

    ;tell master where slave it is connected 
    mov al, 04h
    
    out 0x21, al

    ;tell slave where it is connected 
    mov al, 02h
    
    out 0xa1, al


    ;architecture x86
    mov al, 01h

    out 0x21, al

    out 0xa1, al

    ;enable all irqs
    mov al, 0h

    out 0x21, al

    out 0xa1, al

    ret


load_idt:
    ret


load_gdt:
    
    ;disable interrupts
    cli

    ;it is a symbol
    ;we load only the offset from current ds

    lgdt [gdtr - start]

    ret

;esto tiene que estar antes de protected mode
init_video_mode:

    ;set video mode
    mov ah, 0h

    ;text mode no gui
    mov al, 03h
    
    ;call bios video services
    int 10h

    ;set the type of the cursor
    mov ah, 01h

    ;disable the cursor
    mov cx, 2000h
    
    ;call bios video services
    int 10h

    ret

enter_protected_mode:

    mov eax, cr0

    ;first bit of cr0 lo esta prendiendo protected mode!
    or eax, 1

    mov cr0, eax

    ret

;this code should be assembled in 32 bit mode
bits 32
start_kernel:

    mov eax, 10h

    mov ds, eax

    mov ss, eax

    mov eax, 0h

    mov es, eax

    mov fs, eax

    mov gs, eax

    ;se prenden los interruptores
    sti

    call kernel_main


%include "gdt.asm"