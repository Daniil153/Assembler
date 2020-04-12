%include "io.inc"

CEXTERN qsort
CEXTERN fopen
CEXTERN fscanf
CEXTERN fprintf

section .rodata
    d db "%d ",0
    inp db "input.txt", 0
    r db "r",0
    w db "w",0
    outp db "output.txt", 0
    
section .bss
    mas resd 1000
    n resd 1
    output resd 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    and esp, -16
    sub esp, 16
    
    xor esi,esi
    xor edi,edi
    
    mov dword[esp], inp
    mov dword[esp+4], r
    call fopen
    ;mov dword[read_file], eax
    mov esi,eax
    mov ebx,mas
  .0:
    mov dword[esp],esi
    mov dword[esp+4],d
    mov dword[esp+8],ebx
    call fscanf
    add ebx,4
    cmp eax,-1
    jz .9
    inc edi
    jmp .0
  .9:
    
    mov dword[esp],mas
    mov dword[esp+4],edi
    mov dword[esp+8],4
    mov dword[esp+12],comp
    call qsort
    
    mov dword[esp], outp
    mov dword[esp+4], w
    call fopen
    mov dword[output],eax
    
    mov ebx,mas
    xor esi,esi
    
  .2:
    mov edx,dword[output]
    mov ecx,[ebx]
    mov dword[esp],edx
    mov dword[esp+4],d
    mov dword[esp+8],ecx
    call fprintf
    add ebx,4
    inc esi
    cmp esi,edi
    jl .2
    
    
    add esp,16
    mov esp, ebp
    xor eax, eax
    ret
    
  comp:
    push ebp
    mov ebp,esp
    
    mov ecx,dword[ebp+12]
    mov eax,dword[ebp+8]
    mov eax,[eax]
    mov ecx,[ecx]
    cmp eax,ecx
    jg .5
    mov eax,0
    jmp .end
  .5:
    mov eax,1
  .end:
    mov esp,ebp
    pop ebp
    ret