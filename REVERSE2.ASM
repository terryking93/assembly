;Title Programming Assignment 6
;********************************************************
;* Title:	Number Guessing Game - Reversed!	*
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

Welcome		db	'Welcome to the Number Guessing Game - Reversed!', EOS		;Creation of Welcome Prompt
Prompt1		db	'Hello, my name is Hal. Whats your name? ', EOS			;Tell User the computers name and ask for theirs back
Prompt2		db	', Im ready to guess your number between 1 and 100.', EOS		;Tell the User that you are ready to guess a number 1-100
NumQues		db	'Is your number ', EOS								;Prompt to guess number
Symbols		db	'L = Too Low, H = Too High, C = Correct : ', EOS			;User Input Symbols
GTook		db	'It took me ', EOS									; Prompt to tell user how many times it took them to guess
Guess		db	' guesses.', EOS 									
OKPrompt	db	'OK ', EOS
QMark		db	'?' , EOS
PlayAgain	db	'Can we play again ', EOS						;Ask user to play again
YorN		db	'(Y/N) ', EOS								;Yes or No answer options 
BadResp		db	'I dont understand that response.', EOS					;Display if user enters something other than y or n
OutRange	db	'That number is not between 1-100. Please Try Again.'			;Error message if number isnt in range
GSummary	db	'Game Summary: ', EOS
GSHeader1	db	'Number of Guesses    Frequency', EOS
Spaces8		db	'        ',EOS
Spaces26	db	'                         ', EOS                         
FreqTable	db	10 dup (?)																																																																																							
GuessCount	db	0

GuessNum	dw	0
two		dw	0
UserName	dw	0
Answer		dw	0
Number		dw	50																																														
PAAnswer	dw	0
MVar		dw	0
												;Variable for the number were trying to guess



;********************************************************
;* Code Section						*
;********************************************************
.CODE
;********************************************************
;* External procedures from STRINGS.OBJ and STRIO.OBJ	*
;********************************************************

	EXTRN	StrLength:proc, StrRead:proc
	EXTRN	StrWrite:proc, NewLine:proc

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
	call	StrWrite				;Outputs Welcome Message
	call	NewLine				;Prints new line

Beginning:
	call	NewLine				;Outputs a new line
	mov	di, OFFSET Prompt1		;Moves prompt1 into di
	call	StrWrite				;Outputs Prompt1
	call	NewLine				;Prints new line

	mov	di, OFFSET buffer		;Move contents of buffer into di
	call	StrRead				;Read in users input 			

	mov	UserName, ax			;Store the user's name into UserName

	mov	di, OFFSET OKPrompt		;Moves prompt1 into di
	call	StrWrite			;Outputs OKPrompt
	
	mov	di, OFFSET UserName		;Move User's Name into di
	call	StrWrite			;Print out User's Name
	
	mov	di, OFFSET Prompt2		;Move contents of prompt2 into di
	call	StrWrite			;Print out prompt2

GuessAgain:
	inc	GuessCount				;Increase the value in GuessCount
	call	NewLine				;Print out new line
	call	NewLine				;Print out new line
	mov	di, OFFSET NumQues		;Move the contents in NumQues to di
	call	StrWrite				;Print out di (NumQues)

	mov	di, OFFSET Number
	call	StrWrite
	call	NewLine				;Print out new line
Symbol:	
	mov	di, OFFSET Symbols		;Move the contents of Symbols into di
	call	StrWrite				;Print out di (Symbols)
	call	NewLine				;Print out newline

	mov	di, OFFSET buffer		;Move contents of buffer into di
	call	StrRead				;Read in users input
	call	AscToBin			;Convert from ascii to binary
	mov	Answer, ax			;Store input into variable Answer
	and	Answer, 11011111b 		;Forces UC

	cmp	Answer, 'L'			;Compares character L to contents of Answer
	je	TooLow				;If equal, jump to TooLow

	cmp	Answer, 'H'			;Commpares character H to contents of Answer
	je	TooHigh				;If equal, jump to TooHigh
	
	cmp	Answer, 'C'			;Compares character C to contents of Answer
	je	Correct				;If equalm jump to Correct
	jne	InvalidResponse			;If not equal to L, H, or C, then jump to Invalid Response

TooLow:
	mov	two, 2
	mov	ax, Number			;
	div	two				;Divide MVar by 2
	add	Number, ax			;Add Mvar and Number and store contents in Number
	jmp	GuessAgain			;Jump to GuessAgain

