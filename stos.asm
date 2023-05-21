;---------------------------------------------------------------------
;ALMACENA 10 CARACTERES BLANCOS A LA CADENA MEN1
;---------------------------------------------------------------------
.model small
.stack 100h
.data
MEN1 DB 'ENSAMBLADOR$'
.code
inicio proc far
;PROTOCOLO
PUSH DS
SUB AX,AX
PUSH AX
MOV AX,@data
MOV DS,AX ; OBSERVESE QUE DS=ES
MOV ES,AX ;ya que se esta utilizando di se agrega esta inea
;***********
LEA DI,MEN1
MOV DX,DI
CALL MENSAJE

CLD
MOV AX,2020H
MOV CX,05

LEA DI,MEN1
REP STOSW ;Significa que voy a mover todo lo que esta en ax a la direccion apuntada por di y desues vulevo a escribir el mensaje
                ;esto puede servir para limpiar una zona de memoria de una manera mas rapida usando un prefijo
LEA DX,MEN1
CALL MENSAJE
CALL FIN
INICIO endp
FIN proc
push ax
mov ah,4ch
int 21h
pop ax
FIN endp
MENSAJE PROC
PUSH AX
MOV AH,09H
INT 21H
POP AX
RET
MENSAJE ENDP
end inicio