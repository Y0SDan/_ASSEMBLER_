;Programa que muestra la forma en que se ejecuta el comando D

.MODEL small
.stack 100

.DATA
    address DB 16,?, 16 DUP('$'),'$'
    INGRESO DB 15, ?, 15 DUP('$'), '$'
    ERR DB 'ERROR$'
    LINEA DB '-$'
    BERROR DB ?
.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB  AX,AX
        PUSH AX
        MOV  AX,@DATA
        MOV  DS,AX

        ;START---------------------------------
        
AGAIN:
    LEA DX, LINEA
    MOV AH, 09
    INT 21H

    
    LEA DX, INGRESO
    MOV AH, 0AH
    INT 21H
    
    LEA SI, INGRESO+2
    

COMP:
    MOV BL, [SI]
    CMP BL, 32 ; COMPARAR SI ES ESPACIO
    JNE D
    INC SI
    JMP COMP
D:
    CMP BL, 68
    JE SIES
    CMP BL, 100
    JE SIES
    CALL salta
    JMP AGAIN
SIES:

    CALL EXTRAE_INI; 

    CMP BERROR, 0       ; SI ES 0, HUBO UNA DIR DE ENTRADA Y LLAMAMOS A EXTRAE_FIN
    JE EXT
    CMP BERROR, 1; NO VAMOS A HACER NADA Y MOSTRAR MENSAJE DE ERROR
    JE ERROR
    CMP BERROR, 2           ; NO HAY ARGUMENTOS. EL CASO D SOLO
    JE OP2

EXT:
    CALL EXTRAE_FIN
    CMP BERROR, 0       ; HAY TANTO INICIO COMO FIN
    JE OP4
    CMP BERROR, 1       ; SI ES UNO, EL ARGUMENTO NO ES VALIDO
    JE ERROR
    CMP BERROR, 2       ; SOLO ESTÁ EL ARGUMENTO INICIAL
    JE OP3

ERROR:
    LEA DX, ERR
    CALL salta
    CALL escribeCad
    JMP AGAIN 

OP2:
        ; EL CASO D SOLO


OP3:
    ; D CON  EL ARGUMENTO INICIAL


OP4:; EL CASO DE D CON 2 ARGUMENTOS



    ret
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

    escribeCad PROC
    PUSH AX
    MOV  AH,09H
    INT  21H
    POP  AX
    
    RET
escribeCad ENDP


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