;INPUT TWO 8-BIT BINARY NUMBERS AND DISPLAYE THEIR SUM IN BINARY
.model small
.stack 100h
.data
inputMsg1 db "Type First Character: $"
inputMsg2 db "Type Second Character: $"
error_ db "Illegal Number! Tryu Again: $"
outputMsg db "Result: $"
num1 dw ?
num2 dw ?
count db 8
n_line db 0dh, 0ah, "$"
.code
main proc
mov ax, @data
mov ds, ax
;--------------------------------------------

;FIRST NUMBER INPUT
mov ah, 09
mov dx, offset inputMsg1
int 21h
INPUT_BIN: ;input the binary characters
    xor bx, bx  ;clear BX register
    AGAINb:
        cmp count, 0
        jz REMAINb

        mov ah, 1
        int 21h
        dec count  ;counter control
        cmp al, 0dh ;if entered char is carraige return
        je REMAINb
        cmp al, 30h
        jb ILLEGAL_CHARb
        cmp al, 31h
        ja ILLEGAL_CHARb

        STORINGb:
            sub al, 30h
            shl bx, 1
            or bl, al
            jmp AGAINb
        ILLEGAL_CHARb:
            mov count, 16
            mov ah, 09
            mov dx, offset n_line
            int 21h
            mov ah, 09
            mov dx, offset error_
            int 21h
            xor al, al
            jmp INPUT_BIN
            
    REMAINb: ;number is stored in BX

;newline
mov ah, 09
mov dx, offset n_line
int 21h
mov num1, bx
mov count, 8

;SECOND NUMBER INPUT
mov ah, 09
mov dx, offset inputMsg2
int 21h
INPUT_BIN2: ;input the binary characters
    xor bx, bx  ;clear BX register
    AGAINb2:
        cmp count, 0
        jz REMAINb2

        mov ah, 1
        int 21h
        dec count  ;counter control
        cmp al, 0dh ;if entered char is carraige return
        je REMAINb2
        cmp al, 30h
        jb ILLEGAL_CHARb2
        cmp al, 31h
        ja ILLEGAL_CHARb2

        STORINGb2:
            sub al, 30h
            shl bx, 1
            or bl, al
            jmp AGAINb2
        ILLEGAL_CHARb2:
            mov count, 16
            mov ah, 09
            mov dx, offset n_line
            int 21h
            mov ah, 09
            mov dx, offset error_
            int 21h
            xor al, al
            jmp INPUT_BIN2
            
    REMAINb2: ;number is stored in BX

;newline
mov ah, 09
mov dx, offset n_line
int 21h
mov num2, bx

mov ah, 09
mov dx, offset outputMsg
int 21h
mov bx, num1
add bx, num2  ;addition

;RESULT OUTPUT
mov cx, 16
OUTPUT_BINARY:
        mov ah, 02
    AGAIN2:
        cmp cx, 0
        jz REMAIN2

        shl bx, 1
        jc PRINT_ONE

        PRINT_ZERO:
            mov dl, 30h
            jmp DISPLAY

        PRINT_ONE:
            mov dl, 31h
        DISPLAY:
            int 21h
            loop AGAIN2
    REMAIN2:
;--------------------------------------------
END_:
mov ah, 4ch
int 21h
main endp
end main