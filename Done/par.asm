;Programa que imprime los numeros pares hexadecimal hasta el FF

;Definicion de pila
.MODEL small
.STACK 100

;Definicon de areas de trabajo
.DATA
    Men1 DB "Estos son los numeros pares del 0 al FF en hexadecimal"

.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS 
        SUB AX,AX
        PUSH AX
        MOV AX,@DATA
        MOV DS,AX

        ;Inicia programa
        MOV CX,0FFH
        SUB BX,BX
        ADD BL,02
        MOV AL,BL
        CALL desempaqueta

        ;Funciones
        desempaqueta PROC
    PUSH DX
    PUSH CX
    MOV DH,DL
    MOV CL,4
    SHR DL,CL
    CALL binario_ascii
    CALL escribe_car
    MOV DL,DH
    AND DL,0Fh
    CALL binario_ascii
    CALL escribe_car
    POP CX
    POP DX
    RET
desempaqueta ENDP

binario_ascii PROC
    CMP DL,9h
    JG SUMA37
    ADD DL,30h
    JMP FIN2
SUMA37:ADD DL,37h
FIN2:RET
binario_ascii ENDP

      escribe_car PROC
    PUSH AX
    MOV AH,02
    INT 21H
    POP AX
    RET
   escribe_car ENDP
        RET
MAIN ENDP
   END MAIN   
