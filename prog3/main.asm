section .data
    char DB "A", 0                      ; Assigned a single character to char. Internally, it is stored as 65 (ASCII)
    string DB "Suyash", 0               ; A sequence of characters stored in continuous blocks of 1 byte
    list DB 43,77,9,18                  ; A sequence of numbers stores in continuous blocks of 1 byte

    string2 DW "Hello", 0                  ; Two bytes are used to store 1 charachter which takes only 1 byte
                                        ; Including null-terminated symbol, total number of byte consumed are 12
section .text
global _start

_start:
    MOV eax, 0x1
    MOV bl, [char]                      ; Assigns the value 65 into register bl
    MOV cl, [string]                    ; Assigns the ASCII value of S into register cl
    MOV dl, [list]                      ; Assigns 43 into dl

    MOV bl, [string + 2]                ; The consecutive blocks can be accessed by adding position number of the block.
                                        ; It points to 'y'.
    MOV bh, [string + 1]                ; Points to 'u'
    MOV cl, [list + 3]                  ; 18
    MOV ch, [list + 2]                  ; 9

    MOV dx, [string2]                   ; Assigns string2 (12 bytes) into register dx (16 bytes)

    INT 0x80
