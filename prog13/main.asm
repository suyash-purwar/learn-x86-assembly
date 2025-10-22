section .bss
    char resd 1

section .text
global _start

_start:
    MOV eax, 0x45

    CALL print_name

    MOV eax, 1
    MOV ebx, 1
    INT 0x80

print_name:
    PUSH eax

    ; Prepare printable item
    MOV edx, [esp]                  ; The esp register points to the address of eax
    MOV [char], edx

    MOV eax, 0x4
    MOV ebx, 1
    MOV edx, 1
    MOV ecx, char

    INT 0x80

    POP eax

    RET