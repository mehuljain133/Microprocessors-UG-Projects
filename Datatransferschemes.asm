;-----------------------------------------------------------
; This program demonstrates:
; - Synchronous Data Transfer
; - Asynchronous Data Transfer
; - Interrupt Driven Data Transfer
; - DMA Mode Data Transfer
;-----------------------------------------------------------

; Initialize microprocessor environment
ORG 0x1000              ; Program starts at memory address 0x1000
START:
    MOV A, #0x00        ; Initialize accumulator A
    MOV B, #0x00        ; Initialize accumulator B
    MOV SP, #0x200      ; Initialize Stack Pointer to address 0x200

; --- Synchronous Data Transfer ---
; Synchronous transfer requires the sender and receiver to synchronize on a clock.
SYNCHRONOUS_TRANSFER:
    MOV DPTR, #0x3000   ; Load Data Pointer with memory address 0x3000 (data source)
    MOVX A, @DPTR       ; Read data from memory (synchronous data transfer)
    MOV B, A            ; Store data in B (receiver)
    MOV DPTR, #0x4000   ; Load next address for transfer (destination)
    MOVX @DPTR, A       ; Write data to memory (synchronous transfer)
    NOP                 ; No Operation (just a placeholder for synchronization)

; --- Asynchronous Data Transfer ---
; In asynchronous transfer, data is sent without the clock synchronization. 
; Instead, start and stop bits are used to indicate data boundaries.
ASYNC_TRANSFER:
    MOV A, [0x5000]     ; Read data from an asynchronous I/O device (e.g., UART)
    CMP A, #0xFF        ; Check if new data is available
    JZ  NO_DATA_ASYNC   ; If no new data, jump to NO_DATA_ASYNC
    MOV B, A            ; Store the received data in register B
    MOV [0x6000], A     ; Write received data to memory address 0x6000

NO_DATA_ASYNC:
    ; If no data available, continue polling for data

; --- Interrupt-Driven Data Transfer ---
; In interrupt-driven transfer, the processor is interrupted by a signal 
; when data is available, instead of continuously polling.
INTERRUPT_DRIVEN_TRANSFER:
    MOV A, [0x7000]     ; Check interrupt status register (0x7000)
    CMP A, #0x01        ; Check if interrupt flag is set (data ready)
    JZ  WAIT_INTERRUPT  ; If no interrupt, jump to WAIT_INTERRUPT
    ; Handle the interrupt
    MOV A, [0x8000]     ; Read data from I/O register (interrupt source)
    MOV B, A            ; Store data in register B
    MOV [0x9000], A     ; Write data to memory address 0x9000

WAIT_INTERRUPT:
    ; Wait for the interrupt to occur (processor goes to sleep or does other tasks)

; --- DMA Mode Data Transfer ---
; In DMA mode, peripherals can transfer data directly to/from memory 
; without the CPU's involvement. This is more efficient.
DMA_TRANSFER:
    MOV A, [0xA000]     ; Check DMA status register (0xA000)
    CMP A, #0x01        ; Check if DMA transfer is complete
    JZ  WAIT_DMA        ; If DMA is not complete, jump to WAIT_DMA
    ; Handle DMA transfer completion
    MOV A, [0xB000]     ; Read data from DMA buffer
    MOV [0xC000], A     ; Write data to memory address 0xC000

WAIT_DMA:
    ; Wait for DMA transfer to complete, the processor is not involved in data transfer

; --- End of Program ---
END:
    HLT                 ; Halt execution of the program

;-----------------------------------------------------------
; Explanation:
; 1. **Synchronous Data Transfer**:
;    - Data is transferred between two devices or registers synchronized by a shared clock.
;    - The processor reads and writes data in sync with the clock signal, ensuring data integrity.
;  
; 2. **Asynchronous Data Transfer**:
;    - No shared clock. Data is sent with start and stop bits (like UART).
;    - The processor reads and writes when data is available, using a polling mechanism or flags.
;  
; 3. **Interrupt-Driven Data Transfer**:
;    - The processor is interrupted by a device when data is ready for transfer.
;    - Interrupts allow efficient data transfer without continuous polling.
;    - The processor suspends its current task, processes the interrupt, and then returns to its previous state.
;  
; 4. **DMA (Direct Memory Access) Mode Data Transfer**:
;    - In DMA mode, the peripheral transfers data directly to/from memory without CPU involvement.
;    - This frees the CPU for other tasks while the data transfer takes place in the background.
;-----------------------------------------------------------