TooHigh:
	mov	two, 2
	mov	ax, Number
	div	two
	mov	Number, ax
	jmp	GuessAgain			;jump to GuessAgain

InvalidResponse:
	mov	di, OFFSET BadResp		;Move BadResp into di
	call	StrWrite				;Print out di (BadResp)
	call	NewLine				;Print a new line
	jmp	Symbol				;Jump to Symbol (Redisplay the symbols available)

Correct:
	mov	di, OFFSET GTook		;Move contents of GTook into di
	call	StrWrite				;Print out di (Gtook)
		
	mov	di, OFFSET GuessCount		;Move contents of GuessCount into di
	call	StrWrite				;Print out di (GuessCount)
	
	mov	di, OFFSET Guess		;Move contents of Guess into di
	call	StrWrite				;Print out di (Guess)

	jmp	PlayAnother			;Jump to PlayAnother

PlayAnother:
	call	NewLine				;Print out new line
	call	NewLine				;Print out new line
	mov	di, OFFSET PlayAgain		;Move contents of PlayAgain into di
	call	StrWrite				;Print out di (PlayAgain)
	mov 	di, OFFSET UserName		;Move contents of Username into di
	call	StrWrite				;Print out di (UserName)
	mov	di, OFFSET QMark		;Move contents of QMark into di
	call	StrWrite			;Print out di (QMark)
	mov	di, OFFSET YorN			;Move contents of YorN into di
	call	StrWrite			;Print out di (YorN)
	mov	di, OFFSET buffer		;Move contents of buffer into di
	call	StrRead				;Print out new line
	call	AscToBin			;Convert from ASCII to Binary
	mov	PAAnswer, di			;Move contents in ax into PAAnswer
	and	PAAnswer, 11011111b		;Force UC
	cmp	PAAnswer, 'Y'			;Compare PAAnswer to Y

	jne	Option				;Jump to Option if they are not equal
	call	NewLine				;Print out new line
	jmp	Beginning			;Jump to beginning

Option:
	cmp	PAAnswer, 'N'			;Compare PAAnswer to N
	je	GameSummary			;If PAAnswer is equal to N, then jump to Done
	jne	PAInvalidResponse		;If PAAnswer isn't equal to N, jump to PAInvalidResponse

PAInvalidResponse:
	mov	di, OFFSET BadResp		;Move the BadResp into di
	call	StrWrite				;Print out di (BadResp)
	jmp	PlayAnother			;Jump to PlayAnother


GameSummary:

 ;Zero out the table
	mov	di, OFFSET FreqTable
	mov	cx, 10
	mov	al, 0
	call	FillTable

;Print The Table
	mov	di, OFFSET GSummary
	call	StrWrite
	call	NewLine
		
	mov	di, OFFSET GSHeader1
	call	StrWrite
	call	NewLine

Ploop:	
	mov	di, OFFSET Spaces8
	call	StrWrite

;Number of Guesses
	mov	di, OFFSET	GuessNum
	inc	GuessNum
	
;Spacing
	mov	di, OFFSET	Spaces26
	call	StrWrite


	mov	di, GuessNum		;Moves RowNum into si
	mov	al, FreqTable[di]	;Moves the si value of Ftable into di
	mov	ah, 0
	mov	di, OFFSET buffer	;Moves the contents of buffer into di
	mov	cx, 1			;The maximum number of characters to be
					;output
	call	BinToAscDec		;Converts the binary to ascii
	call	StrWrite		;Outputs the contents of di

	cmp	GuessNum, 10
	ja	Done
	jmp	Ploop


;******************************************************************************
;* Print error message if the sum is too big                                  *
;******************************************************************************


;******************************************************************************
;* End of Program                                                             *
;******************************************************************************
Done:
	call	NewLine
	call	NewLine

;******************************************************************************
;*Program Termination Code                                                    *
;******************************************************************************

	mov 	ah,	04Ch			;DOS function: Exit Program
	mov 	al, exCode			;Return exit code value
	int	21h				;Calls DOS. Terminate Program

;Subroutine FillTable
;di - pointer to the table
;cx - number of bytes to fill
;al - fill value
FillTable:
	push	di
	push	cx
ftloop:
	mov	[di], al
	inc	di
	loop	ftloop

	pop 	cx
	pop	di
	ret	

	END     Start			;End of program / entry point
