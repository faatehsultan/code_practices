.model small
.stack 100h
.data
msg db "Type a HEX number (0~FFFF): $"
error_ db "Illegal number, try again: $"
output db "In binary it is: $"
counts db 4
char db ?
n_line db 0dh, 0ah, "$"
.code
main proc
mov ax, @data
mov ds, ax


;-----------------------------------------------
;print input msg
mov ah, 09
mov dx, offset msg
int 21h
INPUT_HEX:;input the hex characters
    xor bx, bx  ;clear BX register
    AGAIN:
        cmp counts, 0
        jz REMAIN

        mov ah, 1
        int 21h
        dec counts  ;counter control
        cmp al, 0dh ;if entered char is carraige return
        je REMAIN  
        cmp al, 39h
        jbe DIGIT
        cmp al, 'F'
        ja ILLEGAL_CHAR
        cmp al, 'A'
        jb ILLEGAL_CHAR

        LETTER:
            sub al, 37h
            jmp SHIFT
        DIGIT:
            sub al, 30h
        SHIFT:
            mov cl, 4
            shl bx, cl
            or bl, al
            jmp AGAIN
        ILLEGAL_CHAR:
            mov counts, 4
            mov ah, 09
            mov dx, offset n_line
            int 21h
            mov ah, 09
            mov dx, offset error_
            int 21h
            xor al, al
            jmp INPUT_HEX
            
    REMAIN:

;storage
mov char, al
mov bl, char
;newline
mov ah, 09
mov dx, offset n_line
int 21h
;conunter control
mov cx, 16d
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
;-----------------------------------------------


mov ah, 4ch
int 21h
main endp
end main