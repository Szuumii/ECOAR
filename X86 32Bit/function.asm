section .text
global  clrsingleones

clrsingleones:
    push    ebp
    mov     ebp, esp
    push    ebx
    mov     eax, [ebp+8]
    xor     ecx, ecx 
    add     cl, 30 ;set iteration coutner
    mov     ebx, 0xE0000000   ;set out mask for 3 bits extraction
    mov     edx, 0x40000000   ;mask for flipping bits
fliploop:
    cmp     cl, 0
    jz      firstdigit

    and     eax, ebx

    dec     cl
    shr     eax, cl

    cmp     eax, 2
    jne     skipflip
    xor     [ebp+8], edx
skipflip:
    mov     eax, [ebp+8]
    shr     ebx,1
    shr     edx,1
    jmp     fliploop

firstdigit:
    mov     eax, [ebp+8]
    mov     ebx, 0xC0000000
    mov     edx, 0x80000000

    and     eax, ebx
    shr     eax, 30
    cmp     eax, 2
    jne     lastdigit
    xor     [ebp+8], edx
lastdigit:
    mov     eax, [ebp+8]
    mov     edx, 0x1
    mov     ebx, 0x3
    and     eax, ebx
    cmp     eax, 1
    jne     end
    xor     [ebp+8], edx

end:
    mov     eax, [ebp+8]
    pop     ebx
    mov     esp,ebp
    pop     ebp
    ret
