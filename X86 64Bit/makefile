C_FILE=main
ASM_FILE=function
FINAL=program

all: nasm_compile c_compile final_complie
nasm_compile:
	nasm -felf64 -o $(ASM_FILE).o $(ASM_FILE).asm
c_compile:
	gcc -c -g -O0 $(C_FILE).c
final_complie:
	gcc -m64 -o $(FINAL) $(C_FILE).o $(ASM_FILE).o
