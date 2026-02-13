; =============================================================================
;                COMPLETE x86-64 ASSEMBLY LANGUAGE COURSE
;            BASIC → INTERMEDIATE → ADVANCED (Linux NASM)
;
; Registers:
;   rax, rbx, rcx, rdx, rsi, rdi, rbp, rsp
;
; System call convention (Linux x86-64):
;   rax = syscall number
;   rdi, rsi, rdx, r10, r8, r9 = arguments
;   syscall instruction executes
; =============================================================================

section .data
    ; Strings must end with newline (10) if needed
    msg db "========= ASSEMBLY FULL COURSE START =========", 10
    msg_len equ $ - msg

    hello db "Hello, Assembly!", 10
    hello_len equ $ - hello

    newline db 10

    num1 dq 10
    num2 dq 3

section .bss
    result resq 1      ; reserve 8 bytes (64-bit)

section .text
    global _start

; =============================================================================
;                                   ENTRY POINT
; =============================================================================
_start:

    ; -------------------------------------------------------------------------
    ; 1️⃣ PRINT STRING (sys_write)
    ; -------------------------------------------------------------------------
    mov rax, 1              ; syscall: sys_write
    mov rdi, 1              ; stdout
    mov rsi, msg            ; address of string
    mov rdx, msg_len        ; length
    syscall

    ; -------------------------------------------------------------------------
    ; 2️⃣ PRINT ANOTHER STRING
    ; -------------------------------------------------------------------------
    mov rax, 1
    mov rdi, 1
    mov rsi, hello
    mov rdx, hello_len
    syscall

    ; -------------------------------------------------------------------------
    ; 3️⃣ ARITHMETIC OPERATIONS
    ; -------------------------------------------------------------------------

    ; Load values into registers
    mov rax, [num1]     ; rax = 10
    mov rbx, [num2]     ; rbx = 3

    ; Addition
    add rax, rbx        ; rax = rax + rbx
    mov [result], rax   ; store result

    ; Subtraction
    mov rax, [num1]
    sub rax, rbx

    ; Multiplication
    mov rax, [num1]
    imul rbx            ; rax = rax * rbx

    ; Division
    mov rax, [num1]
    mov rdx, 0          ; clear rdx before division
    div rbx             ; rax = rax / rbx

    ; -------------------------------------------------------------------------
    ; 4️⃣ CONDITIONAL (COMPARE + JUMP)
    ; -------------------------------------------------------------------------

    mov rax, 5
    mov rbx, 10

    cmp rax, rbx        ; compare rax with rbx
    jl less_label       ; jump if less

greater_label:
    ; do nothing
    jmp continue

less_label:
    ; do nothing

continue:

    ; -------------------------------------------------------------------------
    ; 5️⃣ LOOP (using rcx)
    ; -------------------------------------------------------------------------

    mov rcx, 5          ; loop counter

loop_start:
    cmp rcx, 0
    je loop_end         ; exit if rcx == 0

    dec rcx
    jmp loop_start

loop_end:

    ; -------------------------------------------------------------------------
    ; 6️⃣ STACK OPERATIONS
    ; -------------------------------------------------------------------------

    mov rax, 100
    push rax            ; push value onto stack

    pop rbx             ; pop into rbx

    ; -------------------------------------------------------------------------
    ; 7️⃣ FUNCTION CALL
    ; -------------------------------------------------------------------------

    call my_function

    ; -------------------------------------------------------------------------
    ; 8️⃣ EXIT PROGRAM
    ; -------------------------------------------------------------------------
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status 0
    syscall

; =============================================================================
;                              FUNCTION DEFINITION
; =============================================================================
my_function:

    ; Simple function example
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ret

; =============================================================================
;                    ADVANCED CONCEPTS EXPLAINED BELOW
; =============================================================================

; -----------------------------------------------------------------------------
; 9️⃣ MEMORY ADDRESSING MODES
; -----------------------------------------------------------------------------
; mov rax, [num1]       ; direct memory
; mov rax, [rbx]        ; register indirect
; mov rax, [rbx + 8]    ; offset
; mov rax, [rbx + rcx]  ; indexed

; -----------------------------------------------------------------------------
; 🔟 BITWISE OPERATIONS
; -----------------------------------------------------------------------------
; and rax, rbx
; or  rax, rbx
; xor rax, rax          ; zero register
; shl rax, 1            ; shift left
; shr rax, 1            ; shift right

; -----------------------------------------------------------------------------
; 1️⃣1️⃣ FLAGS REGISTER
; -----------------------------------------------------------------------------
; cmp affects flags:
; ZF (zero flag)
; CF (carry flag)
; SF (sign flag)

; -----------------------------------------------------------------------------
; 1️⃣2️⃣ INTERRUPTS (OLD 32-bit)
; -----------------------------------------------------------------------------
; int 0x80              ; old Linux syscall method

; -----------------------------------------------------------------------------
; 1️⃣3️⃣ SYSTEM CALL TABLE (Common)
; -----------------------------------------------------------------------------
; 1   = write
; 0   = read
; 60  = exit

; -----------------------------------------------------------------------------
; 1️⃣4️⃣ POINTERS
; -----------------------------------------------------------------------------
; mov rax, num1         ; address
; mov rbx, [rax]        ; dereference

; -----------------------------------------------------------------------------
; 1️⃣5️⃣ CALL STACK STRUCTURE
; -----------------------------------------------------------------------------
; call pushes return address
; ret pops return address

; -----------------------------------------------------------------------------
; 1️⃣6️⃣ DEBUGGING
; -----------------------------------------------------------------------------
; gdb ./program
; break _start
; run
; info registers
; stepi

; =============================================================================
;                           END OF PROGRAM
; =============================================================================
