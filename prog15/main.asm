section .data
    factorial db 1
    is_res_even db 1
    even_msg db "Even", 0
    odd_msg db "Odd", 0

section .text
global _start

_start:
    PUSH 1
    CALL calculate_factorial
    ADD esp, 4

    CALL is_even
    CALL print_result

    JMP exit

calculate_factorial:
    MOV al, 0x1
.loop:
    CMP al, [esp+4]
    JG .done

    PUSH eax
    MUL byte [factorial]
    MOV [factorial], al
    POP eax

    INC al
    JMP .loop
.done:
    RET

is_even:
    MOV al, [factorial]
    MOV cl, 0x2
    XOR ah, ah

    DIV cl
    MOV [is_res_even], ah
    RET

print_result:
    CMP byte [is_res_even], 0
    JE .print_even
    JMP .print_odd
.print_even:
    MOV ecx, even_msg
    PUSH ecx
    PUSH 4
    CALL print
    JMP .done
.print_odd:
    MOV ecx, odd_msg
    PUSH ecx
    PUSH 3
    CALL print
.done:
    ADD esp, 8
    RET

print:
    MOV eax, 0x4
    MOV ebx, 0x1
    MOV ecx, [esp+8]
    MOV edx, [esp+4]

    INT 0x80
    RET

exit:
    MOV eax, 0x1
    MOV ebx, 0x1
    
    INT 0x80