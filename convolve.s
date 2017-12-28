.text
.include "xc.inc"
    
.global _convolve
_convolve: 
    push W8
    push W10
    ;W0 is the pointer to the data in X space (signal)
    ;W1 is the length
    ;W2 is the pointer to the data in Y space (filter/IR)
    ;W3 is the ydata length
    
    
    ;W6 and W7 will be the data operands for the MAC instructions
    sub #1, W1
    sub #2, W3
    
    
    DO W1, CDONE
	mov W0, W8 ;W8 will be the MAC pointer for data1
	mov W2, W10 ;W10 will be the MAC pointer for data2	
	clr A, [W8]+=2, W6, [W10]+=2, W7
	REPEAT W3
	    MAC  W6*W7,A, [W8]+=2, W6, [W10]+=2, W7
	MAC  W6*W7,A
CDONE:	SAC A, #0, [W0++]
    
    pop W10
    pop W8
return
    
    
    
