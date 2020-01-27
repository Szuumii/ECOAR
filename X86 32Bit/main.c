#include <stdio.h>

unsigned int clrsingleones(unsigned int a);

void binprint(unsigned int v);

int main(int argc, char** argv)
{
    unsigned int value;
    printf("Give unsigned int in hexadecimal: ");
    scanf("%x", &value);
    printf("%x in binary is: \t", value);
    binprint(value);

    printf("%x in fliped is: \t", value);
    binprint(clrsingleones(value));

    return 0;
}

void binprint(unsigned int v)
{
    int c,k;
    for(c = 31; c >=0; c--)
    {
        k = v >> c;
        if(k & 1)
            printf("1");
        else
            printf("0");
    }
    printf("\n");
}