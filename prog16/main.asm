section .text
global _start

_start:
    MOV eax, 0x1                ; Say it's obtained from some other operation above
                                ; and we need it till the end of program
    MOV ebx, 0xA
    MOV ecx, 0x3

    PUSH eax                    ; Push it to stack so that it is safe from overrides
                                ; by the multiply and double procedures
    PUSH ecx                    ; The multiply procedure needs this argument
    PUSH ebx                    ; The multiply procedure needs this argument
    CALL multiply               ; Here, the eip registers changes to address of
                                ; instruction at line 16
                                ; By convention the output of a procedure is saved in
                                ; the eax register
    MOV ebx, eax                ; Move the contents of eax to the ebx register. This
                                ; is done to save the value of the eax.
    ADD esp, 8                  ; Clearup the arguments from stack
    POP eax

    JMP exit

multiply:
    MOV eax, [esp+4]            ; Access the first argument passed
    MOV ebx, [esp+8]            ; Access the second argument passed
    MUL ebx            
    RET                         ; Return back to the callee
                                ; Assign the eip register to the address of
                                ; instruction at line 16

exit:
    MOV eax, 0x1
    MOV ebx, 0x1
    INT 0x80