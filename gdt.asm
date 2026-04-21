gdt:
    ;usan este gs,es,
    null_descriptor             : dw 0,0,0,0

    ;este se usa por el codigo
    kernel_code_descriptor      : dw 0xffff, 0x0000, 0x9a00, 0x00cf
    
    ;estas usando este descriptor

    ;este se usa por la data
    
    kernel_data_descriptor      : dw 0xffff, 0x0000, 0x9200, 0x00cf

    userspace_code_descriptor   : dw 0xffff, 0x0000, 0xfa00, 0x00cf    
    userspace_data_descriptor   : dw 0xffff, 0x0000, 0xf200, 0x00cf

gdtr:

    ;lo que estar guardando tiene que ser un define word 16 bits
    gdt_size_in_bytes   : dw (5*8)

    ;loads full address without segmentation
    gdt_base_address    : dd gdt

    


