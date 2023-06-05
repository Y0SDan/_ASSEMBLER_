;PROGRAMA QUE LIMPIA LA PANTALLA

; Definicion de stack
.MODEL small
.STACK  100

;DEFINICION DE AREAS DE TRABAJO
.DATA
MSG1 DB "CARACTER A DESPLEGAR :$"
MSG2 DB 13, 10, " $"
RENGLON DB 0
COLUMNA DB 0

.CODE
PRINCI PROC FAR
   ;PROTOCOLO
   push ds
   sub ax,ax
   push ax
   MOV AX,@DATA
   MOV DS,AX
  

   ;INICIA PROGRAMA

    CALL limpiar_pantalla
    MOV RENGLON, 10
    MOV COLUMNA, 20
    call  POS_CUR
    LEA DX, MSG1
    CALL MENSAJE
    CALL LEE
    LEA DX, MSG2
    CALL MENSAJE
    MOV RENGLON, 15
    MOV COLUMNA, 20
    call  POS_CUR
    MOV DL, AL
    CALL escribe_car
 
   CALL SALIR_DOS
PRINCI ENDP



ESCRIBE PROC
   MOV AH,02
   INT 21H
 RET
ESCRIBE ENDP

SALIR_DOS PROC
   MOV AH,4CH
   INT 21H
RET
SALIR_DOS ENDP


MENSAJE PROC
PUSH AX
MOV AH,09H
INT 21H
POP AX
RET
MENSAJE ENDP

LEE PROC
MOV AH,01
INT 21H
RET
LEE ENDP

POS_CUR PROC
PUSH AX
PUSH BX
PUSH DX
MOV AH,02
MOV BH,0
MOV DH,RENGLON ; RENGLON
MOV DL,COLUMNA ; COLUMNA
INT 10h
POP DX
POP BX
POP AX
RET
POS_CUR ENDP

limpiar_pantalla PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AX,0600h
MOV BH,71h      ; FONDO BLANCO CON PRIMER PLANO AZUL
MOV CX,0000H    ;coordenada inicial
MOV DX,184FH    ;coordenada final
INT 10h
POP DX
POP CX
POP BX
POP AX
RET
limpiar_pantalla ENDP

escribe_car PROC
PUSH AX
MOV AH,02 ; Caracter a desplegar almacenado en dl
INT 21h
POP AX
RET
 escribe_car ENDP

END PRINCI
  
;80 Columnas
;           ------------------------->
;24         |
;Renglones  |
;           |
;           |
;           |
;           |
;           |
;r,c -> 0,0