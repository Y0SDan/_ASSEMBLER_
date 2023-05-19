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
        ;Modificamos DS (podriasmos usar una variable o un registro)
REPD:   SUB AX,AX           ;AX = 0
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

        MOV DI, AX        ;Movemos el apuntador a INICIO

        CALL espacio        ;Escribimos un espacio " "

        ;Loop que va imprimiendo los 16 siguientes valores 
             MOV  CX,010H
        L:   MOV  AL,[DI]
             MOV  DL,AL
             CALL desempaqueta
             CMP  CX,09H
             JE   GUI
             CALL espacio
             SIG1: INC  DI
             LOOP L
             JMP  F1N
        GUI: CALL guion
        JMP  SIG1

        F1N: 

        CALL espacio
        CALL espacio
        CALL espacio
        
        MOV BX, DRIP
        MOV DI, [BX]      ;Movemos el apuntador al inicio
        
             MOV CX,010H
        LP:  MOV AL,[DI]
             MOV DL,AL
             CALL escribeChar
             INC DI
             LOOP LP
             ADD DRIP, 10H
        
        call salta
        DEC CONT
        CMP CONT, 0
        JNE REPD

        RET

        
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

D
