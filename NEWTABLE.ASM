TITLE Frequency Count
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

Welcome		db	'Welcome to the Number Guessing Game - Reversed!', EOS
RowNum		dw	0
NumQues		db	'Is your number ', EOS								;Prompt to guess number
Symbols		db	'L = Too Low, H = Too High, C = Correct : ', EOS			;User Input Symbols
GTook		db	'It took me ', EOS									; Prompt to tell user how many times it took them to guess
Guess		db	' guesses.', EOS 									
OKPrompt	db	'Ok ', EOS
QMark		db	'?' , EOS
PlayAgain	db	'Can we play again ', EOS						;Ask user to play again
YorN		db	'(Y/N) ', EOS								;Yes or No answer options 
BadResp		db	'I dont understand that response.', EOS					;Display if user enters something other than y or n
OutRange	db	'That number is not between 1-100. Please Try Again.'			;Error message if number isnt in range
GSummary	db	'Game Summary: ', EOS
GSHeader1	db	'Number of Guesses    Frequency', EOS
Spaces8		db	'       ',EOS
Spaces26	db	'                 ', EOS                         
FreqTable	db	10 dup (?)																																																																																							
GuessCount	db	0
Prompt1		db	'Hello, my name is Hal. Whats your name? ', EOS
Prompt2		db	', Im ready to guess your number between 1 and 100. ', EOS
UserName 	db	100 dup (?)
GuessNum	db	0
two			db	0
Answer		dw	0
Num			dw	0																																										

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
	mov	 ax, @data
	mov	 ds, ax					;Start up code
	mov  es, ax
	call NewLine				;Moves to the next line
	call NewLine				;Moves to the next line
	mov	 di, OFFSET Welcome
	call StrWrite
	
	call NewLine				;Moves to the next line
	call NewLine				;Moves to the next line
	mov	 di, OFFSET prompt1		;Moves the first prompt into di
	call StrWrite				;Outputs the content of di
	call NewLine				;Moves to the next line
	mov	 di, OFFSET UserName	;Moves Sentence into di
	mov	 cx, 255				;Sets the maximum amount of chars to be put into Sentence
	call StrRead				;Reads the users input and puts it into Sentence
	call NewLine				;Moves to the next line
	mov	 di, OFFSET OkPrompt	;Moves Echo prompt into di
	call StrWrite				;Outputs the contents of di
	mov	 di, OFFSET UserName	;Moves the users sentence to di
	call StrWrite				;Outputs the content of di
	mov  di, OFFSET Prompt2
	call StrWrite
	call NewLine				;Moves to the next line

	mov	Num, 50
	mov	GuessCount, 0
	call NewLine				;Print out new line
	mov	 di, OFFSET NumQues		;Move the contents in NumQues to di
	call StrWrite
	mov  ax, Num
	call NUMPRINT

	mov	ah, 4Ch
	int	21h

MAIN ENDP
NUMPRINT PROC
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
NUMPRINT ENDP
END MAIN
