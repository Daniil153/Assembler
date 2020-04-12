%include "io.inc"

section .data
    sum dd 0
    fuc1 dd 1
    fuc2 dd 1
    a dd 0
    sum2 dd 0
    i dd 1
    nul dd 0
    b dd 0
    c dd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4,eax
    GET_DEC 4,ebx
    mov dword[c],eax
    mov dword[b],ebx
    mov ebp,ebx ;ebp=c
    bsr esi,eax
    mov ecx,ebx
    cmp ebx,esi
    js .0
    jmp .3
  .0:
    
    cmp ecx,ebx
    jz .8
    
    mov ebp,ecx
    mov edi,1
    mov ecx,ebx
    add ecx,1
  .1:
    imul edi,ecx
    add ecx,1
    cmp ebp,ecx
    jns .1
    mov dword[fuc1],edi
    mov ecx,1
    mov edi,1
    mov edx,ebp
    sub edx,ebx
  .2:
    imul edi,ecx
    add ecx,1
    cmp edx,ecx
    jns .2
    
    xor edx,edx
    
    mov dword[fuc2],edi
    mov eax,dword[fuc1]
    mov edi,dword[fuc2]
    cdq
    idiv edi
    add dword[sum],eax
    mov ecx,ebp
    jmp .9
  .8:
    add dword[sum],1
  .9:
    add ecx,1
    
    cmp ecx,esi
    jz .3
    jmp .0
  .3:
  
    ;sum - старая сумма
    ;dword[a] -исходное число
    ;esi - номер бита с 0 (максимальная единица)
    
    mov eax,dword[c] ;20 -исходное число
    ;mov esi,esi ;4 - максимальная значимая единица
    mov edi,dword[b] ;3 - сколько нулей нужно найти
    mov ebx,esi ; ebx=4
    mov esi,eax ; esi=20
    mov cl,bl ;cl=4
    mov ebp,1 ;ebp=1
    shl ebp,cl ;ebp=16
    and esi,ebp
    mov dword[a],esi
    mov cl,0

  .4:
    mov esi,dword[a]
    and esi,dword[i]
    shr esi,cl
    xor esi,1
    
    mov edx,dword[i]
    imul edx,2
    mov dword[i],edx
    
    add dword[nul],esi
    movzx ebp,cl
    add cl,1
    cmp ebp,ebx
    js .4
    
    cmp dword[nul],edi
    jz .5
    jmp .6
  .5:
    add dword[sum2],1
  .6:
    add dword[a],1
    
    mov dword[nul],0
    mov cl,0
    mov dword[i],1
    
    cmp eax,dword[a]
    jns .4
   
    
    mov eax,dword[sum]
    add eax,dword[sum2]
    PRINT_DEC 4,eax
    
    xor eax, eax
    ret