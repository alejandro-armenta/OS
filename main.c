
//text mode and graphics mode

//vga text mode

//resolution 80 width

//and 25 for the height


volatile unsigned char * video = 0xB8000;


int nextTextPos = 0;
int currLine = 0;


void print(char*);
void prinln();
void printi(int);

void kernel_main()
{
    print("ana");
    
    prinln();
    
    print("alejandro");
  
    prinln();

    printi(12345000);

    while(1);
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

void prinln()
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