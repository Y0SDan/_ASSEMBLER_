.MODEL small
.STACK 100

.DATA
    MSG1     DB 'Ingresa un texto de 10 renglones:',10,'(enter para pasar al siguiente renglon)',13,10,'$'
    LINEA1   DB 100,?,100 DUP('$'),'$'
    LINEA2   DB 100,?,100 DUP('$'),'$'
    LINEA3   DB 100,?,100 DUP('$'),'$'
    LINEA4   DB 100,?,100 DUP('$'),'$'
    LINEA5   DB 100,?,100 DUP('$'),'$'
    LINEA6   DB 100,?,100 DUP('$'),'$'
    LINEA7   DB 100,?,100 DUP('$'),'$'
    LINEA8   DB 100,?,100 DUP('$'),'$'
    LINEA9   DB 100,?,100 DUP('$'),'$'
    LINEA10  DB 100,?,100 DUP('$'),'$'
    INST1 DB 'DIGITA EL CARACTER A BUSCAR:$'
    INST2 DB 'DIGITA EL CARACTER QUE VA A REMPLAZAR AL CARAACTER BUSCADO:$'


.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB AX,AX
        PUSH AX
        MOV AX,@data
        MOV DS,AX
        MOV ES,AX

        ;Inicia
        LEA DX,MSG1
        CALL escribeCad

        LEA DX,LINEA1
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA2
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA3
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA4
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA5
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA6
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA7
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA8
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA9
        CALL leeCadxBuf
        CALL salta
        LEA DX,LINEA10
        CALL leeCadxBuf
        CALL salta

        CALL busca



        RET
    MAIN ENDP
    ;--------------- Subrutinas del programa-----------
    busca PROC
        LEA  DX,INST1
        CALL MENSAJE
        CALL LEE; AL  = CARACTER PRESIONADO
        mov  BL,AL
        call salta

        LEA  DX,INST2
        CALL MENSAJE
        CALL LEE
        MOV  BH,AL
        call salta
        sub dx,dx

        CLD
        MOV AL,BL
        LEA DI,LINEA1
        
        L1:
            CMP   [DI],'$'
            JE    EXIT1
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT1
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L1

        EXIT1: 
            SUB CX,CX
            LEA SI, LINEA1 + 1
            MOV CL, [SI]
            LEA DI, LINEA1 + 2
            LEA SI,LINEA1 + 2
                
                O9:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O9
call salta
;---------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA2
        
        L2:
            CMP   [DI],'$'
            JE    EXIT2
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT2
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L2

        EXIT2: 
            SUB CX,CX
            LEA SI, LINEA2 + 1
            MOV CL, [SI]
            LEA DI, LINEA2 + 2
                LEA SI,LINEA2 + 2
                
                O2:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O2
                    call salta
;---------------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA3
        
        L3:
            CMP   [DI],'$'
            JE    EXIT3
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT3
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L3

        EXIT3: 
            SUB CX,CX
            LEA SI, LINEA3 + 1
            MOV CL, [SI]
            LEA DI, LINEA3 + 2
                LEA SI,LINEA3 + 2
                
                O3:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O3
                    call salta
;--------------------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA4
        
        L4:
            CMP   [DI],'$'
            JE    EXIT4
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT4
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L4

        EXIT4: 
            SUB CX,CX
            LEA SI, LINEA4 + 1
            MOV CL, [SI]
            LEA DI, LINEA4 + 2
                LEA SI,LINEA4 + 2
                
                O4:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O4
                    call salta
;-------------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA5
        
        L5:
            CMP   [DI],'$'
            JE    EXIT5
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT5
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L5

        EXIT5: 
            SUB CX,CX
            LEA SI, LINEA5 + 1
            MOV CL, [SI]
            LEA DI, LINEA5 + 2
                LEA SI,LINEA5 + 2
                
                O5:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O5
                    call salta
;------------------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA6
        
        L6:
            CMP   [DI],'$'
            JE    EXIT6
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT6
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L6

        EXIT6: 
            SUB CX,CX
            LEA SI, LINEA6 + 1
            MOV CL, [SI]
            LEA DI, LINEA6 + 2
                LEA SI,LINEA6 + 2
                
                O6:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O6
