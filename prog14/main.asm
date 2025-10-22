section .data
    start db 0
    end db 10
    newline dd '',0,10

section .bss
    char resd 1

section .text
global _start

_start:
    MOV al, [start]

loop:
    CMP al, [end]
    JE exit_loop
    
    MOV [char], al
    ADD dword [char], '0'

    PUSH char
    CALL print
    ADD esp, 4

    MOV dword [char], ' '
    PUSH char
    CALL print
    ADD esp, 4

    INC al
    JMP loop

print:
    PUSH eax

    MOV eax, 0x4
    MOV ebx, 0x1
    MOV ecx, [esp + 8]
    MOV edx, 0x1

    INT 0x80

    POP eax
    RET

exit_loop:
    PUSH newline
    CALL print
    ADD esp, 4

exit:
    MOV eax, 1
    MOV ebx, 1
    INT 0x80