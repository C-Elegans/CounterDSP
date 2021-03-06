.text
.include "xc.inc"
    
.global _convolve
_convolve: 
	push W8
	push W10
	;;W0 is the pointer to the data in X space (signal)
	;;W1 is the length
	;;W2 is the pointer to the data in Y space (filter/IR)
	;;W3 is the ydata length
	
	
	;;W6 and W7 will be the data operands for the MAC instructions
	sub #1, W1
	sub #2, W3
	
    
	DO W1, 1f
	mov W0, W8 ;W8 will be the MAC pointer for data1
	mov W2, W10 ;W10 will be the MAC pointer for data2	
	clr A, [W8]+=2, W6, [W10]+=2, W7
	REPEAT W3
	MAC  W6*W7,A, [W8]+=2, W6, [W10]+=2, W7
	MAC  W6*W7,A
1:	SAC A, #0, [W0++]
	
	pop W10
	pop W8
return
    
_scalepadbuffer:
	;; W0 = pointer to the collected samples
	;; W1 = pointer to the destination buffer
	
	;; Normalize the samples to 0 and divide by 2 for fft
	MOV [W0], W3
	DO #511, 1f
	MOV [W0++], W2
	SUB W2, W3, W2
	ASR W2, #1, W2
1:	MOV W2, [W1++]

	;; Pad the buffer with 0s
	MOV #0, W2
	ADD W1, #2, W0
	REPEAT #511
	MOV W2, [W1++]
	return
.global _vmul
_vmul:
	
	;; W0 = source buffer 1 / dest buffer
	;; W1 = source buffer 2
	;; W2 = Count
	push W13
	push W10
	push W8
	MOV W0, W13
	MOV W0, W8
	MOV W1, W10
	SUB W2, #1, W2

	;; Prime the loop
	CLR A, [W8]+=2, W4, [W10]+=2, W5

	DO W2, 1f
	MPY W4*W5, A 
1: 	MOVSAC B, [W8]+=2, W4, [W10]+=2, W5, [W13]+=2

	pop W8
	pop W10
	pop W13
	return

.global _vsquare
_vsquare:	
	;; W0 = source/dest
	;; W1 = count
	push W13
	push W8
	sub W1, #1, W1
	mov W0, W13
	mov W0, W10
	CLR A, [W10]+=2, W4

	DO W1, 1f
	mpy W4*W4, A
1:	movsac B, [W10]+=2, W4, [W13]+=2

	pop W10
	pop W13
	return

.global _vshl
_vshl:	
	;; W0 = Source/dest
	;; W1 = count
	;; W2 = shift
	sub W1, #1, W1
	DO W1, 1f
	mov [W0], W3
	sl W3, W2, W3
1:	mov W3, [W0++]
	return

	
    
.globl _count_spikes
_count_spikes:			; W0 - pointer to data, W1 - count,
	                        ; W2 - threshold,		
	mov W0, W3		; W3 now pointer to data
	mov #0, W0		; W0 count of spikes
	mov #0, W5
	mov #0b1111, W6		; For compare and skip
	sub W1, #1, W1

	DO W1, 1f
	mov [W3++], W4
	cp W4, W2
	rlc W5, W5		; shift C into W5
	cpsne W5, W6		; If W5!=W6, skip the next instruction
1: 	add W0, #1, W0		; Add only if W5=W6

	return
	
