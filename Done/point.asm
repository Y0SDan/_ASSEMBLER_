;Programa que muestra diferentes modos de video

;Definicion de stack
.MODEL small
.STACK 100

;Definicion de trabajo
.DATA
    ;Variable
    Y DW 320
    X DW 240
    COLOR DB 0
    modoG DB "Modo grafico 80 x 30  8 x 16 640 x 480 16 / 256k  A000 VGA, ATI, vip $", 0 

.CODE
PRINCI PROC FAR
    ;PROTOCOLO
    PUSH ds
    SUB AX,AX
    PUSH AX
    MOV AX,@DATA
    MOV DS,AX

    ;Inicia programa
    CALL GRAPH
    MOV DX, offset modoG
    MOV AH,9
    INT 21H
    MOV AH,0
    INT 16H

    OTRO: 
          MOV COLOR,15
          CALL PUNTO
          CALL READKEY
          CMP AL,56
            JE UP
          CMP AL,50
            JE DOWN
          CMP AL,54
            JE RIGHT
          CMP AL,52
            JE LEFT
          CMP AL,27
            JE SALIR
          JNE OTRO

    UP:       

;--------------------------------- SUBRUTINAS -----------------------------

PUNTO PROC
    MOV AH,0CH
    MOV AL,COLOR
    MOV BH,0
    MOV CX,Y
    MOV DX,x
    INT 10H
    RET
PUNTO ENDP

GRAPH PROC
    MOV AH,00h
    MOV AL,12H
    INT 10h
    RET
GRAPH ENDP

READKEY PROC
    MOV AH,07H
    INT 21H
    RET
READKEY ENDP

DOS PROC
    MOV AH,00H
    MOV AL,03H
    INT 10H
    RET
DOS ENDP    

