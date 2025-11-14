section .text
global sum
global mul

sum:
    PUSH ebp
    MOV ebp, esp

    MOV eax, [ebp+8]
    ADD eax, [ebp+12]

    MOV esp, ebp
    POP ebp

    RET

; Handles 16 bit operands
mul:
    PUSH ebp
    MOV ebp, esp

    MOV al, [ebp+8]
    MUL word [ebp+12]

    MOV esp, ebp
    POP ebp

    RET