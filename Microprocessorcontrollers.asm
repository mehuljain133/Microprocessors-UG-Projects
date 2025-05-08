;-----------------------------------------------------------
; Microprocessor Controllers Example
; This program demonstrates:
; - I/O Controller
; - Interrupt Controller
; - DMA Controller
; - USART Controller
;-----------------------------------------------------------

; Initialize microprocessor environment
ORG 0x1000              ; Program starts at memory address 0x1000
START:
    MOV A, #0x00        ; Initialize accumulator A to 0
    MOV B, #0x00        ; Initialize accumulator B to 0
    MOV SP, #0x200      ; Initialize Stack Pointer to address 0x200

; --- I/O Controller: I/O Devices Communication ---
; I/O controller handles communication between the microprocessor and peripherals.
IO_CONTROLLER:
    MOV DPTR, #0x3000   ; Load Data Pointer with memory address for I/O device
    MOVX A, @DPTR       ; Read data from I/O device using the I/O controller
    MOV B, A            ; Store the received data in B
    MOV DPTR, #0x4000   ; Load next memory address to store data
    MOVX @DPTR, A       ; Write the data back to memory using the I/O controller

; --- Interrupt Controller: Handling Interrupts ---
; Interrupt controller manages interrupt requests from peripherals or devices.
INTERRUPT_CONTROLLER:
    MOV A, [0x5000]     ; Read interrupt status register at address 0x5000
    CMP A, #0x01        ; Check if interrupt flag is set (interrupt triggered)
    JZ  WAIT_INTERRUPT  ; If no interrupt, jump to WAIT_INTERRUPT
    ; Interrupt is triggered, handle it
    MOV A, [0x6000]     ; Read data from interrupting device
    MOV B, A            ; Store data in B
    MOV [0x7000], A     ; Write data to memory location 0x7000

WAIT_INTERRUPT:
    ; Wait for the interrupt signal to trigger again (processor goes to sleep or does other tasks)

; --- DMA Controller: Direct Memory Access Transfer ---
; DMA controller allows direct data transfer between memory and peripherals.
DMA_CONTROLLER:
    MOV A, [0x8000]     ; Read DMA status register at address 0x8000
    CMP A, #0x01        ; Check if DMA transfer is complete
    JZ  WAIT_DMA        ; If DMA is not complete, jump to WAIT_DMA
    ; Handle the DMA transfer completion
    MOV A, [0x9000]     ; Read data from DMA buffer
    MOV [0xA000], A     ; Write data to memory address 0xA000

WAIT_DMA:
    ; Wait for DMA transfer to complete (processor is not involved in data transfer)

; --- USART Controller: Serial Communication ---
; USART controller enables communication via serial protocols (USART).
USART_CONTROLLER:
    MOV A, [0xB000]     ; Read USART status register (e.g., TX/RX flags)
    CMP A, #0x01        ; Check if data is ready to be transmitted
    JZ  WAIT_USART      ; If no data ready, jump to WAIT_USART
    MOV A, [0xC000]     ; Read data from memory (transmit buffer)
    MOV [0xD000], A     ; Write data to USART transmit register
    ; Wait for data to be transmitted, then check if transmission is complete
    MOV A, [0xB000]     ; Check USART transmission status register
    CMP A, #0x02        ; Check if transmission is complete
    JZ  WAIT_USART      ; If not complete, wait for the transmission to finish

WAIT_USART:
    ; Wait for USART to complete transmission or receive data from serial port

; --- End of Program ---
END:
    HLT                 ; Halt execution of the program

;-----------------------------------------------------------
; Explanation:
; 1. **I/O Controller**:
;    - The I/O controller interfaces between the microprocessor and I/O devices.
;    - It handles data transfers to and from I/O devices via the I/O address space.
;  
; 2. **Interrupt Controller**:
;    - The interrupt controller manages interrupt requests (IRQ) from peripherals.
;    - It monitors interrupt status registers and triggers interrupt handling routines.
;    - The CPU is interrupted only when needed, improving efficiency.
;  
; 3. **DMA Controller**:
;    - The DMA controller allows peripherals to transfer data directly to/from memory.
;    - It frees the CPU from managing the data transfer, improving system performance.
;  
; 4. **USART Controller**:
;    - The USART controller enables serial communication (both synchronous and asynchronous).
;    - It handles the transmission and reception of data over serial communication lines.
;    - The microprocessor can interact with external devices via UART/SPI protocols.
;-----------------------------------------------------------
