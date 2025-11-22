%include "io.inc" 

section .bss
s resb 10000
previous resb 10000

section .data
format_in db "%s", 0
format_out_string db "%s ", 0

section .text
global main
main:
    sub esp, 8
    mov byte[previous], 0
    
    start_cycle:
        push s
        push format_in
        call scanf
        add esp, 8
        
        cmp eax, 0
        jle end_cycle
        
        push previous
        push format_out_string
        call printf
        add esp, 8
        
        
        mov ecx, 0
        start_copy_string:
            mov al, byte[s + ecx]
            mov byte[previous + ecx], al 
            inc ecx
            cmp al, 0
            jnz start_copy_string
 
        jmp start_cycle 
    end_cycle:
    
    add esp, 8
    xor eax, eax
    ret