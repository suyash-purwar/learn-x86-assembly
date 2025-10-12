section .text
global _start

_start:
    MOV eax, 0x1
    MOV bl, 0b11111111
    MOV cl, 0b11

    ADD bl, cl              ; 1111 1111 + 11 => 1 0000 0010
                            ; The 8 bits of bl will hold 0000 0010. The MSB does not move the higher byte in register bh.
                            ; The presence of this carry (MSB) is checked via EFLAGS register. In this case, the CF flag
                            ; is raised. CF means Carry flag.

                            ; This operation raises CF and AF

    ; EFLAGS register is a special-purpose register that stores a collection of status flags, control flags, and system
    ; flags. Each bit in EFLAGS represents a specific condition or control state of the processor. The EFLAGS bit get 
    ; flipped automatically by CPU instructions or manually by you, to record or control what’s happening during execution.

    ; Example of common EFLAGS
    ; PF - Parity Flag
    ; CF - Carry Flag
    ; AF - Auxilary Flag
    ; ZF - Zero Flag
    ; IF - Interrupt Flag
    ; SF - Sign Flag
    ; OF - Overflow Flag

    ADC bh, bl

    MOV bl, 0x45
    MOV cl, 0x1F
    SUB bl, cl

    MOV bl, 0xA
    MOV cl, 0xA
    SUB bl, cl              ; This raises the ZF flag as the result of subtraction is zero.

    MOV bl, 0xD             ; 13
    MOV cl, 0xF3            ; -13
    SUB bl, cl              ; 26   Raises CF flag

    INT 0x80
