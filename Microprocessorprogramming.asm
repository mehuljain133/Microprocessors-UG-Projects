;-----------------------------------------------------------
; This code covers:
; - Register Organization (internal architecture)
; - Instruction Formats
; - Program Control Instructions (loops, jumps)
; - Assembly Language Concepts
;-----------------------------------------------------------

; Hypothetical Microprocessor Architecture:
; - Registers: A (Accumulator), B (General-purpose), C (Counter), SP (Stack Pointer), PC (Program Counter)
; - Flags: Zero (Z), Carry (C), Sign (S), Overflow (V)
; - Stack and Memory Access

; Define starting address for program
ORG 0x1000        ; Program starts at memory address 0x1000

; Initialize Registers
START:
    MOV A, #0x01    ; Load immediate value 0x01 into A
    MOV B, #0x02    ; Load immediate value 0x02 into B
    MOV C, #0x00    ; Initialize C (Counter) to 0
    MOV SP, #0x200  ; Set Stack Pointer to 0x200
    MOV PC, #0x1000 ; Set Program Counter to the start of the program

; Register Organization: A, B, C, SP, and PC

; 1. Instruction Formats:
;    In the following instructions, note the format:
;    - `MOV A, #value` (immediate addressing)
;    - `MOV A, [address]` (direct addressing)
;    - `MOV A, @DPTR` (indirect addressing)
;    - `MOV A, B` (register-to-register transfer)

; 2. Example of Program Control Instructions

; --- Example 1: Simple Data Movement and Conditional Logic ---
    ; Immediate Addressing: MOV A with immediate value 0x33
    MOV A, #0x33       ; A = 0x33
    
    ; Register-to-Register: Copy A into B
    MOV B, A           ; B = 0x33
    
    ; Arithmetic Operation (add A and B, store in A)
    ADD A, B           ; A = A + B (A = 0x33 + 0x33)
    
    ; Conditional Jump based on Zero Flag (Z)
    JZ  ZERO_SET       ; If zero flag is set, jump to ZERO_SET label
    
    ; If Zero Flag is not set, proceed with normal execution
    MOV C, #0x01       ; Set C to 0x01

ZERO_SET:
    ; If Zero Flag is set, jump to here and perform this operation
    MOV C, #0x00       ; Set C to 0x00 if Zero Flag is set

; --- Example 2: Program Control Loop ---
    ; Initialize counter (C)
    MOV C, #0x05       ; Set counter to 5
    
LOOP_START:
    ; Decrement the counter in C
    DEC C              ; C = C - 1
    
    ; Check if C is not zero, if not, continue looping
    JNZ LOOP_START     ; If C is not zero, jump to LOOP_START
    
    ; When C becomes zero, exit the loop and continue with the program
    MOV A, #0x00       ; Load A with 0x00 to indicate loop has completed
    
; --- Example 3: Stack Operations ---
    ; Push value of A onto the stack
    PUSH A             ; Push the content of A onto the stack
    
    ; Pop value from the stack into register B
    POP B              ; Pop the top value from the stack into B
    
    ; Example of Data Movement to/from memory
    MOV [0x6000], A    ; Store the value of A into memory address 0x6000
    MOV A, [0x6000]    ; Load the value from memory address 0x6000 into A
    
; --- Example 4: Subroutine and Return ---
    CALL SUBROUTINE    ; Call a subroutine to handle specific task
    ; The program continues here after returning from the subroutine

    HLT                ; Halt execution, end of the program

; Subroutine Definition
SUBROUTINE:
    ; Simple subroutine example that performs some tasks
    MOV A, #0xAA       ; Load A with 0xAA
    MOV B, #0x55       ; Load B with 0x55
    ADD A, B           ; Add A and B (A = 0xAA + 0x55)
    RET                ; Return from subroutine

;-----------------------------------------------------------
; Microprocessor Architecture Breakdown:
; - Registers: A (Accumulator), B (General-purpose), C (Counter), SP (Stack Pointer), PC (Program Counter)
; - Flags: Zero (Z), Carry (C), Sign (S), Overflow (V)
; - Addressing Modes: Immediate, Direct, Indirect, Register
; - Program Control Instructions: MOV, ADD, DEC, JZ, JNZ, CALL, RET, HLT
;-----------------------------------------------------------
