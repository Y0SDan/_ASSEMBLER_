;------------------------------------------------------------------
;Rastreo de la tecla "de funcion F12", USANDO int 16h, servicio 10
;------------------------------------------------------------------

;Definicion del satck
.MODEL small
.STACK 20

;Definicion de areas de trabajo
.DATA
    ;Varibales
    MEN DB "Hola...$"

;Area de codigo
.CODE
MAIN PROC FAR
    ;Protocolo
    PUSH ds
    SUB AX,AX
    PUSH AX
    MOV AX,@DATA
    MOV DS,AX

    ;Inicia programa
    CALL LIMPIA
    CALL PREINI

    RET
MAIN ENDP

;Código de procedimientos
LIMPIA PROC NEAR    ;Cambia el color de fondo
    PUSH AX
    PUSH DX
    MOV AX,0600h
    MOV BH,71h
    MOV CX,0000H
    MOV DX,184FH
    INT 10H
    POP DX
    POP AX
LIMPIA ENDP

PREINI PROC NEAR    ;Revisa que la tecla especial precionada 
    MOV AH,10h
    INT 16H
    CMP AL,00H
    JE RASTREA
    CMP AL,0E0H
    JE RASTREA
    JMP SAL1
 RASTREA:
    CMP AH,53H  ;Código de rastreao de la tecla F12
    JNE SAL1
    MOV AH,02
    MOV BH,00
    MOV DX,0C27H
    INT 10H
    LEA DX,MEN
    MOV AH,09
    int 21h
 SAL1: RET
PREINI ENDP    

END MAIN        
