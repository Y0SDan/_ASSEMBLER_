;procesa una cantidad de de numeros dada, determina cuales son pares e
;imprime cuantos y cuales pares fueron encontrados

.MODEL small
.STACK 100

.DATA
   MEN  DB 'Ingresa cuantos pares quieres comprobar: $'
   MEN2 DB 'Escriba un numero: $'
   CONT DB 100 DUP(?)                                   ;Reserva 100 de memoria pero no define su contenido

.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB  AX,AX
        PUSH AX
        MOV  AX,@DATA
        MOV  DS,AX

        ;Inicia programa
        LEA  DX,MEN
        CALL escribeCad
        CALL empaqueta   ;Convierte de ascci a binario y lo guarda en AL
        CALL salta
        SUB  CX,CX       ;Asegurarse de que CX este en 0
        MOV  CX,AL       ;Le asignamos al contador lop que devuelve empaqueta
        SUB  BX,BX       
        LEA  SI,CONT     ;Coloca el apuntador SI al inicio del "arreglo" CONT
        

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

    salta PROC
        PUSH DX
        MOV  DL, 0AH
        CALL escribeChar
        MOV  DL, 0DH
        CALL escribeChar
        POP  DX
    
        RET
    salta ENDP

    escribeChar PROC
        PUSH AX
        MOV  AH,02 ; Caracter a desplegar almacenado en dl
        INT  21h
        POP  AX

        RET
    escribeChar ENDP

END MAIN
