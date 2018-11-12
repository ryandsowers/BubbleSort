;Code modified/updated by Ryan Sowers
;Submitted: 02/07/2018
;CS3140 Assignment 1
;Assemble: 	nasm -f elf64 -g assign1test.asm
;Link:		ld -o assign1test -m elf_x86_64 assign1test.o
;Run:		./assign1test

bits 64

section .text	;section declaration 

global _start

_start:
	mov	edx, 19
	xor	r8d, r8d	;clear registers
	xor	r9d, r9d
	
outerloop:
	mov	ecx, 0
	xor 	r10d, r10d	;reset no swap flag to zero
	inc	r8d		;used as incrementor for outerloop passes
innerloop:
	mov	eax, [array + ecx * 4]		;move indexed array value to eax
	mov	ebx, [array + 4 + ecx * 4]	;move indexed+1 array value to eax
 	cmp	eax, ebx
	jge 	next
	
	inc	r10d		;used to signify swap occurred (flag)

	mov	[array + ecx * 4], ebx		;swapping array values
	mov 	[array + 4 + ecx * 4], eax
	inc 	r9d		;used as incrementor for innerloop/swaps
next:
	inc 	ecx
	cmp 	ecx, edx
	jl	innerloop
endinner:
	cmp	r10d, 0		;if swap flag has been tripped...
	jnz	outerloop	;...all numbers are not ordered. 

	mov	[passes], r8d	;move passes count to 'passes' var
	mov	[swaps], r9d	;move swaps count to 'swaps' var

	xor	ecx, ecx	;clear register
newarray:
	mov	r11d, [array + ecx * 4]		;copy contents of 'array' into 'output'
	mov	[output + ecx * 4], r11d
	inc	ecx
	cmp	ecx, 20
	jne	newarray

done:	
	mov 	edi, [swaps]	;first syscall argument: exit code of 'swaps'
	mov	eax, 60		;system call number (sys_exit)
	syscall			;"trap" to kernel

section .data 		;section declaration

;This variable must remain named exactly 'array'
array: 	dd	7, 11, 4, 5, 19, 20, 8, 10, 9, 15, 6, 16, 12, 3, 2, 17, 14, 13, 1, 18 
passes: dd	0
swaps: 	dd	0

section .bss

output:	resd 20	








