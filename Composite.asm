
; Author: Joseph Di Lullo
; Last Modified: 2/13/2022

INCLUDE Irvine32.inc

.data

welcome			BYTE	"Welcome to program 4, displaying composite numbers!" , 0
myname			BYTE	"Programmed by Joseph Di Lullo!" , 0
instruct1		BYTE	"This program will display the composite numbers up to a choosen number less than 300!" , 0
compoprompt		BYTE	"How many composites would you like to view? (1 - 300): " , 0
numcomp			DWORD	0
errormes		BYTE	"Number must be between 1 and 300!" , 0
currentnum		DWORD	0
divisornum		DWORD	0
goodbyemes		BYTE	"Goodbye!" , 0
thespace		BYTE	"   " , 0
numcomposite	DWORD	0
variableone 	DWORD	0
neednewline		DWORD	0

.code

;Description: Main procedure, calls other procedures
;Receives: nothing
;Returns: nothing
;Preconditions: none
;Register changed: none
main PROC

	inc divisornum								

	mov eax, currentnum
	add eax, 3									
	mov currentnum, eax

	mov eax, variableone
	add eax, 1									
	mov variableone, eax

	call introduction

	call getuserdata							

	call iscomposite

exit
main ENDP

;Description: Prints the introduction, programmers name, and instructions.
;Receives: nothing
;Returns: nothing
;Preconditions: none
;Register changed: none
introduction PROC
	mov  edx, OFFSET welcome				
	call WriteString 
	call Crlf

	mov  edx, OFFSET myname					
	call WriteString 
	call Crlf

	mov  edx, OFFSET instruct1				
	call WriteString 
	call Crlf
	
ret
introduction ENDP

;Description: Gets the amount of composite numbers the user wants to print
;Receives: nothing
;Returns: nothing
;Preconditions: none
;Register changed: none
getuserdata	PROC

	mov  edx, OFFSET compoprompt				
	call WriteString 

	call ReadInt

	mov numcomp, eax
	cmp numcomp, 1								
	jl validate

	cmp numcomp, 300							
	jg validate

ret
getuserdata ENDP

;Description: checks if the number the user entered is between 1 and 300
;Receives: nothing
;Returns: nothing
;Preconditions: none
;Register changed: none
validate PROC

	mov  edx, OFFSET errormes			
	call WriteString 

	call Crlf

	call getuserdata					

ret
validate ENDP

;Description: Prints the composites to the screen
;Receives: nothing
;Returns: nothing
;Preconditions: none
;Register changed: none
showcomposite PROC

	mov eax, neednewline
	cmp neednewline, 10				
	je newline

	mov	eax, currentnum					
	call WriteDec					

	inc neednewline					

	mov edx, OFFSET thespace		
	call WriteString
	
	inc numcomposite				

	mov eax, numcomposite
	cmp eax, numcomp				
	jge goodbye
	jl iscomposite					

ret
showcomposite ENDP

;Description: Goes through numbers to see if they are composite then calls showcompsite to print them
;Receives: nothing
;Returns: nothing
;Preconditions: none
;Register changed: none
iscomposite PROC

	increasenum:

		inc currentnum				

		mov eax, 1
		mov divisornum , eax		
	
	validatenum:					
									
		inc divisornum				

		mov eax, divisornum
		cmp eax, currentnum			
		je increasenum

		mov edx, 0
		mov eax, currentnum			
		div divisornum

		cmp edx, 0
		je	showcomposite			

		mov eax, currentnum			
		cmp eax, divisornum
		jg validatenum

ret
iscomposite ENDP

;Description: prints goodbye statement
;Receives: nothing
;Returns: nothing
;Preconditions: none
;Register changed: none
goodbye PROC

	call Crlf

	mov edx, OFFSET goodbyemes			
	call WriteString 

ret
goodbye ENDP

;Description: Prints a new line when 10 composite numbers are printed
;Receives: nothing
;Returns: nothing
;Preconditions: none
;Register changed: none
newline PROC

	call crlf							

	mov eax, 0
	mov neednewline, eax				

	mov eax, variableone
	cmp eax, 1							
	je showcomposite

ret
newline ENDP

END main

