section .data
    start db 0
    end db 10

section .bss
    char resb 1

section .text
global _start

_start:
    
loop:
    MOV al, [start]
    CMP al, [end]
    JE after_loop

    ; Create printable string
    ADD al, '0'
    MOV [char], al

    ; Print the character
    MOV eax, 4
    MOV ebx, 1
    MOV ecx, char
    MOV edx, 1
    INT 0x80

    ; Print the space
    MOV byte [char], ' '
    MOV eax, 4
    MOV ebx, 1
    MOV ecx, char
    MOV edx, 1
    INT 0x80

    ; Increment the counter
    ADD byte [start], 1
    
    JMP loop

after_loop:
    ; Print the new line character
    MOV byte [char], 10
    MOV eax, 4
    MOV ebx, 1
    MOV ecx, char
    MOV edx, 1
    INT 0x80

done:
    MOV eax, 1
    MOV ebx, 0
    INT 0x80
