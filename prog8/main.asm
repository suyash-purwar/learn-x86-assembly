section .text
global _start

_start:
    ; Instrutions to divide -1 by 2
    MOV ax, 0xFFFF                      ; IDIV reads this as 0x0000FFFF which makes it a positive value. The presence of
                                        ; negative sign needs to be reflected by higher bits. Unless the higher-bits
                                        ; register is being set to some other value, set it to high bits if the dividend
                                        ; is a negative number. Due to this, register `dx` is being set to 0xFFFF.

                                        ; Register `ax` without dx = 0xFFFF: 0x0000FFFF (65535).
                                        ; Register `ax` with dx = 0xFFFF: 0xFFFFFFFF (-1).
    MOV cx, 0x2
    MOV dx, 0xFFFF
    IDIV cx                             ; Interprets 0xFF as -1 and divides it by 2.
                                        ; Register `eax` becomes 0x0 and `edx` becomes `0xFFFF`.

    MOV eax, 0x1
    INT 0x80

; IDIV sees the operands as signed numbers. All the concepts of DIV apply here.
; Imp: Make sure to set the ah\dx\edx register to high-bits if the dividend is a negative number. This enables the
; propagation of negative sign to higher-bit register.
