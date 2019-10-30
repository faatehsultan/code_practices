;INPUT A CHARACTER AND PRINT ASCII IN HEXADECIMAL FORMATE
.model small
.stack 100h
.data
count db ?
n_line db 0dh, 0ah, "$"
.code
main proc
mov ax, @data
mov ds, ax

INPUT:
    mov ah, 01
    int 21h
    mov bl, al
    
;line break
mov ah, 09
mov dx, offset n_line
int 21h


HEX_PRINT:;HEXADECIMAL PRINTING (w.r.t. number in BX)
    ;char function
    mov ah, 02
    ;counter control
    mov count, 4
    ;loop starts
    AGAIN:
        mov dl, bh
        mov cl, 4   ;no of shifts
        shr dl, cl  ;shifting
        cmp dl, 9
        ja LETTER
        
        DIGIT:
            add dl, 30h
            jmp DISPLAY
        LETTER:
            add dl, 37h
            jmp DISPLAY

        DISPLAY:
            int 21h
            rol bx, cl
            dec count
            cmp count, 0
            jnz AGAIN


;END
mov ah, 4ch
int 21h
main endp
end main