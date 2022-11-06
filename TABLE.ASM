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

Welcome	db	'Welcome to the Number Guessing Game - Reversed!', EOS
RowNum	dw	0
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
Spaces8		db	'        ',EOS
Spaces26	db	'                         ', EOS                         
FreqTable	db	10 dup (?)																																																																																							
GuessCount	db	0
Prompt1	db	'Hello, my name is Hal. Whats your name? ', EOS
Prompt2	db	', Im ready to guess your number between 1 and 100. ', EOS
UserName 	db	100 dup (?)
GuessNum	db	0
two		db	0
Answer	dw	0
Num		db	'50', EOS																																												
PAAnswer	dW	0



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
Start:  
	mov	ax, @data
	mov	ds, ax			;Start up code
	mov 	es, ax

;****************************************************************************
;* Start of Program
;****************************************************************************
Beginning:
	
;Get the character string
	call	NewLine			;Moves to the next line
	call	NewLine			;Moves to the next line
	mov	di, OFFSET prompt1	;Moves the first prompt into di
	call	StrWrite		;Outputs the content of di
	call	NewLine			;Moves to the next line
	mov	di, OFFSET UserName	;Moves Sentence into di
	mov	cx, 255			;Sets the maximum amount of chars to be put into Sentence
	call	StrRead			;Reads the users input and puts it into Sentence
	call	NewLine			;Moves to the next line
	call	NewLine			;Moves to the next line
	mov	di, OFFSET OkPrompt	;Moves Echo prompt into di
	call	StrWrite		;Outputs the contents of di
	mov	di, OFFSET UserName	;Moves the users sentence to di
	call	StrWrite		;Outputs the content of di
	mov	di, OFFSET Prompt2
	call	StrWrite
	call	NewLine			;Moves to the next line
	call	NewLine			;Moves to the next line
	
GuessAgain:
	inc	GuessCount				;Increase the value in GuessCount
	call	NewLine				;Print out new line
	call	NewLine				;Print out new line
	mov	di, OFFSET NumQues		;Move the contents in NumQues to di
	call	StrWrite				;Print out di (NumQues)
	inc	Num
	mov	di, OFFSET Num
	call	StrWrite

	mov	di, OFFSET QMark
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
	mov	al, Num		;
	div	two				;Divide MVar by 2
	add	Num, al			;Add Mvar and Number and store contents in Number
	jmp	GuessAgain			;Jump to GuessAgain

TooHigh:
	mov	two, 2
	mov	al, Num
	div	two
	mov	Num, al
	jmp	GuessAgain			;jump to GuessAgain

InvalidResponse:
	call	StrWrite
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
	mov	di, OFFSET Freqtable	;Moves Ftable to di
	mov	cx, 10			;Sets the maximum length of Ftable
	mov	al, 0			;Sets the low part of ax to 0
	call	FillTableWithValue	;Calls the subroutine to fill the table 
					;with the contents of al
;Build the table
	mov	si, 0			;Sets si to 0

Tloop:
	mov	al, UserName[si]	;Moves the si byte of Sentence to al
	cmp	al, EOS			;Checks to see if Sentence is empty
	je	PrintTable		;If it is empty we print the table
	cmp	al, 25			;Compares the contents of al to 25
	je	NextChar		;If it is above 25 it is not a letter and 
					;we can move on to the next letter
	mov	ah, 0			;Makes sure the high part of ax is 0
	mov	di, ax			;Moves the contents of ax to di
	inc	FreqTable[di]		;Increments the counter in Ftable

NextChar:
	inc	si			;Adds 1 to si
	jmp	Tloop			;Jumps back to Tloop

;Print the Table
PrintTable:
	mov	di, OFFSET GSummary	;Moves Header1 to di
	call	StrWrite		;Outputs the contents of di

	call	NewLine			;Moves to the next line
	mov	di, OFFSET GSHeader1	;Moves Header2 to di
	call	StrWrite		;Outputs the contents of di
	call	NewLine			;Moves to the next line

;Print Loop
	mov	RowNum, 0		;Zeros out RowNum
Ploop:
	mov	di, OFFSET Spaces8	;Moves Spaces4 into di
	call	StrWrite		;Outputs the content of di

;Left Side Letter

	mov	ax, RowNum		;Moves the contents of RowNum to ax
	add	al, 'A'			;Adds the hex value of A to al
	mov	buffer, al		;Moves al to buffer
	mov	buffer+1, EOS		;Adds an EOS to the byte after buffer
	mov	di, OFFSET buffer	;Moves buffer to di
	call	StrWrite		;Outputs the contents of di

	mov	di, OFFSET Spaces26	;Moves Spaces12 into di
	call	StrWrite		;Outputs the contents of di
	
;Left Side Count
	mov	si, RowNum		;Moves RowNum into si
	mov	al, FreqTable[si]		;Moves the si value of Ftable into al
	mov	ah, 0			;Zeros out ah
	mov	di, OFFSET buffer	;Moves the contents of buffer into di
	mov	cx, 31		;The maximum number of characters to be
					;output
	call	BinToAscDec		;Converts the binary to ascii
	call	StrWrite		;Outputs the contents of di



;****************************************************************************
;* End of Program.                                                          *
;****************************************************************************
Done:
        call    NewLine			;Moves to the next line

;****************************************************************************
;* Program termination code.                                                *
;****************************************************************************
	mov	ah, 04Ch
	mov	al, exCode		;Exit code
	int	21h

;Subroutine FillTableWithValue
;di - Pointer to the table
;cx - Number of bytes to fill
;al - Fill value
FillTableWithValue:
	push	di			;Pushes di into the stack
	push	cx			;Pushes cx into the stack
ftloop:
	mov	[di], al		;Moves the contents of al into di
	inc	di			;Adds 1 to di
	loop	ftloop			;Loops ftLoop

	pop	cx			;Pops cx from the stack
	pop	di			;Pops di from the stack
	ret				;Returns to where this was called

	End	Start			;Ends the program

