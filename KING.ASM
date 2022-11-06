;TITLE Frequency Count
;****************************************************************************
;* Title:   Frequency count                                                 *   *
;* Author:  Mason King	                                                    *
;* Date:    10/12/2022                                                      *
;* Purpose: This program has the user enter a message then counts the       *
;* letter frequencies.            					    *
;****************************************************************************
;* Grading: Correctness   ______                                            *
;*          Style         ______                                            *
;*          Documentation ______    Total ______                            *
;****************************************************************************

        .MODEL  small
        STACK   256

;****************************************************************************
;* Equates Section                                                          *
;****************************************************************************

EOS     EQU     0                       ; End of string
maxLen	EQU	40

;****************************************************************************
;* Data Section                                                             *
;****************************************************************************
        .DATA
buffer	db	100 dup (?)
exCode	db	0	

Welcome	    db	'Welcome to the Number Guessing Game - Reversed!', EOS
Num		    dw	50

;****************************************************************************
;* Code Section                                                             *
;****************************************************************************
        .CODE
;***************************************************************************
;* External procedures from STRINGS.OBJ & STRIO.OBJ                        *
;***************************************************************************

	EXTRN StrLength:proc, StrRead:proc
	EXTRN StrWrite:proc, NewLine:proc

;***************************************************************************
;* External procedures from BINASC.OBJ                                     *
;***************************************************************************

	EXTRN BinToAscHex:proc, SBinToAscDec:proc, BinToAscDec:proc
	EXTRN BinToAscBin:proc, AscToBin:proc

;****************************************************************************
;* Main entry point of program.                                             *
;****************************************************************************
MAIN PROC FAR
	mov	ax, @data
	mov	ds, ax			;Start up code
	mov ax, Num

	CALL PRINT

	mov	ah, 4Ch
	int	21h
MAIN ENDP
PRINT PROC
    ;initialize count
    mov cx,0
    mov dx,0
	label1:
        ; if ax is zero
        cmp ax,0
        je print1     
        ;initialize bx to 10
        mov bx,10       
        ; extract the last digit
        div bx                 
        ;push it in the stack
        push dx             
        ;increment the count
        inc cx             
        ;set dx to 0
        xor dx,dx
        jmp label1
    print1:
        ;check if count
        ;is greater than zero
        cmp cx,0
        je exit
        ;pop the top of stack
        pop dx
        ;add 48 so that it
        ;represents the ASCII
        ;value of digits
        add dx,48
        ;interrupt to print a
        ;character
        mov ah,02h
        int 21h
        ;decrease the count
        dec cx
        jmp print1
exit:
ret
PRINT ENDP
END MAIN
;****************************************************************************
;* End of Program.                                                          *
;****************************************************************************