call salta
;---------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA7
        
        L7:
            CMP   [DI],'$'
            JE    EXIT7
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT7
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L7

        EXIT7: 
            SUB CX,CX
            LEA SI, LINEA7 + 1
            MOV CL, [SI]
            LEA DI, LINEA7 + 2
                LEA SI,LINEA7 + 2
                
                O7:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O7
                    call salta
;---------------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA8
        
        L8:
            CMP   [DI],'$'
            JE    EXIT8
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT8
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L8

        EXIT8: 
            SUB CX,CX
            LEA SI, LINEA8 + 1
            MOV CL, [SI]
            LEA DI, LINEA8 + 2
                LEA SI,LINEA8 + 2
                
                O8:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O8
                    call salta
;--------------------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA9
        
        L9:
            CMP   [DI],'$'
            JE    EXIT9
            MOV   CX,100
            REPNE SCASB
            JNE   EXIT9
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L9

        EXIT9: 
            SUB CX,CX
            LEA SI, LINEA9 + 1
            MOV CL, [SI]
            LEA DI, LINEA9 + 2
            LEA SI,LINEA9 + 2
                
                O:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O
                    call salta
;-------------------------------------------------
        CLD
        MOV AL,BL
        LEA DI,LINEA10
        
        L10:
            CMP   [DI],'$'
            JE    EXIT10
            MOV   CX,100    
            REPNE SCASB
            JNE   EXIT10
            DEC   DI
            MOV BYTE PTR [DI],BH
            INC DX
            JMP L10

        EXIT10: 
            SUB CX,CX
            LEA SI, LINEA10 + 1
            MOV CL, [SI]
            LEA DI, LINEA10 + 2
                LEA SI,LINEA10 + 2
                
                O10:  MOV DL,[DI]
                    INC DI
                    CALL escribeChar
                    LOOP O10
                    call salta
;------------------------------------------------------
                
                CALL FIN

        RET
    busca ENDP
    ;--------------- Subrutinas esenciales -------------

    ;Lee una cadena x buffer
    leeCadxBuf PROC
        PUSH AX
        MOV  AH,0AH      ;lee por buffer
        INT  21H 
        POP  AX
        
        RET
    leeCadxBuf ENDP

    escribeCad PROC
        PUSH AX
        MOV  AH,09
        INT  21H
        POP  AX
        RET
    escribeCad ENDP

    salta PROC
        PUSH DX
        MOV  DL,0AH
        CALL escribeChar
        MOV  DL,0DH
        CALL escribeChar
        POP  DX
        RET
    salta ENDP

    escribeChar PROC
        PUSH AX
        MOV  AH,02
        INT  21H
        POP  AX
        RET
    escribeChar ENDP

    ;Lee un caracter con eco (desde teclado) El registo de guarda en AL
    leeChar_conEco PROC
        PUSH AX
        MOV  AH,01
        INT  21H
        POP  AX
            
        RET
    leeChar_conEco ENDP

    LEE proc
        mov ah,01h
        int 21h
        ret
    LEE endp

    FIN PROC
        push ax
        mov ah,4ch
        int 21h
        pop ax
    FIN ENDP
    
    MENSAJE PROC
        PUSH AX
        MOV AH,09H
        INT 21H
        POP AX
        RET
    MENSAJE ENDP

        ;Toma lo de empaqueta y lo convierte de binario a ascci compromete a DL
        desempaqueta PROC
            PUSH DX
            PUSH CX
            MOV  DH,DL
            MOV  CL,4
            SHR  DL,CL ;CORRIMIENTO A LA DERECHA
            CALL bin_Ascii
            CALL escribeChar
            MOV  DL,DH
            AND  DL,0FH ; Operrador logico and
            CALL bin_Ascii
            CALL escribeChar
            POP  CX
            POP  DX
            RET
        desempaqueta ENDP

        ;Convierte de binario a ascci
        bin_Ascii PROC
                    CMP DL,9H
                    JG  SUMA37
                    ADD DL,30H
                    JMP FIN2
            SUMA37: ADD DL,37H
            FIN2:   RET
        bin_Ascii ENDP 

END MAIN        