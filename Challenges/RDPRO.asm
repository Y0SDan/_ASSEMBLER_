.MODEL small
.STACK 100

.DATA
    MEN1       DB '                         1 -> up & down$'
    MEN2       DB '                         2 -> word splitter$'
    MEN3       DB '                         3 -> Salir$'
    MEN4       DB '                         Escoge una opcion: $'
    MENSAJE    DB 'El menu funciona$'
    ;Instrucciones para up&down
    INTS1      DB 'Ingrese su mensaje: $'
    CADENA     DB 40, ?, 40 DUP('$'),'$'
    INVERSE    DB 40 DUP ('$'),'$'
    ;Instrucciones para wordSplitter
    MSG1       DB 'Ingresa tu mensaje: $'
    CADENA2    DB 100, ?, 100 DUP('$'),'$'
    MSG2       DB 'Resultado:$'

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
                JE   FIN
                JG   REGRESA ;Salta si es mayor
        UNO:    CALL up&down
                JMP  REGRESA
        DOS:    CALL wordSplitter
                CALL limpia
                JMP  REGRESA

        FIN:    CALL salir                

                RET

    MAIN ENDP
;-------------------------Subrutinas rograma principal------------------
    up&down PROC ;escribe una cadena arriba o al revez abajo
        CALL modoVideo

        LEA DX,INTS1
        CALL escribeCad
        CALL salta
        
        LEA  DX,CADENA   ;buffer
        CALL leeCadxBuf       

        MOV CL,CADENA + 1 ;Metemos la longitud de la cadena
        MOV CH,0          ;Vaciamos CH
        LEA SI,CADENA + 2 ;Apuntamos SI al inicio de la cadena que se leyó
        ADD SI,CX         ;Le sumamos CX para que ahora SI al final de la cadena
        LEA DI,INVERSE    ;Apuntamos DI al inicio de lo que sera el mensaje invertido
        DEC SI            ;Como apunta a un '$' se lo quitamos
        
        CICLO:  ;Copiamos lo que apunta SI a lo que apunta DI
                MOV  BL,[SI]
                MOV  [DI],BL
                INC  DI
                DEC  SI
                LOOP CICLO

        CALL limpiarPantalla

        LEE: ;Procesa las teclas presionadas
            CALL leeCaracter
            CMP  AL,00      ;Determina el valor ascci de algunas teclas extendidas 00 | E0H
            JE   TECLAS
            CMP  AL,0E0H    ;Determina el valor ascci de algunas teclas extendidas 00 | E0H
            JE   TECLAS
            CMP  AH,01H     ;Determina si la tecla Esc (escape) para salir (Rastreo)
            JE   ADIOS
            JMP  LEE

        TECLAS: ;Como la tecla presionada se sigue guardando en A
                CMP AH,48H ;Compara el codigo de rastreo de la tecla arriba
                JE  UP
                CMP AH,50H ;Compara el codigo de rastreo de la tecla abajo
                JE  DOWN 
                JMP LEE

        UP: 
            CALL limpiarPantalla
            CALL centroUP        ;Posiciona el cursor arriba en el centro
            SUB  DX,DX
            LEA  DX,CADENA + 2   ;Posiciona el inicio de la cadena almacenada en buffer en DX
            CALL escribeCad
            JMP  LEE

        DOWN:
             CALL limpiarPantalla
             CALL centroDOWN
             SUB  DX,DX
             LEA  DX,INVERSE
             CALL escribeCad
             JMP  LEE
             
        ADIOS:   RET
    up&down ENDP

    wordSplitter PROC
        LEA DX, MSG1
        CALL salta
        CALL salta
        CALL escribeCad
    
        LEA DX, CADENA2
        CALL leeCadxBuf
        CALL salta
    
        LEA DX, MSG2
        CALL escribeCad
        CALL salta
    
        LEA SI, CADENA+2
        
        LEER:
            MOV DL,[SI]
            CMP DL,36
            JE  FIN2
            CMP DL,32
            JE  I
            CALL writing
            CALL salta
            JMP LEER

        I:  INC SI
            JMP LEER   
    
        FIN2: RET
    wordSplitter ENDP

;-------------------------Subrutinas esenciales-------------------------
    ;Lee un caracter de teclado expandido sin eco usando el servicion 10H de la int 16H (Lo guarda en AL)
    leeCaracter PROC
        MOV AH,10H
        INT 16H
        RET
    leeCaracter ENDP

    ;Lee una cadena x buffer
    leeCadxBuf PROC
        PUSH AX
        MOV AH,0AH      ;lee por buffer
        INT 21H 
        POP  AX
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

    ;Limpia pantalla (la sobreescribe cn un color)
    limpiarPantalla PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        MOV  AX,0600h    ;El servicio
        MOV  BH,7Ch      ;Fondo blanco con primer plano azul
        MOV  CX,0000H    ;coordenada inicial
        MOV  DX,0FFFFH    ;coordenada final
        INT  10h
        POP  DX
        POP  CX
        POP  BX
        POP  AX
        RET
    limpiarPantalla ENDP

    centroUP PROC
        MOV AH,0
        MOV AL,CADENA + 1 ;Movemos a AL la longitud de la cadena
        MOV BL,2          ;BL = 2
        DIV BL            ;Dividimos AL/BL
        MOV BH,0          ;Página
        MOV DH,0          ;Fila
        MOV DL,40         ;Le asignamos 40 a DL para despues restarle la cadena y tener el cursos centrado
        SUB DL,AL         ;DL tiene la (columna) long de la cadena - 40 para que este centrado 
        MOV AH,2          ;Servicio 02H de la interupcion 10 que posiciona el cursor
        INT 10H
        RET
    centroUP ENDP

    centroDOWN PROC
        MOV AH,0
        MOV AL,CADENA + 1 ;Movemos a AL la longitud de la cadena ¿porque +1?
        MOV BL,2          ;BL = 2
        DIV BL            ;Dividimos AL/BL
        MOV BH,0          ;Página
        MOV DH,29         ;Fila
        MOV DL,40         ;Le asignamos 40 a DL para despues restarle la cadena y tener el cursos centrado
        SUB DL,AL         ;DL tiene la (columna) long de la cadena - 40 para que este centrado 
        MOV AH,2          ;Servicio 02H de la interupcion 10 que posiciona el cursor
        INT 10H
        RET
    centroDOWN ENDP

    modoVideo PROC
        MOV AH,00   ;Limpia la zona alta de AX
        MOV AL,12H  ;Servicio 12H "Modo video" 640 x 480
        INT 10H     ;Juega con la pantalla

        RET
    modoVideo ENDP 

    ;-------------------------------------Subrutinas creadas para este programa----------------
    limpia PROC 
            LEA SI,CADENA2 + 2   ;<---- antes de llamar a la subrutina
        L1: MOV DL,[SI]
            CMP DL,36
            JE  EXIT
            MOV DL,'$'
            MOV [SI],DL
            INC SI
            JMP L1

       EXIT: RET   
    limpia ENDP
    
    writing PROC
        L:
            MOV  DL,[SI]
            CALL escribeChar
            INC  SI
            CMP  DL,36
            JE   BYE
            CMP  DL,32
            JNE  L
        
        BYE:RET
    writing ENDP       

END MAIN    