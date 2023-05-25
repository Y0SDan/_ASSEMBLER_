inicio macro
    mov ax,@data
    mov ds,ax
    mov dx,ax
endm

pos_cur macro fila, columna
    push ax
    push bx
    push dx
    mov ah,02h
    mov dh,fila
    mov dl,columna
    mov bh,0
    int 10h
    pop dx
    pop bx
    pop ax
endm

escribe_cad macro msj
    push dx
    push ax
    lea dx,msj
    mov ah,09
    int 21h
    pop ax
    pop dx
endm

.model small
.stack 64
.data
    msj db 'Este es mi primer macro', 10,13,'$'
    
.code
MAIN PROC
    inicio
    pos_cur 5,20
    escribe_cad msj
    ;mov ah,09h
    ;lea dx,msj
    ;int 21h
    mov ax,4c00h
    int 21h
MAIN ENDP
END MAIN