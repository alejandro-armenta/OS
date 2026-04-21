;lo iba a builear como 32
bits 16
extern kernel_main

start:

    mov ax, cs
    mov ds, ax

    call load_gdt

    call init_video_mode

    call enter_protected_mode

    call setup_interrupts

    call 08h:start_kernel

setup_interrupts:
    ret

load_gdt:
    
    ;disable interrupts
    cli

    ;it is a symbol
    ;we load only the offset from current ds

    lgdt [gdtr - start]

    ret

init_video_mode:

enter_protected_mode:

start_kernel:


%include "gdt.asm"