C_FILE=main
ASM_FILE=function
FINAL=program

all: nasm_compile c_compile final_complie
nasm_compile:
	nasm -o $(ASM_FILE).o -f elf32 -l $(ASM_FILE).lst $(ASM_FILE).asm
c_compile:
	gcc -m32 -c -g -O0 $(C_FILE).c
final_complie:
	gcc -m32 -o $(FINAL) $(C_FILE).o $(ASM_FILE).o
