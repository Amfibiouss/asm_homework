%include "io.inc"

struc car
    .brand resb 20
    .model resb 20
    .year resd 1
endstruc 

section .bss
    cars resb car_size * 10
    fd1 resd 1
    fd2 resd 1

section .data
    input_file db "C:\Users\slaaa\Desktop\assembler\input.txt", 0
    input_mode db "r", 0
    output_file db "C:\Users\slaaa\Desktop\assembler\output.txt", 0
    output_mode db "w", 0
    format_in db "%s %s %d", 0
    format_out db "%s %s %d", 10, 0
    twenty_twenty_two dd 2022
    
section .text
global main
extern fopen
extern fscanf
extern fprintf
extern printf
extern fclose

main:
    sub esp, 8

    push input_mode
    push input_file
    call fopen
    add esp, 8
    mov [fd1], eax
    
    push output_mode
    push output_file
    call fopen
    add esp, 8
    mov [fd2], eax
    
    mov ecx, 0
    
    start_cycle:
        push ecx
        lea eax, [cars + ecx + car.year]
        push eax
        lea eax, [cars + ecx + car.model]
        push eax
        lea eax, [cars + ecx + car.brand]
        push eax
        push format_in
        push dword[fd1]
        call fscanf
        add esp, 20
        pop ecx
        
        cmp eax, 0
        jle end_cycle
        
        mov eax, dword[twenty_twenty_two]
        mov dword[cars + ecx + car.year], eax
        
        push ecx
        push dword[cars + ecx + car.year]
        lea eax, [cars + ecx + car.model]
        push eax
        lea eax, [cars + ecx + car.brand]
        push eax
        push format_out
        push dword[fd2]
        call fprintf
        add esp, 20
        pop ecx
        
        add ecx, car_size
        jmp start_cycle
    end_cycle:
    
    push dword[fd1]
    call fclose
    add esp, 4
    
    push dword[fd2]
    call fclose
    add esp, 4

    add esp, 8
    xor eax, eax
    ret