section .text
global  clrsingleones

clrsingleones:
    push    rbp
    mov     rbp, rsp
    push    rbx
    mov     rax, rdi
    xor     rdx, rdx 
    add     dl, 30 ;set iteration coutner
    mov     ebx, 0xE0000000   ;set out mask for 3 bits extraction
    mov     ecx, 0x40000000   ;mask for flipping bits
fliploop:
    cmp     edx, 0
    jz      firstdigit

    and     eax, ebx

    dec     dl
    mov     dh, dl

shiftloop:
    cmp     dh, 0
    je      endshift
    shr     eax, 1
    dec     dh
    jmp     shiftloop
endshift:
    cmp     eax, 2
    jne     skipflip
    xor     rdi, rcx
skipflip:
    mov     rax, rdi
    shr     ebx,1
    shr     ecx,1
    jmp     fliploop




firstdigit:
    mov     rax, rdi
    mov     rbx, 0xC0000000
    mov     rcx, 0x80000000

    and     rax, rbx
    shr     eax, 30
    cmp     eax, 2
    jne     lastdigit
    xor     rdi, rcx
lastdigit:
    mov     rax, rdi
    mov     rcx, 0x1
    mov     rbx, 0x3
    and     rax, rbx
    cmp     eax, 1
    jne     end
    xor     rdi, rcx

end:
    mov     rax, rdi
    pop     rbx
    mov     rsp,rbp
    pop     rbp
    ret