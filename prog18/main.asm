section .text
global _start

_start:
    PUSH 0x6
    PUSH dword "Parv"
    CALL greet
    ADD esp, 0x8

    MOV eax, 0x1
    MOV ebx, 0x1
    INT 0x80

greet:
    PUSH ebp
    MOV ebp, esp

    SUB esp, 0x8
    MOV dword [ebp-4], 0x4
    MOV dword [ebp-8], "Hey "
    CALL print
    ADD esp, 0x8

    PUSH dword [ebp+12]
    PUSH dword [ebp+8]
    CALL print
    ADD esp, 0x8

    MOV esp, ebp
    POP ebp

    RET

print:
    PUSH ebp
    MOV ebp, esp

    MOV eax, 0x4
    MOV ebx, 0x1
    LEA ecx, [ebp+8]
    MOV edx, [ebp+12]

    INT 0x80

    MOV esp, ebp
    POP ebp

    RET
