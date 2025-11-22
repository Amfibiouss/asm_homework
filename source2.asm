%include "io.inc" 

section .bss
x resq 1
a resq 1
y1 resq 1
y2 resq 1
res resq 1

section .data
two dq 2.0
three dq 3.0
five dq 5.0
seven dq 7.0
nine dq 9.0
fifteen dq 15.0


format_in db "%lf %lf", 0   
format_out db "x = %f: y = %f", 10, 0 

section .text

extern printf
extern scanf
global main
main:
    mov ebp, esp; for correct debugging
    finit

    sub esp, 8
    push a
    push x
    push format_in
    call scanf
    add esp, 12
    
    mov ecx, 10

    start_cycle:
        fld qword[seven]
        fld qword[x]
        fcompp 
        fstsw ax
        sahf
        jbe case2_start
        case1_start:; x > 7: y1 = x + 15
            fld qword[x]
            fld qword[fifteen]
            fadd
            fstp qword[y1]
            jmp case2_end
        case1_end:
        case2_start:; x <= 7: y1 = abs(a) + 9
            fld qword[a]
            fabs
            fld qword[nine]
            fadd
            fstp qword[y1]
        case2_end:
        
        
        fld qword[two]
        fld qword[x]
        fcompp 
        fstsw ax
        sahf
        jbe case4_start
        case3_start:; x > 2: y2 = 3
            fld qword[three]
            fstp qword[y2]
            jmp case4_end
        case3_end:
        case4_start:; x <= 2: y2 = abs(x) - 5
            fld qword[x]
            fabs
            fld qword[five]
            fsub
            fstp qword[y2]
        case4_end:
        
        fld qword[y1]; y = y1/y2
        fld qword[y2]   
        fdiv
        fstp qword[res]

        push ecx
        push dword[res + 4]
        push dword[res]
        push dword[x + 4]
        push dword[x]
        push format_out
        call printf
        add esp, 20
        pop ecx
        
        
        fld qword[x] 
        fld1 
        fadd
        fstp qword[x]
        
        dec ecx
        jnz start_cycle
    end_cycle:

    add esp, 8
    xor eax, eax
    ret