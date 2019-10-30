.model small
.stack 100h
.data
msg db "Type a Binary number: $"
error_ db "Illegal number, try again: $"
output db "In HEX it is: $"
count db 16
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
            
    REMAINb:

;newline
mov ah, 09
mov dx, offset n_line
int 21h
mov ah, 09
mov dx, offset output
int 21h

cmp bx, 0dh
je END_

HEX_PRINT:;HEXADECIMAL PRINTING (w.r.t. number in BX)
    ;char function
    mov ah, 02
    ;counter control
    mov count, 4
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
            rol bx, cl
            dec count
            cmp count, 0
            jnz AGAINh
    REMAINh:
;-----------------------------------------------

END_:
mov ah, 4ch
int 21h
main endp
end main