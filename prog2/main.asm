section .data
    num db 1
    num2 db 2

section .text
    global _start

_start:
    MOV eax, 1
    MOV ebx, [num]              ; ebx stores 0x20320201 (513 in decimal) instead of 0x2
    MOV ecx, [num2]             ; ecx stores 0x2 which is expected

    ; This happens because of the difference between the number of bytes written and
    ; number of bytes moved to the registers.

    ; The variables num and num2 write 1 byte into the memory. They are saved in the
    ; .data section and their memory location are adjacent. For example, the address of
    ; num and num2 are 0x804a000 and 0x804a001 respectively. Notice, how they are adjacent.

    ; The register eax is of size 4 bytes. Thus, the instruction at line 10 moves 4 bytes
    ; from the address of variable num into the register eax.

    ; ADDR(num) = 0x804a000
    ; The address of 4 bytes will be: 0x804a000, 0x804a001, 0x804a002, 0x804a003
    
    ; x86 uses little-endian. So, the LSB is at the lower-most address. In the above address,
    ; the lower-most address is 0x804a000. So, 0x804a000 is the LSB.
    
    ; So, the order of bytes in which the data will be read is
    ; 0x804a003 0x804a002 0x804a001 0x804a000
    ; So, eax refers to these address in this order. What is stored in these addresses?

    ; As per the instructions on line 10 and 11, address 0x804a000 points to 0x1 and 0x804a001
    ; points to 0x2. Rest 0x804a003 and 0x804a002 point to 0x0.

    ; eax = 0x00 0x00 0x02 0x01
    ; Hence, eax = 0x201


    ; How to fix this?
    ; In x86 32-bit processor, register size is 32. x86 has a concept of sub-registers. It means
    ; a part of register can be addressed as well. For example,
    ; eax = 32 bit
    ; ax = 16
    ; ah = 8 high bits
    ; al = 8 low bits

    ; This same terminonly applies to all the other registers, like ebc, ecx, etc. Modern versions of
    ; x86 assembly are of 64-bit. Here, register names are like rax, rbx, rcx, etc.

    MOV bx, [num]               ; It has the same problem as above. Sub-register `bx` points to 0x201.
    MOV cx, [num2]              ; It points to 0x2 correctly,

    MOV bl, [num]               ; Sub-register `bl` correctly points to 0x1
    MOV cl, [num2]              ; Sub-register `cl` points to 0x2

    INT 0x80