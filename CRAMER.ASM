Title Programming Assignment 5
;********************************************************
:* Title:	Cramer's Rule				*
;* Author	Mason King				*
;* Date:	10/25/2022				*
;* Purpose:	This program calculates Cramer's Rule	*
;********************************************************

;********************************************************
;* Grading:	Correctness	 _____			*	
;* 		Style		 _____			*
;*		Documentation	 _____			*
;********************************************************

	.MODEL 	small
	STACK	256

;********************************************************
;* Equates Section					*
;********************************************************

EOS	EQU	0
maxLen	EQU	40

;********************************************************
;* Data Section						*
;********************************************************
	.DATA
buffer	db	100 dup(?)
exCode	db	0

SolX	db	'Here is the solution: x = ', EOS
SolY	db	' , y = ', EOS
NoSol	db	'This system has no single solution. ', EOS
Welcome db	'The fantastic systems of equations solver!', EOS
Prompt1 db	'Please enter the cooefficient values : ', EOS
Prompt2 db	'Do you want to solve another system? (Y or N): ', EOS
a	db	'a: ', EOS
b	db	'b: ', EOS
c	db	'c: ', EOS
d	db	'd: ', EOS
e	db	'e: ', EOS
f	db	'f: ', EOS

aVal	dw	0
bVal	dw	0
cVal	dw	0
dVal	dw	0
eVal	dw	0
fVal	dw	0

aeVal	dw	0
bdVal	dw	0
ceVal	dw	0
bfVal	dw	0
afVal	dw	0
cdVal	dw	0

Det	dw	0
Detx	dw	0
Dety	dw	0
x	dw	0
y	dw	0

;********************************************************
;* Code Section						*
;********************************************************
.CODE
;********************************************************
;* External procedures from STRINGS.OBJ and STRIO.OBJ	*
;********************************************************
	EXTRN BinToAscHex:proc, SBinToAscDec:proc, BinToAscDec:proc
	EXTRN BinToAscBin:proc, AscToBin:proc
;********************************************************
;* Main entry point of program				*
;********************************************************
Start:
	mov	ax, @data
	mov	ds, ax				;Start Up Code
	mov	es, ax

;********************************************************
;* Start of Program					*
;********************************************************
	call	NewLine				;Outputs a newline
	mov	di, OFFSET Welcome		;Moves the welcome message to di
	call	StrWrite			;Outputs Welcome Message
	call	NewLine				;Prints new line

Beginning:
	call	NewLine				;Outputs a new line
	mov	di, OFFSET Prompt1		;Moves prompt1 into di
	call	StrWrite			;Outputs Prompt1
	call	NewLine				;Prints new line

	mov	di, OFFSET a			;Moves value in a to di
	call	StrWrite			;Outputs the contents in di

	mov	di, OFFSET buffer		;Moves the contents of buffer to di
	mov	cx, 5				;Moves the value 5 into cx
	call	StrRead				;Reads the users input
	call	AscToBin			;Converts the input to binary
	mov 	aVal, ax			;moves the contents of ax into aVal
		
	call	NewLine				;Prints new line
	mov	di, OFFSET b			;Moves value in b to di
	call	StrWrite			;Prints the contents of di

	mov	di, OFFSET buffer		;Moves the contents of buffer to di
	mov	cx, 5				;Moves the value 5 into cx
	call	StrRead				;Reads the users input
	call	AscToBin			;Converts the input to binary
	mov	bVal, ax			;Moves the value in ax to bVal

	call	NewLine				;Print new line
	mov	di, OFFSET c			;Moves the contents of c into di
	call	StrWrite			;Print out di

	mov	di, OFFSET buffer		;Move the contents of buffer into di
	mov	cx, 5				;Move the value 5 into cx
	call	StrRead				;Reads the users input
	call	AscToBin			;Converts the input to binary
	mov	cVal, ax			;Stores the value of ax into cVal

	call	NewLine				;Prints a new line
	mov	di, OFFSET d			;Moves the contents of d into di
	call	StrWrite			;Prints the contents of di

	mov	di, OFFSET buffer		;Moves the contents of buffer into di
	mov	cx, 5				;Moves the value of 5 into cx
	call	StrRead				;Reads the users input
	call	AscToBin			;Converts contents to binary
	mov	dVal, ax			;Moves the contents in ax to dVal

	call	NewLine				;Prints out a new line
	mov	di, OFFSET e			;Moves the contents of e into di
	call	StrWrite			;Prints out the contents of di
	
	mov	di, OFFSET buffer		;Moves the contents of buffer into di
	mov	cx, 5				;Moves the value of 5 into cx
	call	StrRead				;Read the users input
	call	AscToBin			;Convert to binary
	mov	eVal, ax			;Move the contents of ax into eVal

	call	NewLine				;Print out a new line
	mov	di, OFFSET f			;Move the contents of f into di
	call	StrWrite			;Print out the contents of di

	mov	di, OFFSET buffer		;Move contents of buffer into di
	mov	cx, 5				;Move the value of 5 into cx
	call	StrRead				;Read the users input
	call	AscToBin			;Convert to binary
	mov	fVal, ax			;Move the value of ax into fVal

