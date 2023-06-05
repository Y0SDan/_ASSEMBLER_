;---------------------------------------------------------------------
; Busca el caracter ‘a’ en la cadena Ensamblador y la sustituye por 20h
;---------------------------------------------------------------------
.model small
.stack 100h
.data
MEN1 DB 'ENSAmBLADOR$'
.code
inicio proc far
;PROTOCOLO
PUSH DS
SUB AX,AX
PUSH AX
MOV AX,@data
MOV DS,AX ; DS=ES
MOV ES,AX
;***********
CLD
MOV AL,'A'
MOV CX,11
LEA DI,MEN1
REPNE SCASB
JNE EXIT
DEC DI ; DECREMENTAR LA DIRECCION PARA HACER EL REMPLAZO
MOV BYTE PTR[DI],20H ;mover un byte a la localidad apuntada por DI
LEA DX,MEN1
CALL MENSAJE
CALL LEE
EXIT:CALL FIN
INICIO endp
LEE proc
push ax
mov ah,01h
int 21h
pop ax
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
END INICIO
