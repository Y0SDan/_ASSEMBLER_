;---------------------------------------------------------------------
; Busca el caracter ‘a’ en la cadena Ensamblador y la sustituye por20h
;---------------------------------------------------------------------
.model small
.stack 100h
.data
MEN1 DB 'ENSAMBLADOR$'
INST1 DB 'DIGITA EL CARACTER A BUSCAR:$'
INST2 DB 'DIGITA EL CARACTER QUE VA A REMPLAZAR AL CARAACTER BUSCADO:$'
.code
inicio proc far
;PROTOCOLO
PUSH DS
SUB AX,AX
PUSH AX
MOV AX,@data
MOV DS,AX ; DS=ES
MOV ES,AX
;*****

LEA DX,INST1
CALL MENSAJE
CALL LEE; AL  = CARACTER PRESIONADO
mov bl,al
call salta

LEA DX,INST2
CALL MENSAJE
CALL LEE
MOV Bh,AL
ADD BH,0
call salta

;MOV BL,"A"
;MOV BH,"O"

CLD
L:MOV AL,BL
CMP [DI],'$'
JE EXIT
MOV CX,11
LEA DI,MEN1
REPNE SCASB
JNE EXIT
DEC DI ; DECREMENTAR LA DIRECCION PARA HACER EL REMPLAZO
MOV BYTE PTR[DI],BH ;mover un byte a la localidad apuntada por DI

;CALL LEE
JMP L
EXIT:
LEA DX,MEN1
CALL MENSAJE
CALL FIN
INICIO endp


LEE proc
mov ah,01h
int 21h
ret
LEE endp

FIN PROC
push ax
mov ah,4ch
int 21h
pop ax
FIN ENDP
MENSAJE PROC
PUSH AX
MOV AH,09H
INT 21H
POP AX
RET
MENSAJE ENDP

    salta PROC
        PUSH DX
        MOV  DL,0AH
        CALL escribeChar
        MOV  DL,0DH
        CALL escribeChar
        POP  DX
        RET
    salta ENDP

    escribeChar PROC
        PUSH AX
        MOV  AH,02
        INT  21H
        POP  AX
        RET
    escribeChar ENDP
END INICIO