section .data
    var1 db 210
    var2 db 125

section .text
global _start

_start:
    MOV al, 0b01100101
    MOV bl, 0b00111101
    AND al, bl                          ; 0b00100101

    MOV al, 0b01100101
    MOV bl, 0b00111101
    OR al, bl                           ; 0b01111101

    MOV ax, 0b10011010                  ; Register `ax` is of 16-bits in size and it's value here is 0b00000000_10011010
    NOT ax                              ; Output is 0b11111111_01100101
                                        ; The higher bits got flipped to 1 as well.

                                        ; Now, suppose ax is 0xA and we NOT value of it in the sense that we want to
                                        ; only inverse the bits which are actually written. This is where bitmasks come
                                        ; into picture

    MOV eax, 0x3A                       ; 0x3A = 00111010. It's inverse as per the above definition would be NOT of
                                        ; 00111010 but it also inversts the bit value for rest of the 24 bits. How
                                        ; to prevet this for?
    NOT eax                             ; 0b11111111_11111111_11111111_11000101 (NOT eax)
    AND eax, 0xFF                       ; 0b00000000_00000000_00000000_11111111 (0xFF)
                                        ; 0b00000000_00000000_00000000_11000101 => (0xC5)

    MOV al, [var1]                      ; 210 = 0b11010010
    MOV bl, [var2]                      ; 125 = 0b01111101
    XOR al, bl                          ; Res = 0b10101111

    MOV eax, 0x1
    INT 0x80