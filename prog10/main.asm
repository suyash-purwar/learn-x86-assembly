section .text
global _start

_start:
    MOV al, 0b01011011              ; 91
    SHL al, 1                       ; 0b10110110 => 182
                                    ; This operation makes the MSB 1 which raises the SF bit in EFLAGS
    SAL al, 1                       ; 0b01101100 => 108
                                    ; In this operation, the MSB (which is 1) will be shifted out of 1 byte
                                    ; Hence, the number 182 will not double. This raises the CF bit in EFLAGS.
    SHL al, 2                       ; 0b10110000 => 176
                                    ; Here, left shift by 2 position again pushes out 1 high bit making the number smaller.

                                    ; If the register had been 16-bits, all the shift would've doubled the number because
                                    ; it would've prevented the overflow of high bits.

    SHR al, 1                       ; 0b01011000 => 88
    SHR al, 2                       ; 0b00010110 => 22

    MOV al, 0x85                    ; 10000101 => -123
    SAR al, 1                       ; 11000010 => -62

    MOV eax, 0x1
    INT 0x80


; SHL/SAL = Shifts the bits to the left. SAL and SHL are synonyms. The MSB are 0.
; SHR = Shifts the bits to the right. The MSB are 0.
; SAR = Signed right shifting of the bits. The MSB are filled by 1 to maintain the sign

; 2's complement of 10000101 => 01111011 => -123
; 2's complement of 11000010 => 00111110 => -62