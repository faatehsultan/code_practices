;INPUT TWO HEX NUMBERS (0~FFh)  AND PRINT THEIR SUM AND DIFF IN HEX WITH UNSIGNED OVERFLOW HANDLED
.model small
.stack 100h
.data
msg db "Type a HEX number (0~FF): $"
error_ db "Illegal Number! Try Again: $"
outputMsg1 db "sum: $"
outputMsg2 db "difference: $"
num1 db ?
num2 db ?
n_line db 0dh, 0ah, "$"
counts db 2
.code
main proc
mov ax, @data
mov ds, ax
;--------------------------------------------------

;INPUT 1ST HEX
mov ah, 09
mov dx, offset msg
int 21h
INPUT_HEX1:;input the hex characters
    xor bl, bl  ;clear BX register
    AGAIN1:
        cmp counts, 0
        jz REMAIN1

        mov ah, 1
        int 21h
        dec counts  ;counter control
        cmp al, 0dh ;if entered char is carraige return
        je REMAIN1  
        cmp al, 39h
        jbe DIGIT1
        cmp al, 'F'
        ja ILLEGAL_CHAR1
        cmp al, 'A'
        jb ILLEGAL_CHAR1

        LETTER1:
            sub al, 37h
            jmp SHIFT1
        DIGIT1:
            sub al, 30h
        SHIFT1:
            mov cl, 4
            shl bx, cl
            or bl, al
            jmp AGAIN1
        ILLEGAL_CHAR1:
            mov counts, 2
            mov ah, 09
            mov dx, offset n_line
            int 21h
            mov ah, 09
            mov dx, offset error_
            int 21h
            xor al, al
            jmp INPUT_HEX1
            
    REMAIN1:
mov num1, bl
mov ah, 09
mov dx, offset n_line
int 21h
;INPUT 2ND HEX
mov counts, 2
mov ah, 09
mov dx, offset msg
int 21h
INPUT_HEX2:;input the hex characters
    xor bl, bl  ;clear BX register
    AGAIN2:
        cmp counts, 0
        jz REMAIN2

        mov ah, 1
        int 21h
        dec counts  ;counter control
        cmp al, 0dh ;if entered char is carraige return
        je REMAIN2  
        cmp al, 39h
        jbe DIGIT2
        cmp al, 'F'
        ja ILLEGAL_CHAR2
        cmp al, 'A'
        jb ILLEGAL_CHAR2

        LETTER2:
            sub al, 37h
            jmp SHIFT2
        DIGIT2:
            sub al, 30h
        SHIFT2:
            mov cl, 4
            shl bx, cl
            or bl, al
            jmp AGAIN2
        ILLEGAL_CHAR2:
            mov counts, 2
            mov ah, 09
            mov dx, offset n_line
            int 21h
            mov ah, 09
            mov dx, offset error_
            int 21h
            xor al, al
            jmp INPUT_HEX2
            
    REMAIN2:
mov num2, bl
mov ah, 09
mov dx, offset n_line
int 21h
;PRINTING THE SUM
xor bx, bx
mov bh, num1
add bh, num2

mov ah, 09
mov dx, offset outputMsg1
int 21h
;CARRY CHECK
jnc HEX_PRINT
    PRINT_CARRY:
    mov ah, 02
    mov dl, '1'
    int 21h
;OUTPUT
HEX_PRINT:;HEXADECIMAL PRINTING (w.r.t. number in BX)
    ;char function
    mov ah, 02
    ;loop starts
    AGAINh:
        mov dl, bh
        mov cl, 4   ;no of shifts
        shr dl, cl  ;shifting
        cmp dl, 9
        ja LETTERh
        
        DIGITh:
            add dl, 30h
            jmp DISPLAYh
        LETTERh:
            add dl, 37h
            jmp DISPLAYh

        DISPLAYh:
            int 21h
            shl bh, cl
            cmp bx, 0
            jne AGAINh
    REMAINh:

mov ah, 09
mov dx, offset n_line
int 21h

;PRINTING THE Difference
xor bx, bx
mov bh, num1
sub bh, num2

mov ah, 09
mov dx, offset outputMsg2
int 21h
;OUTPUT
HEX_PRINT2:;HEXADECIMAL PRINTING (w.r.t. number in BX)
    ;char function
    mov ah, 02
    ;loop starts
    AGAINh2:
        mov dl, bh
        mov cl, 4   ;no of shifts
        shr dl, cl  ;shifting
        cmp dl, 9
        ja LETTERh2
        
        DIGITh2:
            add dl, 30h
            jmp DISPLAYh2
        LETTERh2:
            add dl, 37h
            jmp DISPLAYh2

        DISPLAYh2:
            int 21h
            shl bh, cl
            cmp bx, 0
            jne AGAINh2
    REMAINh2:

;--------------------------------------------------
mov ah, 4ch
int 21h
main endp
end main