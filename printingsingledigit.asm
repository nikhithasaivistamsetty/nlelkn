ORG 100h           ; Origin, to specify that the program starts at 100h (COM file format)

; Display message "Enter a digit: "
MOV DX, OFFSET msg_input  ; Load the address of the input message
MOV AH, 09h        ; Function 09h of INT 21h is used to display a string
INT 21h            ; Call DOS interrupt to print the message

; Read a single character from the user
MOV AH, 01h        ; Function 01h of INT 21h is used to read a character
INT 21h            ; Call DOS interrupt to get the first character

; Store the input character in AL (already in AL after INT 21h)
MOV BL, AL         ; Copy AL to BL to preserve the input for later use

; Check if the first character is a digit (0-9)
CMP AL, '0'        ; Compare AL with '0'
JL NotDigit        ; If the input is less than '0', it is not a digit
CMP AL, '9'        ; Compare AL with '9'
JG NotDigit        ; If the input is greater than '9', it is not a digit

; Check if more characters were entered (i.e., two-digit number or more)
MOV AH, 01h        ; Function 01h to check for any more characters
INT 21h            ; Call DOS interrupt to get the next character
CMP AL, 0Dh        ; Check if the user pressed ENTER (carriage return)
JNE NotDigit       ; If it's not ENTER, it's an error (i.e., more than one digit)

; If the input is a valid single digit, display "The entered digit is: "
MOV DX, OFFSET msg_output  ; Load the address of the output message
MOV AH, 09h        ; Function 09h of INT 21h is used to display a string
INT 21h            ; Call DOS interrupt to print the message

; Print the entered digit
MOV DL, BL         ; Move the digit (stored in BL) to DL
MOV AH, 02h        ; Function 02h of INT 21h is used to print a single character
INT 21h            ; Call DOS interrupt to print the character
JMP EndProgram     ; Jump to end of the program

NotDigit:
; If the input is not a single digit, display an error message
MOV DX, OFFSET msg_error  ; Load the address of the error message
MOV AH, 09h        ; Function 09h of INT 21h is used to display a string
INT 21h            ; Call DOS interrupt to print the error message

EndProgram:
; Terminate the program
MOV AH, 4Ch        ; Function 4Ch of INT 21h terminates the program
INT 21h            ; Call DOS interrupt to exit

msg_input  DB 'Enter a single digit: $'   ; Input message
msg_output DB 0Dh, 0Ah, 'The entered digit is: $'  ; Output message with newline
msg_error  DB 0Dh, 0Ah, 'Error: Invalid input! Please enter a single digit.$' ; Error message with newline

END                ; End of program
