
//text mode and graphics mode

//vga text mode

//resolution 80 width

//and 25 for the height
/*

programable interrupt controller

master pic

double fault and irq0

send commands to 

master PIC 20h 21h
slave PIC a0h a1h

write data on PIC so it can read it

initialize PIC



*/

volatile unsigned char * video = 0xB8000;


int nextTextPos = 0;
int currLine = 0;


void print(char*);
void println();
void printi(int);

void kernel_main()
{
    print( "Welcome to alex kernel!" );
    println();
    print( "We are now in Protected-mode" );
    println();
    printi( 539 );
    println();

    while(1);
}

void interrupt_handler(int interrupt_number)
{
    println();
    print("Interrupt Received ");
    printi(interrupt_number);
}

void print(char* str)
{
    int currLoc;
    int currCol;

    while(*str != '\0')
    {

        currLoc = nextTextPos * 2;
        currCol = currLoc + 1;

        video[currLoc] = *str;
        video[currCol] = 15;

        nextTextPos++;
        str++;
    }
}

void println()
{
    nextTextPos = ++currLine * 80;
}

void printi(int number)
{
    char * digitToStr[] = {
        "0","1","2","3","4","5","6","7","8","9"
    };

    if (number >= 0 && number <= 9)
    {
        print(digitToStr[number]);
    }
    else
    {   
        printi(number / 10);
        printi(number % 10);
    }
}