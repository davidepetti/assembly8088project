! This program multiplies two vectors
! It shows a subroutine with arguments and
! a local variable. See section 9.8.3.

_EXIT	= 1		 !  1
_PRINTF	= 127		 !  2
.SECT .TEXT		 !  3
inpstart:		 !  4
	MOV  BP,SP	 !  5 metto il BP l'indirizzo del dynamic link
	PUSH vec2	 !  6 aggiungo sullo stack l'indirizzo di inizio del vettore vec2
	PUSH vec1	 !  7 aggiungo sullo stack l'indirizzo di inizio del vettore vec1
	MOV CX,vec2-vec1 !  8 aggiungo sullo stack il numero di byte del vettore vec1
	SHR  CX,1	 !  9 divido per due per ottenere il numero di interi del vettore vec1
	PUSH CX		 ! 10 aggiungo sullo stack il numero di elementi interi del vettore vec1
	CALL vecmul	 ! 11
	MOV  (inprod),AX ! 12
	PUSH AX		 ! 13
	PUSH pfmt	 ! 14
	PUSH _PRINTF	 ! 15
	SYS		 ! 16
	MOV SP,BP    ! ADD  SP,12	  17
	PUSH 0		 ! 18
	PUSH _EXIT	 ! 19
	SYS		 ! 20

vecmul:			 ! 21
	PUSH BP		 ! 22  salvo il vecchio BP - vecchio dynamic link
	MOV  BP,SP	 ! 23  ora BP punta al dynamic link
	MOV  CX,4(BP)	 ! 24  dimensione
	MOV  SI,6(BP)	 ! 25  sorgente
	MOV  DI,8(BP)	 ! 26  destinazione
	PUSH 0		 ! 27
1:	LODS		 ! 28  mette in AX l'intero (2 bytes) puntato da DS:SI 
			 !     poi incrementa SI di 2 per farlo puntare all'intero successivo
	MUL  (DI)	 ! 29
	ADD  -2(BP),AX	 ! 30
	ADD  DI,2	 ! 31
	LOOP 1b		 ! 32
	POP  AX		 ! 33
	POP  BP		 ! 34
	RET		 ! 35

.SECT .DATA		 ! 36
pfmt: .ASCIZ "The product is %d!\n"! 37
.ALIGN 2		 ! 38
vec1:	.WORD 3,4,7,11,3 ! 39
vec2:	.WORD 2,6,3,1,0	 ! 40
.SECT .BSS 		 ! 41
inprod:	.SPACE 2	 ! 42
!
! il prodotto sara'   3*2+4*6+7*3+11*1+3*0 = 6+24+21+11+0 = 62
!

