;INPUT A CHARACTER AND PRINT ASCII IN BINARY AND ALSO PRINT NUMBER OF 1 BITS
.model small
.stack 100h
.data
inputMsg db "Type a Character: $"
outputMsgASCII db "ASCII in Binary: $"
outputMsgBits db "No. of 1 Bits: $"
setBits db 0
n_line db 0dh, 0ah, "$"
.code
main proc
mov ax, @data
mov ds, ax
;--------------------------------------------------
;input msg
mov ah, 09
mov dx, offset inputMsg 
int 21h
;input taking
mov ah, 01
int 21h
mov bl, al
;counter control
mov cx, 16
;line break
mov ah, 09
mov dx, offset n_line 
int 21h
;output msg
mov ah, 09
mov dx, offset outputMsgASCII 
int 21h

;binary output loop start
OUTPUT_BINARY:
        mov ah, 02
    AGAIN:
        cmp cx, 0
        jz REMAIN

        shl bx, 1
        jc PRINT_ONE

        PRINT_ZERO:
            mov dl, 30h
            jmp DISPLAY

        PRINT_ONE:
            inc setBits
            mov dl, 31h
        DISPLAY:
            int 21h
            loop AGAIN
    REMAIN:
;line break
mov ah, 09
mov dx, offset n_line 
int 21h
;output msg
mov ah, 09
mov dx, offset outputMsgBits
int 21h
;output no of set bits
add setBits, 48d
mov ah, 02
mov dl, setBits
int 21h


;--------------------------------------------------
mov ah, 4ch
int 21h
main endp
end main