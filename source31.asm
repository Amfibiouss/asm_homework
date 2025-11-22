%include "io.inc" 

section .bss
n resd 1
m resd 1
elem resd 1
balance_col resd 100
balance_row resd 100

section .data
format_in db "%d"
format_out_row db "row - %d", 10, 0 
format_out_col db "column - %d", 10, 0 

section .text
global main
main:
    sub esp, 8
    
    push n
    push format_in
    call scanf
    add esp, 8

    push m
    push format_in
    call scanf
    add esp, 8   
    
    mov ecx, dword[n]
    initialize_balance_row:
        mov dword[balance_row + 4 * ecx - 4], 0
        loop initialize_balance_row
    
    mov ecx, dword[m]
    initialize_balance_col:
        mov dword[balance_col + 4 * ecx - 4], 0
        loop initialize_balance_col
    
    mov ecx, 0
    start_cycle1:
        mov edx, 0
        start_cycle2:

            push ecx
            push edx
            push elem
            push format_in
            call scanf
            add esp, 8
            pop edx
            pop ecx 
            
            cmp dword[elem], 0
            jg start_case1
            jl start_case2
            jmp end_case2
            start_case1:; a[ecx][edx] > 0
                inc dword[balance_row + 4 * ecx]
                inc dword[balance_col + 4 * edx]
                jmp end_case2
            end_case1:
            start_case2:; a[ecx][edx] < 0
                dec dword[balance_row + 4 * ecx]
                dec dword[balance_col + 4 * edx]
            end_case2:
                
            inc edx
            cmp edx, dword[m]
            jne start_cycle2
        end_cycle2:
        
        inc ecx
        cmp ecx, dword[n]
        jne start_cycle1
    end_cycle1:
    
    mov ecx, dword[n]
    search_balanced_row:
        cmp dword[balance_row + 4 * ecx - 4], 0
        je was_found_balanced_row
        loop search_balanced_row
        jmp end_search_balanced_row
    was_found_balanced_row:
        push ecx
        push format_out_row
        call printf
        add esp, 8
    end_search_balanced_row:
    
    
    mov ecx, dword[m]
    search_balanced_col:
        cmp dword[balance_col + 4 * ecx - 4], 0
        je was_found_balanced_col
        loop search_balanced_col
        jmp end_search_balanced_col
    was_found_balanced_col:
        push ecx
        push format_out_col
        call printf
        add esp, 8
    end_search_balanced_col:
    
    add esp, 8
    xor eax, eax
    ret