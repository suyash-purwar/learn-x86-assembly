section .text
global _start

_start:
    MOV al, 0xA
    MOV bl, 0x3
    MUL bl                      ; The resultant value is saved either in AH:AL, DX:AX, EDX:EAX registers depending
                                ; on the operands size. For example, the multiplication of two 16-bit numbers will
                                ; yield a 32-bit number. The lower bits of this number will be saved in AX and the higher
                                ; bits in the DX. The complete number will be read as DX:AX. Similarly, for 32-bit
                                ; operands, the result will be save using the EDX and EAX registers consuming a total
                                ; of 64 bits

    MOV al, 0xFF                ; -1
    MOV bl, 0x3                 ; 3
    MUL bl                      ; Imp. Note: MUL instruction considers the operands as unsigned integers.
                                ; 0xFF is 255 when considered as unsigned numbers
                                ; 0xFF X 0x3 = 0x2FD (765 in decimal)
                                ; This raises the OF, CF, SF, and AF bits in EFLAGS
                                ; In x86 architecture, after the MUL instruction, the CF and OF flags are set to 0
                                ; if upper bits are (AX/DX/EDX) are 0, otherwise 1.
                                ; The SF, ZF, AF, and PF flags are undefined and should be ignored. Whatever garbage
                                ; value is there at the time of execution, shows up there.

    MOV al, 0xFF
    MOV bl, 0xFF
    MUL bl

    MOV ax, 0x2002              ; 0x2002 => 0010 0000 0000 0010 => 8194
    MOV bx, 0x6B                ; 0x6B => 0110 1011 => 107
    MUL bx                      ; 0x2002 X 0x6B = 0xD60D6
                                ; The resultant number in decimal is 876758. 2 bytes of the `ax` registers cannot hold
                                ; this number. The higher bits get saved in the `dx` register
                                ; So, 0x60D6 (lower 16 bits) are saved in the `ax` register. The higher 16 bits (0x0006)
                                ; are saved in the `dx` register.

                                ; Similarly, if whole `eax` and `ebx` register had been used, the higher bits (if any)
                                ; would reside to the `edx` register.

    MOV al, 0xA1                ; 0xA1 => 1010 0001 => 161
    MOV bl, 0x2                 ; 2
    IMUL bl                     ; With IMUL, operands are read as signed integers. So, in this context, 0xA1 is not 161.
                                ; 0xA1 => 1010 0001 => 2's complement => 0101 1111 => -95
                                ; -95 x 2 => -190. Range of signed numbers in 8 bits is -128 to 127. So, -190 will
                                ; overflow to the register `ah` occupying 8 more bits.
                                ; 190 => 0000 0000 1011 1110
                                ; -190 => 2's complement(0000 0000 1011 1110) => 1111 1111 0100 0010 => 0xFF42
                                ; Register `ah` holds the higher bits (0xFF) whereas `al` holds lower bits (`0x42`)

    MOV al, 0xA1
    MOV bl, 0xA1
    IMUL bl

    MOV eax, 0x1                ; Setting to 0x1 to invoke exit syscall
    INT 0x80
