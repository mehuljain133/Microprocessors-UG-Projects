; -----------------------------------------------------------
; Assembly Language Programs for Multiple Operations
; -----------------------------------------------------------

ORG 0x1000                  ; Starting address of the program

; ====================
; 1. 32-bit Binary Multiplication
; ====================
BINARY_MULTIPLICATION:
    MOV A, #0x12             ; Load first number (A)
    MOV B, #0x34             ; Load second number (B)
    MOV R0, A                ; Store A in R0
    MOV R1, B                ; Store B in R1
    MOV D, #0                ; Clear result (D register for 64-bit result)
    MUL AB                    ; Multiply A and B (using MUL instruction)
    MOV R2, A                 ; Store the low part of the result
    MOV R3, B                 ; Store the high part of the result
    ; Result in R2 and R3 will be the 64-bit product

; ===========================
; 2. 32-bit BCD Addition and Subtraction
; ===========================
BCD_ADD_SUB:
    MOV A, #0x25             ; Load first BCD number (0x25 = 25)
    MOV B, #0x37             ; Load second BCD number (0x37 = 37)
    ADD A, B                 ; Add A and B (Result = 62 in BCD)
    MOV D, A                 ; Store result (62 in BCD)

    ; Subtraction example
    MOV A, #0x65             ; Load first BCD number (0x65 = 65)
    MOV B, #0x34             ; Load second BCD number (0x34 = 34)
    SUB A, B                 ; Subtract B from A (Result = 31 in BCD)
    MOV D, A                 ; Store result (31 in BCD)

; ===========================
; 3. Linear Search
; ===========================
LINEAR_SEARCH:
    MOV R0, #0x00            ; Initialize index (starting from 0)
    MOV R1, #5               ; Number of elements in the array
    MOV A, #0x10             ; Target number to search for

    ; Array elements are: [0x01, 0x05, 0x0A, 0x10, 0xFF]
    MOV DPTR, #ARRAY         ; Point to the array

SEARCH_LOOP:
    MOVX A, @DPTR            ; Read array element
    INC DPTR                 ; Increment the pointer
    CMP A, R0                ; Compare target with current array element
    JZ FOUND                 ; If target is found, jump to FOUND

    INC R0                   ; Increment index
    MOV A, R0
    CMP A, R1                ; Check if end of array is reached
    JNZ SEARCH_LOOP          ; Repeat if element not found

NOT_FOUND:
    MOV D, #0x00             ; Result: Not Found (0)
    JMP END_SEARCH

FOUND:
    MOV D, R0                ; Store the index of the found element (R0)
    JMP END_SEARCH

END_SEARCH:

; ===========================
; 4. Binary Search
; ===========================
BINARY_SEARCH:
    MOV R0, #0x00            ; Initialize left index (0)
    MOV R1, #4               ; Initialize right index (array size - 1)
    MOV A, #0x0A             ; Target to search

    ; Array elements are sorted: [0x01, 0x05, 0x0A, 0x10, 0xFF]
    MOV DPTR, #ARRAY         ; Point to the array

BINARY_LOOP:
    MOV R2, R0               ; Left index
    MOV R3, R1               ; Right index
    ADD R2, R3               ; Calculate middle index: (left + right) / 2
    MOV R4, R2               ; Store middle index in R4
    MOVX A, @DPTR + R4       ; Load element at middle index
    CMP A, #0x0A             ; Compare target with middle element
    JZ FOUND_BINARY          ; If found, jump to FOUND_BINARY
    JC LESS_THAN             ; If target < middle element, search the left half
    JUMP GREATER_THAN        ; Otherwise, search the right half

LESS_THAN:
    MOV R1, R4               ; Update right index to middle - 1
    JMP BINARY_LOOP

GREATER_THAN:
    MOV R0, R4               ; Update left index to middle + 1
    JMP BINARY_LOOP

FOUND_BINARY:
    MOV D, R4                ; Store the index of the found element (R4)
    JMP END_BINARY_SEARCH

END_BINARY_SEARCH:

; ===========================
; 5. Add and Subtract Two Arrays
; ===========================
ARRAY_ADD_SUB:
    MOV R0, #0               ; Initialize index
    MOV R1, #5               ; Array size (5 elements)

    MOV DPTR, #ARRAY1        ; Point to the first array
    MOV R2, #0               ; Initialize sum (or difference) accumulator
    MOV R3, #0               ; Initialize result

ARRAY_ADD_LOOP:
    MOVX A, @DPTR            ; Read element from array 1
    INC DPTR                 ; Increment pointer for array 1
    MOV R4, A                ; Store array 1 element in R4

    MOV DPTR, #ARRAY2        ; Point to the second array
    MOVX A, @DPTR            ; Read element from array 2
    INC DPTR                 ; Increment pointer for array 2
    MOV R5, A                ; Store array 2 element in R5

    ADD A, R4                ; Add both elements
    MOV R3, A                ; Store the result

    MOV DPTR, #RESULT_ARRAY  ; Store the result in the result array
    MOVX @DPTR, A            ; Write the result back to memory

    INC R0                   ; Increment index
    CMP R0, R1               ; Check if all elements are processed
    JNZ ARRAY_ADD_LOOP       ; Repeat for all elements

; ===========================
; 6. Binary to ASCII Conversion
; ===========================
BIN_TO_ASCII:
    MOV A, #0x65             ; Load binary value (10100101) to convert to ASCII
    ADD A, #0x30             ; Add 30h to convert binary to ASCII
    MOV D, A                 ; Store ASCII result
    ; ASCII 'e' is stored in D

; ===========================
; 7. ASCII to Binary Conversion
; ===========================
ASCII_TO_BIN:
    MOV A, #0x41             ; Load ASCII value for 'A'
    SUB A, #0x30             ; Subtract 30h to get the binary value
    MOV D, A                 ; Store binary value
    ; Binary 'A' (41h) is stored in D

; ===========================
; 8. Bitwise AND, OR, XOR, and NOT
; ===========================
BITWISE_OPERATIONS:
    MOV A, #0xF0             ; Load value A (F0)
    MOV B, #0x0F             ; Load value B (0F)

    ; AND operation
    AND A, B                 ; A = A AND B
    MOV D, A                 ; Store result (A = 0x00)

    ; OR operation
    MOV A, #0xF0             ; Load A (F0) again
    OR A, B                  ; A = A OR B
    MOV D, A                 ; Store result (A = 0xFF)

    ; XOR operation
    MOV A, #0xF0             ; Load A (F0) again
    XOR A, B                 ; A = A XOR B
    MOV D, A                 ; Store result (A = 0xFF)

    ; NOT operation
    MOV A, #0xF0             ; Load A (F0) again
    NOT A                    ; A = NOT A
    MOV D, A                 ; Store result (A = 0x0F)

; ===========================
; End of Program
; ===========================
END:
    HLT                      ; Halt execution of the program

; Data Arrays for operations
ARRAY:      DB 0x01, 0x05, 0x0A, 0x10, 0xFF  ; Example Array (5 elements)
ARRAY1:     DB 0x01, 0x02, 0x03, 0x04, 0x05  ; First Array for addition/subtraction
ARRAY2:     DB 0x06, 0x07, 0x08, 0x09, 0x0A  ; Second Array for addition/subtraction
RESULT_ARRAY: DB 0x00, 0x00, 0x00, 0x00, 0x00  ; Result Array for storing results

