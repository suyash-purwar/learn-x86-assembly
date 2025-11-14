section .text

extern sum
extern mul

global _start

_start:
    MOV ebp, esp

    SUB esp, 16
    MOV dword [ebp-4], 0xA
    MOV dword [ebp-8], 0xC

    PUSH dword [ebp-4]
    PUSH dword [ebp-8]
    CALL sum
    MOV [ebp-12], eax
    ADD esp, 8

    PUSH dword [ebp-4]
    PUSH dword [ebp-8]
    CALL mul
    MOV [ebp-16], eax
    ADD esp, 8

    MOV eax, 0x1
    MOV ebx, 0x1
    INT 0x80
