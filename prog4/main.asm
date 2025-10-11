section .bss
    var1 resb 2

section .data
    var2 db 6

section .text
global _start

_start:
    MOV eax, 0x1
    MOV ebx, 0x1

    ; MOV [var2], 0x45              ; This line doesn't work because CPU doesn't know how many bytes to write to memory
                                    ; address of var2. One might wonder why can't it assign the enough bytes required
                                    ; for the constant.
                                    
                                    ; It is not the job of the assemlber to interpret things, it is the job of higher
                                    ; level abstractions like type-system in languages like C, Python.

                                    ; Second question would be we've already defiend that var2 is of 1 byte in size
                                    ; at line 5. It does have the information. Why can't it collect this information
                                    ; from there?

                                    ; Line 5 reserves 1 byte in memory and gives it a label of var1. The assembler
                                    ; doesn't store the size information with the label. A label shouldn't be
                                    ; looked at as a variable which stores the size information.

    MOV byte [var2], 0x45           ; This is correct as it specifies the number of bytes to read at address of var2.

    ; MOV word [var1], [var2]       ; Move var2 content of 1 byte size into var1 of size 2 bytes. We are transfering
                                    ; contents from one memory address to the other. This is called memory-to-memory
                                    ; transfer and it is NOT allowed in x86 architecture.

    MOV bl, [var2]                  ; Here, we moved the contents of var2 first to the bl register. And then moved
    MOV [var1], bl                  ; the contents at register bl into var1. memory -> register -> memory.

    INT 0x80