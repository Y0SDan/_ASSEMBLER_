.MODEL small
.STACK 100

.DATA
    V     DW 1,2,3,4,5,6,7 ;El vector
    SUMA  DW 0
    MSG1  DB "La suma es: "
    SALTA DB 10,13,"$"

.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB AX,AX
        PUSH AX
        MOV AX,@DATA
        MOV DS,AX
        
        ;Inicia programa
        MOV CX,14
        
        SUB BX,BX
        L:
        MOV AX,[V + BX]
        ADD SUMA,AX
        ADD BX,1
        LOOP L

        SUB BX,BX
        MOV BX,SUMA
        MOV DL,BL
        CALL desempaqueta
        ;MOV DL,BH
        ;CALL desempaqueta

        RET
    MAIN ENDP

    ;-----------------Subrutinas---------------
    Desempaqueta PROC
        Push dx
        Push cx
        Mov dh,dl ; Guardando el valor original en DH
        Mov cl,4
        Shr dl,cl ; Cuatro corrimientos a la derecha
        Call Binario_Ascii
        Call Escribe
        Mov dl,dh ; Recuperando el dato de DH
        And dl,0Fh ; Aplicando mascara
        Call Binario_ascii
        Call Escribe
        Pop cx
        Pop dx
        RET
    Desempaqueta ENDP

    Binario_Ascii PROC
CMP DL,9h
JG SUMA37
ADD DL,30h
JMP FIN
SUMA37: ADD DL,37h
FIN : RET
Binario_Ascii ENDP

escribe PROC
PUSH AX
MOV AH,02 ; Caracter a desplegar almacenado en dl
INT 21h
POP AX
RET
escribe ENDP


END MAIN          