.data
input_file:   .asciz "C:/Users/slaaa/Desktop/assembler/input.bin"
output_file:  .asciz "C:/Users/slaaa/Desktop/assembler/output.bin"
newline:      .asciz "\n"
.align 2
buffer: .space 4
array: .space 10000
.text
.globl __start

 			

__start:

	la a0, input_file
    li a1, 0
    li a7, 1024 # open input_file
    ecall
    mv s0, a0 
    
    
    mv a0, s0
    la a1, buffer
    li a2, 1
    li a7, 63 # read
    ecall
    la t0, buffer
    lb s1, 0(t0)
    
      
   	mul t0, s1, s1
	slli t0, t0, 2
    mv a0, s0
    la a1, array
    mv a2, t0
    li a7, 63 # read
    ecall
    
    mv a0, s0
    li a7, 57 # close
    ecall
    
    
    	la a0, output_file
    li a1, 1
    li a7, 1024 # open_output_file
    ecall
    mv s0, a0 
    
    
    	li s2, 0 # отражаем по горизонтали
	reverse_rows_for1:
 		bge s2, s1, end_reverse_rows_for1
 		
 		li s3, 0
 		reverse_rows_for2:
 			bge s3, s1, end_reverse_rows_for2
 			
 			addi t0, s1, -1
 			sub t0, t0, s2
 			mul t0, t0, s1
 			add t0, t0, s3
			slli t0, t0, 2
 			
 		
 			la t1, buffer
 			la t2, array
 			add t2, t2, t0
 			lw t3, 0(t2)
 			sw t3, 0(t1)
 			
 			la a0, buffer
 			call reverse_bytes
 			
		    mv a0, s0
		    la a1, buffer
		    li a2, 4
		    li a7, 64 # write
		    ecall
		    
 			addi s3, s3, 1
			j reverse_rows_for2
 			
 		end_reverse_rows_for2:
		
		addi s2, s2, 1
		j reverse_rows_for1
	end_reverse_rows_for1:
    
    
	li s2, 0 # отражаем по вертикали
	reverse_columns_for1:
 		bge s2, s1, end_reverse_columns_for1
 		
 		li s3, 0
 		reverse_columns_for2:
 			bge s3, s1, end_reverse_columns_for2
 			
 			addi t0, s1, -1
 			sub t0, t0, s3
 			mv t1, s2
 			mul t1, t1, s1
 			add t0, t0, t1 # a[i][n - 1 - j]
			slli t0, t0, 2
 			
 		
 			la t1, buffer
 			la t2, array
 			add t2, t2, t0
 			lw t3, 0(t2)
 			sw t3, 0(t1)
 			
 			la a0, buffer
 			call reverse_bytes
 			
		    mv a0, s0
		    la a1, buffer
		    li a2, 4
		    li a7, 64 # write
		    ecall
		 
 			
 			addi s3, s3, 1
			j reverse_columns_for2
 			
 		end_reverse_columns_for2:
		
		addi s2, s2, 1
		j reverse_columns_for1
	end_reverse_columns_for1:
	
	
	li s2, 0 # отражаем по диагонали
	reverse_diags_for1:
 		bge s2, s1, end_reverse_diags_for1
 		
 		li s3, 0
 		reverse_diags_for2:
 			bge s3, s1, end_reverse_diags_for2
 			
 			mul t0, s3, s1
 			add t0, t0, s2
			slli t0, t0, 2
 
 		
 			la t1, buffer
 			la t2, array
 			add t2, t2, t0
 			lw t3, 0(t2)
 			sw t3, 0(t1)
 			
 			la a0, buffer
 			call reverse_bytes
 			
		    mv a0, s0
		    la a1, buffer
		    li a2, 4
		    li a7, 64 # write
		    ecall
		 
 			
 			addi s3, s3, 1
			j reverse_diags_for2
 			
 		end_reverse_diags_for2:
		
		addi s2, s2, 1
		j reverse_diags_for1
	end_reverse_diags_for1:
	
	li s2, 0 # отражаем по побочной диагонали
	reverse_rev_diags_for1:
 		bge s2, s1, end_reverse_rev_diags_for1
 		
 		li s3, 0
 		reverse_rev_diags_for2:
 			bge s3, s1, end_reverse_rev_diags_for2
 			
 			addi t0, s1, -1
 			addi t1, s1, -1
 			sub t0, t0, s2
 			sub t1, t1, s3
 			mul t1, t1, s1
 			add t0, t0, t1
			slli t0, t0, 2
 
 		
 			la t1, buffer
 			la t2, array
 			add t2, t2, t0
 			lw t3, 0(t2)
 			sw t3, 0(t1)
 			
 			la a0, buffer
 			call reverse_bytes
 			
		    mv a0, s0
		    la a1, buffer
		    li a2, 4
		    li a7, 64 # write
		    ecall
		 
 			
 			addi s3, s3, 1
			j reverse_rev_diags_for2
 			
 		end_reverse_rev_diags_for2:
		
		addi s2, s2, 1
		j reverse_rev_diags_for1
	end_reverse_rev_diags_for1:
 
 	mv a0, s0
    li a7, 57 # close
    ecall

    li a7, 10
    ecall
    
reverse_bytes:
 	mv t0, a0 # меняем 1 и 4 байт
 	addi t1, t0, 3
 	lb t2, 0(t0)
 	lb t3, 0(t1)
 	sb t2, 0(t1)
 	sb t3, 0(t0)
 	
 	mv t0, a0 # меняем 2 и 3 байт
 	addi t0, t0, 1
 	addi t1, t0, 2
 	lb t2, 0(t0)
 	lb t3, 0(t1)
 	sb t2, 0(t1)
 	sb t3, 0(t0)
 	
 	ret
