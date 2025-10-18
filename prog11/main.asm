section .data
    age db 22
    adult_msg db "Adult",0,10
    not_adult_msg db "Not Adult",0

section .text
global _start

_start:
    MOV eax, 0x4                            ; Assign 4 to eax to invoke the write syscall
    MOV ebx, 0x1                            ; Sets the file descriptor to 1 which is stdout
    CMP byte [age], 18                      ; Compares 22 with 18
    JL not_adult                            ; Jump to not_adult block if age < 18
    JMP adult                               ; Jump to adult block otherwise

not_adult:
    MOV edx, 0xA                            ; Sets edx to the length of message
    MOV ecx, not_adult_msg                  ; Sets ecx to the address of not_adult
    JMP done                                ; Jump to done block

adult:
    MOV edx, 0x6                            ; Sets edx to the length of message
    MOV ecx, adult_msg                      ; Sets ecx to the address of adult
                                            ; It autmatically moves to the done block as the execution of statements
                                            ; is always linear. Explict jump was necessary in the not_adult block because
                                            ; according to linear execution, it would've executed the adult block which
                                            ; is not what we want. Here, after the adult block there is no block of code that
                                            ; we want to skip. Hence, we can rely on the natural flow of executio.

done:
    INT 0x80                                ; Call the interrupt to execute the write syscall

exit:
    MOV eax, 0x1                            ; This block exits the program
    MOV ebx, 0
    INT 0x80
