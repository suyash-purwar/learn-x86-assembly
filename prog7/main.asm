section .text
global _start

_start:
    MOV ax, 0x31                        ; Small dividend
    MOV cx, 0x8

    MOV dx, 0
    DIV cx                              ; DIV sees the operands as unsigned numbers whereas IDIV sees them as signed.
                                        ; Here, DX will read the operand as `dx:ax`. We've not assigned any value to the
                                        ; `dx` register. So, it might read the garbage value present over there. For
                                        ; consistent result, we zero-out the high-bit register. Hence, saving the 0 in 
                                        ; `dx` before the division operation.
                                        ; Here, dividend is read as 0x00000031. First four 0s are from the `dx` register 
                                        ; and the last four form the `ax` register.
                                        ; are from `

    MOV al, 0x5                         ; Dividend = 5
    MOV ah, 0
    MOV cl, 0xA                         ; Divisor = 10
    DIV cl                              ; Quotient becomes = 0 and Remainder = 5

    MOV ax, 0x2F2A                      ; 0x2F2A = 12074
    MOV dx, 0x12                        ; 0x12 = 34
                                        ; Dividend = dx:ax = 0x122F2A = 1191722
    MOV cx, 0xA7                        ; Divisor = 167
    DIV cx                              ; Quotient becomes = 0x1BE0 = 7136 and Remainder = 0xA = 10

    ; Following are failing instructions due to Arithmetic Exception

    MOV ax, 0x2F2A                      ; 0x2F2A = 12074
    MOV dx, 0x12                        ; 0x12 = 34
                                        ; Dividend = dx:ax = 0x122F2A = 1191722
    MOV cx, 0x7                         ; Divisor = 7
    ; DIV cx                            ; Here, the quotient is 0x29906 which cannot fit in the register `ax`. This
                                        ; leads to overflow and raises Divide Error. In Linux, this is SIGFPE (FLoating
                                        ; Point Exception)

    MOV ax, 0xA
    MOV cx, 0x0
    ; DIV cx                            ; Diving by zero raises Arithmetic Exception

    MOV eax, 0x1
    INT 0x80

; The DIV operation will read the dividend (0x31) by reading not just the register `ax` but like `dx:ax`.
; Mathematically, multiplication and division are inverse of each other. MUL combines 2 numbers into 1 larger number
; whereas  DIV splits 1 large number into 2 smaller numbers.
; The MUL operation writes to the `dx:ax` register to save the result which is double the size of the operands. Since
; division is the inverse, the DIV operation reads from from the `dx:ax` register.
; MUL Operation:     Input: 2 items (EAX, ECX) -> Output: 1 result (EDX:EAX)
; DIV Operation:     Input: 1 result (EDX:EAX), divisor (ECX) -> Output: 2 items (EAX, EDX)

; Doing this allows a 32-bit system to do division on 64-bit numbers. The result of this operation are quotient, and
; remainder which are saved in the `ax` and `dx` register of 16-bit each.

; Imp: Make sure to zero-out the ah\dx\edx register if it is not being set to some other value. This prevents the garbage
; value from being used.