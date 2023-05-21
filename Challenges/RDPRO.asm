.MODEL small
.STACK 100

.DATA
    MEN1       DB '                         1 -> up&down$'
    MEN2       DB '                         2 -> Separa$'
    MEN3       DB '                         3 -> Salir$'
    MEN4       DB '                         Escoge una opcion: $'
    MENSAJE    DB 'El menu funciona$'
    ;Instrucciones para up&down
    INTS1      DB 'Ingrese una oración o palabra: $'
    CADENA     DB 40, ?, 40 DUP('$'),'$'
    INVERSE    DB 40 DUP ('$'),'$'

    

.CODE 
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB  AX,AX
        PUSH AX
        MOV  AX,@data
        MOV  DS,AX ; DS=ES
        MOV  ES,AX

        ;Menu
        REGRESA:
                CALL salta    
                CALL salta    
                LEA  DX,MEN1
                CALL escribeCad
                CALL salta
                LEA  DX,MEN2
                CALL escribeCad
                CALL salta
                LEA  DX,MEN3
                CALL escribeCad
                CALL salta
                LEA  DX,MEN4
                CALL escribeCad
                CALL leeChar_conEco
                ;Compara
                CMP  AL,"1"
                JE   UNO
                JL   REGRESA ;Salta si es menor
                CMP  AL,"2"
                JE   DOS
                CMP  AL,"3"
                JE   salir
                JG   REGRESA ;Salta si es mayor
        UNO:    CALL up&down
                JMP REGRESA
        DOS:    CALL separa
                JMP REGRESA

                RET

    MAIN ENDP
;-------------------------Subrutinas rograma principal------------------
    up&down PROC ;escribe una cadena arriba o al revez abajo
        MOV AH,00   ;Limpia la zona alta de AX
        MOV AL,12H  ;Servicio 12H "Modo video"
        INT 10H     ;Juega con la pantalla

        LEA DX,INTS1
        CALL escribeCad
        CALL salta
        
        LEA DX,CADENA   ;buffer
        MOV AH,0AH      ;lee por buffer
        INT 21H         

        MOV CL,CADENA + 1 ;Metemos la longitud de la cadena
        MOV CH,0          ;Vaciamos CH
        LEA SI,CADENA + 2 ;Apuntamos SI al inicio de la cadena que se leyó
        ADD SI,CX         ;Le sumamos CX para que ahora SI al final de la cadena
        LEA DI,INVERSE    ;Apuntamos DI al inicio de lo que sera el mensaje invertido
        DEC SI            ;Como apunta a un '$' se lo quitamos
    


        RET
    up&down ENDP

    separa PROC
        MOV AH,00
        MOV AL,12H
        INT 10H
        CALL salta
        LEA DX,MENSAJE
        CALL escribeCad
        CALL salta
        CALL escribeCad
        RET
    separa ENDP

;-------------------------Subrutinas esenciales-------------------------

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

    leeChar_conEco PROC ;regresa el char en AL
        MOV AH,01
        INT 21H
        RET
    leeChar_conEco ENDP

    ;Salir DOS
    salir PROC
        MOV AH,4CH
        INT 21H
        RET
    salir ENDP

END MAIN    