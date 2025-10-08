global initialised_static_var
global uninitialised_static_var

section .data
    is_single db 1          ; db => define byte (1 byte)
    year dw 2002            ; dw => define word (2 bytes)
    age dd 22               ; dd => define doubleword (4 bytes)
    phone_no dq 9051765425  ; dq => define quadword (8 bytes)

    initialised_static_var db 1

section .bss
    var1 resb 3             ; resb (reserve byte) => reserves 1 byte into memory (uninitialised)
    var2 resw 2             ; resw (reserve word) => reserves 2 word into memory. 2 word = 2 x 1 word = 4 bytes
    var3 resd 2             ; resd (reserve doubleword) => reserves 2 doubleword. 2 doubleword = 8 bytes
    var4 resq 3             ; resq (reserve quadword) => reserves 3 quadword which is equal to 24 bytes

    uninitialised_static_var resw 2

section .text
    global _start

_start:
    MOV eax, 0x1            ; 1 is used for the exit syscall
    MOV ebx, 0x69           ; 0x69 is the exit code
    INT 0x80                ; INT refers to interrupt with 0x80 as the interrupt vector number. 0x80 triggers syscall
                            ; based on the value in the EAX register


; By default all the global variables defined in the .data and .bss section are static in nature.
; To make them global, the keyword global has to be used

; In a general sense, the word "word" refers to the register size of a processor. With that logic,
; the word size for x86 32-bit processor should be bytes but dw refers to 2 bytes instead of 4.
; This is because the earliest version x86 was of 16-bit and Intel never changed the convention.
; Now, this processor has evolved to have register sizes of 32 and 64 bit.
