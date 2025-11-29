.data
prompt1:   .asciz "Введите x: "
prompt2:   .asciz "Введите a: "
newline:   .asciz "\n"
x: .float 0.0
a: .float 0.0
.text
.globl __start

__start:
    la a0, prompt1
    li a7, 4         
    ecall
 
    li a7, 6
    ecall
    fmv.s fs0, fa0 # x в fs0   
    
    la a0, prompt2
    li a7, 4         
    ecall
    
    li a7, 6
    ecall
    fmv.s fs1, fa0 # a в fs1
 	
 	li s0, 0
 	for:
 		li t0, 10
 		bge s0, t0, end_for
 		
	    li t0, 7
	    fcvt.s.w ft0, t0
	    fle.s t0, fs0, ft0 
	    bnez t0, x_less_or_equal_than_seven
	    x_more_than_seven: # x > 7: y1 = 15 + x1
	        	li t0, 15
	    		fcvt.s.w ft0, t0
	    		fadd.s fs2, ft0, fs0
	    		j end_if1 
	    x_less_or_equal_than_seven: # x <= 7: y1 = abs(a) + 9
	    		fabs.s ft0, fs1
	        	li t0, 9
	    		fcvt.s.w ft1, t0
	    		fadd.s fs2, ft0, ft1
	    	end_if1:
	    	  		
	    	li t0, 2
	    	fcvt.s.w ft0, t0
	
	    fle.s t0, fs0, ft0 
	    bnez t0, x_less_or_equal_than_two
	    x_more_than_two: # x > 2: y2 = 3
	        	li t0, 3
	    		fcvt.s.w fs3, t0
	    		j end_if2
	    x_less_or_equal_than_two: # x <= 2: y2 = abs(x) - 5
	        	li t0, 5
	    		fcvt.s.w ft0, t0
	    		fabs.s ft1, fs0
	    		fsub.s fs3, ft1, ft0
	    end_if2:
	    
		fdiv.s fa0, fs2, fs3
		li a7, 2
	    ecall
	    
		la a0, newline
		li a7, 4
	    ecall
	    
	    	li t0, 1
	    	fcvt.s.w ft0, t0
	    fadd.s fs0, fs0, ft0
	    addi s0, s0, 1
	    j for
	end_for:
	
    li a7, 10
    ecall
