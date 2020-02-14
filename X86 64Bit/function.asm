section .text
global  clrsingleones

clrsingleones:
    push    rbp
    mov     rbp, rsp
    mov     eax, edi
    xor     ecx, ecx 
    mov     cl, 30 ;set iteration coutner
    mov     r8d, 0xE0000000   ;set out mask for 3 bits extraction
    mov     edx, 0x40000000   ;mask for flipping bits
fliploop:
    cmp     cl, 0
    jz      firstdigit

    and     eax, r8d

    dec     cl
    shr     eax, cl

    cmp     eax, 2
    jne     skipflip
    xor     edi, edx
skipflip:
    mov     eax, edi
    shr     r8d,1
    shr     edx,1
    jmp     fliploop

firstdigit:
    mov     eax, edi
    and     eax, 0xC0000000
    shr     eax, 30
    cmp     eax, 2
    jne     lastdigit
    xor     edi, 0x80000000
lastdigit:
    mov     eax, edi
    and     eax, 3
    cmp     eax, 1
    jne     end
    xor     edi, 1

end:
    mov     eax, edi
    mov     rsp,rbp
    pop     rbp
    ret
