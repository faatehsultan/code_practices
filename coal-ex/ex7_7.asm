;INPUT DECIMAL STRING AND PRINT SUM IN HEX (BY FAATEH SULTAN)
.model small
.stack 100h
.data
inputMsg db "Enter Decimal String: $"
error_ db "Illegal Number! Try Again: $"
outputMsg db "Result: $"
result dw 0
n_line db 0dh, 0ah, "$"
.code
main proc
mov ax, @data
mov ds, ax
;--------------------------------------------------

;INPUT DEC STRING
mov ah, 09
mov dx, offset inputMsg
int 21h
INPUT_DEC_STRING:
    xor bx, bx  ;clear BX register
    AGAIN:
        mov ah, 1
        int 21h
        cmp al, 0dh ;if entered char is carraige return
        je REMAIN 
        cmp al, 39h
        ja ILLEGAL_CHAR
        cmp al, 30h
        jb ILLEGAL_CHAR

        ADDITION:
            mov bl, al
            xor ax, ax
            add al, bl
            add result, ax
            jmp INPUT_DEC_STRING

        ILLEGAL_CHAR:
            mov ah, 09
            mov dx, offset n_line
            int 21h
            mov ah, 09
            mov dx, offset error_
            int 21h
            jmp INPUT_DEC_STRING
            
    REMAIN:
mov ah, 09
mov dx, offset n_line
int 21h



;OUTPUT
xor bx, bx
mov bx, result
sub bx, 90h
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
            shl bx, cl
            cmp bx, 0
            jne AGAINh
    REMAINh:

;--------------------------------------------------
mov ah, 4ch
int 21h
main endp
end main