;Multiply the values

	mov 	ax, eVal			;Moves the value in eVal to ax
	imul	aVal				;Multiplies the value in ax by aVal
	mov	aeVal, ax			;Moves the value in ax into aeVal

	mov	ax, dVal			;Moves the value in dVal into ax
	imul	bVal				;Multiplies the value in ax by bVal
	mov	bdVal, ax			;Moves the contents in ax into bdVal
	
	mov	ax, eVal			;Moves the contents in eVal into ax
	imul	cVal				;Multiplies ax by cVal
	mov	ceVal, ax			;Moves the contents in ax into ceVal

	mov	ax, fVal			;Moves the contents in fVal into ax
	imul	bVal				;Multiplies ax by bVal
	mov	bfVal, ax			;Moves the contents in ax into bfVal

	mov	ax, fVal			;Moves the contents of fVal in ax
	imul	aVal				;Multiplies ax by aVal
	mov	afVal, ax			;Moves the value of ax into afVal

	mov	ax, dVal			;Moves the contents in dVal into ax
	imul	cVal				;Multiplies ax by cVal
	mov	cdVal, ax			;Moves the contents in ax into cdVal

	mov	ax, aeVal			;Moves the value of aeVal into ax
	sub	ax, bdVal			;Subtracts bdVal from ax
	mov	Det, ax				;Moves the value of ax into Det
	
	mov 	ax, ceVal			;Moves the value of ceVal into ax
	sub	ax, bfVal			;Subtracts bfVal from ax
	mov	Detx, ax			;Moves the value of ax into Detx

	mov	ax, afVal			;Moves the value of afVal into ax
	sub	ax, cdVal			;Subtracts cdVal from ax
	mov	Dety, ax			;Moves the value of ax into Dety

	cmp 	Det, 0				;Compares the contents of Det to 0
	je	CalcDone			;If equal, then jump to CalcDone
	jmp	FindXY				; Otherwise, jump to FindXY

CalcDone:
	call	NewLine				;Print out new line
	call	NewLine				;Print out new line
	mov	di, OFFSET NoSol		;Move the value of NoSol into di
	call	StrWrite			;Print out di
	jmp	AskAgain			;Jump to AskAgain

FindXY:
	mov	ax, Detx			;Move the value of Detx into ax
	cwd					;Forces ax to be signed
	idiv	Det				;Divides the contents of ax by DET
	mov	x, ax				;Moves the contents of ax into x
	
	mov	ax, Dety			;Moves the contents of Dety into ax
	cwd					;Forces ax to be signed
	idiv	Det				;Divides the contents of ax by Det
	mov	y, ax				;Move the contents of y into ax

;Display the results
	call	Newline				;Prints out new line
	call	Newline				;Prints out new line
	mov	di, OFFSET SolX			;Moves the contents of SolX into di
	call	StrWrite			;Print out contents of di
	mov	ax, x				;Moves the value of x into ax
	mov	cx, 1				;Moves the value of 1 into cx
	mov	di, OFFSET buffer		;Moves the contents of buffer into di
	call	SBinToAscDec			;Forces di to be signed ascii decimal
	call	StrWrite			;Prints out the contents of di

	mov	di, OFFSET SolY			;Moves the contents of SolY into di
	call	StrWrite			;Print out di
	mov	ax, y				;Moves the value of y into ax
	mov	cx, 1				;Moves the value of 1 into cx
	mov	di, OFFSET buffer		;Moves the contents of buffer into di
	call	SBinToAscDec			;Forces di to be a signed ascii decimal
	call	StrWrite			;Print out di

AskAgain:
	call	NewLine				;Prints out new line
	call	NewLine				;Prints out new line
	mov	di, OFFSET Prompt2		;Moves contents in Promp2 into di
	call	StrWrite			;Prints out di
	mov	di, OFFSET buffer		;Moves contents of buffer into di
	mov	cx, 2				;Asks the user if they want another calculation
	call	StrRead				;If they do, it will jump to the beginning
	mov	al, buffer			;If not, it will end the program
	and	al, 11011111b
	cmp	al, 'Y'
	jne	next1
	call	NewLine
	jmp Beginning
next1:
	cmp	al,'N'
	je	Done
	jmp	AskAgain

;****************************************************************
;* End of Program						*
;****************************************************************
Done:
	call	NewLine

;****************************************************************
;* Program Termination						*
;****************************************************************
	mov	ah, 04Ch
	mov	al, exCode
	int	21h
	
	End Start								