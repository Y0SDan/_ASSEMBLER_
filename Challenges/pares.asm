;procesa una cantidad de de numeros dada, determina cuales son pares e
;imprime cuantos y cuales pares fueron encontrados

.MODEL small
.STACK 100

.DATA
   MEN  DB 'Ingresa cuantos pares quieres comprobar: $'
   MEN2 DB 'Escriba un numero: $'

.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB AX,AX
        PUSH AX
        MOV AX,@DATA
        MOV DS,AX

        ;Inicia programa
        LEA DX,MEN
        CALL escribeCad
        CALL empaqueta

        RET

    MAIN ENDP

    ;------------------------Subrutinas-----------------
    escribeCad PROC
        PUSH AX
        MOV  AH,09
        INT  21H
        POP  AX
    
        RET
    escribeCad ENDP

    empaqueta PROC
        PUSH CX
        CALL leeChar_conEco
        CALL ascii_Bin
        MOV  CL,04
        SHL  AL,CL
        MOV  CH,AL
        CALL leeChar_conEco
        CALL ascii_Bin
        ADD  AL,CH
        POP  CX
    
        RET
    empaqueta ENDP

    leeChar_conEco PROC
        PUSH AX
        MOV  AH,01
        INT  21H
        POP  AX
            
        RET
    leeChar_conEco ENDP

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
END MAIN
