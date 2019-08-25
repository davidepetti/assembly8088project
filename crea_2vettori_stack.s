! Vittorio Ghini 08-03-2014
! A simple program that
! puts two vectors in the stack
! and calls a function 
! that .....


	_PRINTF = 127				
	_GETCHAR = 117				
	_EXIT = 1					
	asciinl = 10
	EOF = -1
.SECT .TEXT	
start:
	PUSH BP
	! imposto il BP affinche' punti al dynamic link
	MOV  BP,SP
creavettore2:
	PUSH 1
	PUSH 3
	PUSH 2
	PUSH 4
	PUSH 0
	PUSH 8
	PUSH 7
	PUSH 9
	PUSH 11
	PUSH 3
creavettore1:
	PUSH 2
	PUSH 6
	PUSH 4
	PUSH 6
	PUSH 8
	PUSH 5
	PUSH 7
	PUSH 4
	PUSH 3
	PUSH 1
mettinumelem:
	PUSH 10
mettiaddrvet2:
	MOV AX,BP
	SUB AX,20
	PUSH AX
mettiaddrvet1:
	SUB AX,20
	PUSH AX
	! inserire qui la chiamata alla funzione 
	call esegui

	! finita la funzione, ripristino lo stack
	! elimino i due indirizzi e numeroelementi dallo stack
	ADD  SP,6
	! elimino vettori dallo stack
	ADD  SP,40

	! stampo il risultato messo in AX
	PUSH AX
	PUSH pfmt
	PUSH _PRINTF
	SYS
	! elimino i parametri passati alla syscall
	ADD  SP,6
	! ripristino il BP caricandolo dal dynamic link
	POP  BP

	! termino processo
	PUSH 0
	PUSH _EXIT
	SYS


usa1:                   
	PUSH BP              
	MOV  BP,SP           
	MOV  SI,4(BP)        
	MOV  CX,6(BP)
	SHR  CX,1
	                           
1:	MOV  BP,SI            
	MOV  AX,(BP)         
	MOV  DI,AX			 
	MUL  DI
	MOV  BP,SP
	ADD  8(BP),AX         
	ADD  SI,4            
	LOOP 1b                        
	POP  BP               				
	RET                   
			
usa2:                     
	PUSH BP                
	MOV  BP,SP            
	MOV  SI,4(BP)         
	MOV  CX,6(BP)
	MOV  AX,0
	MOV  DI,2
	MOV  CX,4

1:	MOV  BP,SI
	ADD  AX,(BP)
	ADD  SI,2
	LOOP 1b	
	MUL  DI
	MOV  BP,SP
	MOV  10(BP),AX
	POP  BP
	RET
		
esegui:
	PUSH BP
	MOV  BP,SP
	SUB  SP,4
	PUSH 8(BP)
	PUSH 4(BP)
	CALL usa1
	ADD  SP,4
	PUSH 8(BP)
	PUSH 6(BP)
	CALL usa2
	MOV  AX,-2(BP)
	ADD  AX,-4(BP)
	ADD  SP,8
	POP  BP
	RET

.SECT .DATA
pfmt: .ASCIZ "The result is %d \n"
.SECT .BSS
STR:	.SPACE 80
		
