section .bss
x resq 1
y resq 1

section .data
format_in db "%d %d", 0   
format_out1 db "-(X/Y +1)/Y^2:            %d", 10, 0 
format_out2 db "1+X^2/3Y:                 %d", 10, 0 
format_out3 db "Y-X/3+1:                  %d", 10, 0 
format_out4 db "(XY)^3 +1/Y:              %d", 10, 0 
format_out5 db "(X^2 + 2*Y - 45) / (X^3): %d", 10, 0 

section .text

extern printf
extern scanf
global main

main:
    sub esp, 8
    push y
    push x
    push format_in
    call scanf
    add esp, 12

    ; -(X/Y +1)/Y^2
    mov eax, [x]
    mov ebx, [y]
    cdq
    idiv ebx
    inc eax
    imul eax, -1
    push eax
    mov eax, [y]
    imul eax
    mov ebx, eax
    pop eax
    cdq
    idiv ebx

    push eax
    push format_out1
    call printf
    add esp, 8
    
    ; 1+X^2/3Y
    mov eax, [x]
    imul eax
    mov ebx, [y]
    add ebx, [y]
    add ebx, [y]
    cdq
    idiv ebx
    inc eax
    
    push eax
    push format_out2
    call printf
    add esp, 8
    
    ; Y-X/3+1
    mov eax, [x]
    mov ebx, -3
    cdq
    idiv ebx
    add eax, [y]
    inc eax
    
    push eax
    push format_out3
    call printf
    add esp, 8
    
    ; (XY)^3 +1/Y 
    mov eax, [x]
    mov ebx, [y]
    imul ebx
    mov ebx, eax
    imul ebx
    imul ebx
    push eax
    mov eax, 1
    cdq
    idiv dword[y]
    mov ebx, eax
    pop eax
    add eax, ebx
    
    push eax
    push format_out4
    call printf
    add esp, 8
    
    ; (X^2 + 2*Y - 45) / (X^3)
    mov eax, [x]
    imul eax
    add eax, [y]
    add eax, [y]
    sub eax, 45
    mov ebx, [x]
    imul ebx, [x]
    imul ebx, [x]
    cdq
    idiv ebx
    
    push eax
    push format_out5
    call printf
    add esp, 8
    

    add esp, 8
    xor eax, eax
    ret