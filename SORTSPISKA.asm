%include "io.inc"

CEXTERN fopen
CEXTERN fscanf
CEXTERN fprintf
CEXTERN malloc

section .rodata
    inp db "/home/daniil/asm/input.txt", 0
    outp db "/home/daniil/asm/output.txt", 0
    r db "r",0
    w db "w",0
    d db "%d ",0

section .bss
    c resd 1
    list resd 1
    node resd 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    and esp, -16
    sub esp, 16
    
    xor edi,edi
    
    mov dword[list],0
    mov dword[esp], inp
    mov dword[esp+4], r
    call fopen
    mov esi,eax
    
  .0:
    mov dword[esp],esi
    mov dword[esp+4],d
    mov dword[esp+8],c
    call fscanf
    
    cmp eax,-1      
    jz .1
    mov edi,dword[c]
    mov dword[esp],list
    mov dword[esp+4],edi
    call pushlist
    jmp .0
  .1:
  
  
    mov dword[esp], outp
    mov dword[esp+4], w
    call fopen
    mov esi,eax
    
  .2:
    cmp dword[list],0
    jz .3
    mov edi,dword[list]
    mov edi,[edi]
    mov dword[esp],esi
    mov dword[esp+4],d
    mov dword[esp+8],edi
    call fprintf
    mov edi,dword[list]
    mov edi,[edi+4]
    mov dword[list],edi
    jmp .2
  .3:
  
    add esp,16
    mov esp, ebp
    xor eax, eax
    ret
    
  pushlist:
    
    push ebp
    mov ebp,esp
    push esi
    push edi
    push ebx
    sub esp,24
    mov esi,dword[ebp+8];LIST &list адпес указателя
    mov esi,dword[esi] ;list
    mov edi,dword[ebp+12]   ;int number
    mov ebx,dword[esi]; ТУТ ПАДАЕТ
    ;if
    
    cmp esi,0
    jz .second    
    ;mov ecx,[ebx]

    cmp ebx,edi
    jnl .lend
  .second:
    mov dword[esp],8
    call malloc
    mov dword[node],eax
    mov [eax],edi
    mov [eax+4],esi
    mov esi,dword[node]
    jmp .end
    
  .lend:;else
    lea edx,[esi+4]
    mov dword[esp],edx
    mov dword[esp+4],edi
    call pushlist
      
  .end:
    add esp,24
    pop ebx
    pop edi
    pop esi
    mov esp,ebp
    pop ebp
    ret
    