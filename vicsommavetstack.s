! This program sums the elements of a vector
! in the stack

_EXIT	= 1		
_PRINTF	= 127
.SECT .TEXT	
start:
	PUSH BP		! dynamic link
	MOV  BP,SP
	
	MOV  CX,10		! numero elementi vettore, 10

!	carico elementi sullo stack in ordine opposto, 
!	dall'ultimo al primo, 
!	cioe' il primo sta all'indirizzo piu' basso
!	la somma dei 10 elementi dovrebbe essere 39
	PUSH 3
	PUSH 5
	PUSH 2
	PUSH 7
	PUSH 3
	PUSH 4
	PUSH 2
	PUSH 1
	PUSH 3
	PUSH 9

	MOV  BP,SP	! ora BP punta all'inizio del vettore

					! uso il registro AX come accumulatore
	MOV  AX,0		! all'inizio la somma e' ZERO
	MOV  DI,0		! uso DI come offset rispetto a BP
somma:
	CMP	 CX,0
	JZ   finesomma
	ADD  AX,(BP)(DI)
	ADD  DI,2
	DEC  CX
	JMP  somma
finesomma:

	ADD  SP,20		! elimino il vettore dallo stack cioe' 10*2 bytes

	PUSH AX		 
	PUSH pfmt	 
	PUSH _PRINTF
	SYS

	ADD SP,6
	POP  BP		 !	rimetto in BP il vecchio valore salvato sullo stack, e' inutile ma facciamolo

	PUSH 0	
	PUSH _EXIT
	SYS	


.SECT .DATA		 
pfmt: .ASCIZ "The sum is %d!\n"
.SECT .BSS 
inprod:	.SPACE 2
