%include "io.inc"

CEXTERN fopen
CEXTERN fscanf
CEXTERN fprintf
CEXTERN malloc
CEXTERN strcmp
CEXTERN qsort
CEXTERN printf

section .rodata
    inp db "/home/daniil/asm/input.txt", 0
    outp db "/home/daniil/asm/output.txt", 0
    r db "r",0
    w db "w",0
    d db "%d ",0
    s db "%s ",0
    u db  "-1", `\n`, 0
    ddd db "%d", `\n`,0
    
section .bss
    c resd 1
    list resd 1
    node resd 1
    n resd 1
    m resd 100000
    mas resd 1
    stroka resb 101
    file resd 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    and esp, -16
    sub esp, 32
    
    mov dword[esp], inp
    mov dword[esp+4], r
    call fopen
    mov dword[file],eax
    mov esi,eax
    
    mov dword[esp],esi
    mov dword[esp+4],d
    mov dword[esp+8],n
    call fscanf
  
    xor edi,edi
    mov ebx,mas
  .0:
    mov dword[esp],8
    call malloc
    mov dword[ebx],eax
    mov esi,dword[ebx]
    mov dword[esp],104
    call malloc
    
    mov dword[esi],eax
    mov esi,dword[file]
    mov dword[esp],esi
    mov dword[esp+4],s
    mov dword[esp+8],eax
    call fscanf
    
    mov ecx,dword[ebx]
    add ecx,4
    mov dword[esp],esi
    mov dword[esp+4],d
    mov dword[esp+8],ecx
    call fscanf 
    add ebx,4
    inc edi
    cmp edi,dword[n]
    jl .0
   ;
    
    mov ecx,dword[n]
    mov dword[esp],mas
    mov dword[esp+4],ecx
    mov dword[esp+8],4
    mov dword[esp+12],sf
    call qsort  
    
        ;mov ebx,mas
        ;mov ebx,[ebx+4]
        ;mov ebx,[ebx]
        ;mov dword[esp],s
        ;mov dword[esp+4],ebx
        ;call printf
        ;NEWLINE   
    
    mov dword[esp], outp
    mov dword[esp+4], w
    call fopen
    mov esi,eax
    
    xor edi,edi
  .1:
    mov dword[esp],esi
    mov dword[esp+4],s
    mov dword[esp+8],stroka
    call fscanf
    mov dword[esp],stroka
    mov dword[esp+4],mas
    mov dword[esp+8],-1
    mov edx,dword[n]
    mov dword[esp+12],edx
    mov dword[esp+16],esi
    call binpoisk

    inc edi
    cmp edi,dword[n]
    jl .1
    
    add esp,32
    mov esp, ebp
    xor eax, eax
    ret
    
    
binpoisk:
    push ebp
    mov ebp,esp
    push edi
    push esi
    push ebx
    sub esp,32
    
    mov esi,dword[ebp+16] ; l
    mov edi,dword[ebp+20] ; r
    PRINT_DEC 4,esi
    PRINT_CHAR 32
    PRINT_DEC 4,edi
    PRINT_CHAR 32
    mov eax,esi     ;l
    add eax,edi ;l+r
    mov ecx,2
    cdq
    idiv ecx
    mov ebx,eax ;(l+r)/2
    
    PRINT_DEC 4,ebx
    NEWLINE
    
    dec edi ;r-1
    cmp esi,edi ;if(l==r-1)
   jnz .3

    mov ecx,dword[ebp+24]
    mov dword[esp],ecx
    mov dword[esp+4],u
    call fprintf
    jmp .end
  .3:
    ;else

    mov edi,dword[ebp+8] ;*s
    mov dword[esp],edi
    mov esi,mas
    mov eax,ebx
    imul eax,4
    add esi,eax
    ;PRINT_DEC 4,esi
    mov esi,[esi]
    mov esi,[esi]
    mov dword[esp+4],esi
    call strcmp
    mov esi,eax
    cmp esi,0
    jnz .4
    mov eax,dword[ebp+24]
    mov dword[esp],eax
    mov dword[esp+4],ddd
    mov eax,mas
    mov ecx,ebx
    imul ecx,4
    add eax,ecx
    mov eax,[eax]
    add eax,4
    mov eax,[eax]
    mov dword[esp+8],eax
    call fprintf
    jmp .end
  .4:  
    
    cmp esi,0
    jl .5
    mov eax,dword[ebp+8]
    mov dword[esp],eax
    mov eax,dword[ebp+12]
    mov dword[esp+4],eax
    mov dword[esp+8],ebx
    mov eax,dword[ebp+20]
    mov dword[esp+12],eax
    mov eax,dword[ebp+24]
    mov dword[esp],eax
    call binpoisk
    jmp .end
  .5:
  
    mov eax,dword[ebp+8]
    mov dword[esp],eax
    mov eax,dword[ebp+12]
    mov dword[esp+4],eax
    mov eax,dword[ebp+16]
    mov dword[esp+8],eax 
    mov dword[esp+12],ebx

    mov eax,dword[ebp+24]
    mov dword[esp],eax
    call binpoisk
    
  .end:
    add esp,32
    pop ebx
    pop esi
    pop edi
    mov esp,ebp
    pop ebp
    ret


sf:
    push ebp
    mov ebp,esp
    sub esp,16
    mov eax,dword[ebp+8]
    mov edx,dword[ebp+12]
    
    mov eax,[eax]
    mov eax,[eax] 
    mov edx,[edx]
    mov edx,[edx]
    
   
    mov [esp],eax
    mov [esp+4],edx
    call strcmp
    
    add esp,16
    mov esp,ebp
    pop ebp
    ret