;Buscar un caracter dentro de una cadena 
.MODEL small
.STACK 100

.DATA
    numeritos DB "1,2,3,4,5,6,7,8,9"

.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB AX,AX
        PUSH AX
        MOV AX,@DATA
        MOV DS,AX

        ;Programa
        CLD
        MOV CL,0
        LEA SI,numeritos
        OTRO

    MAIN ENDP
    END MAIN    