
//text mode and graphics mode

//vga text mode

volatile unsigned char * video = 0xB8000;

void kernel_main()
{
    video[0] = 'A';

    while(1);
}

