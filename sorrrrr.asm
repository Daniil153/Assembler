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
    
section .text
global CMAIN
CMAIN:
        
        mov     ebp, esp
        and     esp, 0xfffffff0
        sub     esp, 32
        
        mov dword[esp], inp
        mov dword[esp+4], r
        call fopen
        
        mov     dWORD [ebp-8], eax
        mov     dWORD [ebp-12], 0
        jmp     .L6
.L7:
        mov     edx, DWORD [c]
        lea     eax, [ebp-12]
        mov     [esp+4], edx
        mov     [esp], eax
        call    pushl
        
.L6:
        
        ;;;;lea     edx, [ebp-20]
        mov     eax, DWORD [ebp-8]
        mov     [esp], eax
        mov     dword[esp+4], d
        mov     dword[esp+8], c
        call    fscanf
        
        ;mov ebx,dword[c]
        ;PRINT_DEC 4,ebx
        ;NEWLINE
        
        cmp     eax, -1
        jne     .L7
        mov     dword[esp],outp
        mov     dword[esp+4],w
        call    fopen
        mov     DWORD [ebp-16], eax
        jmp     .L8
       
.L9:
        mov     eax, DWORD [ebp-12]
        mov     edx, DWORD [eax]
        PRINT_DEC 4,edx
        NEWLINE
        mov [esp+8],edx;mov     esi, OFFSET FLAT:.LC5
            mov     eax, DWORD [ebp-16]
        mov dword[esp+4],d;mov     edi, eax
        mov [esp],eax;mov     eax, 0
        call    fprintf
        mov     eax, DWORD [ebp-12]
        mov     eax, DWORD [eax+4]
        mov     DWORD [ebp-12], eax
.L8:
        mov     eax, DWORD [ebp-12]
        test    eax, eax
        jne     .L9

        add esp,32
        
        xor eax,eax
        ret
    
    ;;;;;;;;;;;;;;;;ФУНКЦИЯ
    pushl:
        push    ebp
        mov     ebp, esp
        sub     esp, 64
        
        push edi
        push esi
       
        mov edi,[ebp+8]     ;mov     dWORD [ebp-24], edi 
        mov esi,[ebp+12]    ;mov     DWORD [ebp-28], esi
        ;PRINT_DEC 4,edi
        ;PRINT_CHAR 32
        ;PRINT_DEC 4,esi
        ;NEWLINE
        
        mov     dWORD [ebp-24], edi ; указатель на указатель
        mov     DWORD [ebp-28], esi ; число
        
        
        mov     eax, dWORD [ebp-24]
        mov     eax, dWORD [eax]
        test    eax, eax
        je      .L2
        mov     eax, dWORD [ebp-24]
        mov     eax, dWORD [eax]
        mov     eax, DWORD [eax]
        cmp     DWORD [ebp-28], eax
        jge     .L3
.L2:
        mov     dword[esp], 8
        call    malloc
        mov     dWORD [ebp-32], eax ;указатель на выделенную память
        mov     eax, dWORD [ebp-32]
        mov     edx, DWORD [ebp-28]
        mov     DWORD [eax], edx
        
        mov     eax, dWORD [ebp-24]
        mov     edx, dWORD [eax]
        mov     eax, dWORD [ebp-32]
        mov     dWORD [eax+4], edx
        
        mov     eax, dWORD [ebp-24]
        mov     edx, dWORD [ebp-32]
        mov     dWORD [eax], edx
        jmp     .L4
.L3:
        mov     eax, dWORD [ebp-24]
        mov     eax, dWORD [eax] ;*list
        lea     edx, [eax+4] ; адрес (*list)->next
        mov     eax, DWORD  [ebp-28]
        mov     [esp+4], eax
        mov     [esp], edx
        
        call    pushl
.L4:
        
        pop esi
        pop edi
        ;add esp,64
        ;mov esp,ebp
        
        leave
        pop ebp
        ret