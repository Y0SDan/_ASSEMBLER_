;Programa que muestra la forma en que se ejecuta el comando D

.MODEL small
.stack 100

.DATA
    DRIP DW 0100H
    CONT DB 8

.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB  AX,AX
        PUSH AX
        MOV  AX,@DATA
        MOV  DS,AX

        ;START---------------------------------
        ;Modificamos DS (podriamos usar una variable o un registro)
        SUB AX,AX           ;AX = 0
        MOV AX,073FH        ;AX = 073F
        MOV DS,AX           ;Nos colocamos en el segmento de datos correspondiente
        MOV AX,DS           ;colocamos a AX el segmento de datos para poder imprimirlo
        
     ;imprimimos DS (El registro debe de estar en AX)
        MOV DL,AH
        CALL desempaqueta
        MOV DL,AL
        CALL desempaqueta

        ;escribimos ":"
        MOV DL,03AH
        CALL escribeChar

        ;Imprimir la direccion 
        MOV AX,DRIP
        MOV DL,AH
        CALL desempaqueta
        MOV DL,AL
        CALL desempaqueta

        MOV DI, AX        ;Movemos el apuntador a 100 (que es como esta por default)

        CALL espacio        ;Escribimos un espacio " "



        
    MAIN ENDP
;----------------------------------------------- Subrutinas -----------------------------     
    ;Escribimos un espacio " "
    espacio PROC
        PUSH DX
        SUB DX,DX
        MOV  DL,020H
        CALL escribeChar
        POP  DX

        RET
    espacio ENDP

    ;Escribimos un guion "-"
    guion PROC
        PUSH DX
        SUB DX,DX
        MOV  DL,02DH
        CALL escribeChar
        POP  DX

        RET
    guion ENDP
    
    ;Toma el binario y lo convierte a caracter (DL)
    desempaqueta PROC
        PUSH DX
        PUSH CX
        MOV  DH,DL
        MOV  CL,4
        SHR  DL,CL
        CALL binario_ascii
        CALL escribeChar
        MOV  DL,DH
        AND  DL,0Fh
        CALL binario_ascii
        CALL escribeChar
        POP  CX
        POP  DX

        RET
    desempaqueta ENDP

    ;Convierte de binario a ascci (DL (i guess)
    binario_ascii PROC
                CMP DL,9h
                JG  SUMA37
                ADD DL,30h
                JMP FIN2
        SUMA37: ADD DL,37h
 
        FIN2:   RET
    binario_ascii ENDP

    ;Cnvierte de ascci a binario
    ascii_Bin PROC
                CMP AL,30h
                JL  ERROR
                CMP AL,39h
                JG  LETRA
                SUB AL,30h
                JMP FIN
        LETRA:  CMP AL,41
                JL  ERROR
                CMP AL,46h
                JG  ERROR
                SUB AL,37h
                JMP FIN
        ERROR:  MOV AL,0
 
        FIN:    RET
    ascii_Bin ENDP

    ;Escrbe un caracater en pantalla (el caracter debe estar en DL)
    escribeChar PROC
        PUSH AX
        MOV  AH,02 ; Caracter a desplegar almacenado en dl
        INT  21h
        POP  AX

        RET
    escribeChar ENDP

    ;Imprime un salto de linea y retorno de carro
    salta PROC
        PUSH DX
        MOV  DL, 0AH
        CALL escribeChar
        MOV  DL, 0DH
        CALL escribeChar
        POP  DX
    
        RET
    salta ENDP



END MAIN    