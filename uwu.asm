;define segmento de pila
STACKSG SEGMENT PARA STACK 'STACK'
    DB 20 DUP(0)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    MEN1       DB '                         1 -> PARES$'
    MEN2       DB '                         2 -> GAUSS$'
    MEN3       DB '                         3 -> SUMA ALEATORIO$'
    MEN4       DB '                         4 -> SALIR$'
    MEN5       DB '                         Escoge una opcion: $'
    MEN6       DB '  Ingresa cuantos numeros quieres comprobar: $'
    MEN7       DB '  Escriba un numero: $'
    MEN8       DB 'Pares encontrados: $'
    MEN9       DB 'Total de pares encontrados: $'
    MEN10      DB 'Ingrese el total de numeros a sumar: $'
    MEN11      DB 'La suma total DE LOS 100 primeros numeros hexadecimales es: $'
    MEN12      DB 'La suma total es: $'
    NUM1       DB ? 
    CONT       DB 100 DUP(?)
    CONTENIDO  DB 100 DUP("$"),"$"
DATASG ENDS

CODESG SEGMENT PARA 'CODE'
    MAIN PROC FAR
        ASSUME CS:CODESG, DS:DATASG, SS:STACKSG

        ;PROTOCOLO
        PUSH DS
        SUB AX,AX
        PUSH AX
        MOV AX,SEG DATASG
        MOV DS,AX

                    ;MENU
        regresa:    CALL salta
                    CALL salta
                    LEA  DX,MEN1 ;1 -> PARES
                    CALL escribeCad
                    CALL salta   ;Alimentar Linea
                    LEA  DX,MEN2 ;2 -> GAUSS
                    CALL escribeCad
                    CALL salta
                    LEA  DX,MEN3 ;3 -> SUMA ALEATORIO
                    CALL escribeCad
                    CALL salta
                    LEA  DX,MEN4 ;4 -> SALIR
                    CALL escribeCad
                    CALL salta
                    CALL salta
                    LEA  DX,MEN5 ;Escoge una opcion
                    CALL escribeCad
                    CALL leeChar_conEco
                    CALL salta
                    CMP  AL,"1"
                    JE   uno    ;pares
                    JL   regresa
                    CMP  AL,"2"
                    JE   dos   ;gauss
                    CMP  AL,"3"
                    JE   tres  ;sumAleatorio
                    CMP  AL,"4"
                    JE   cuatro
                    JG   regresa
        salida:     CALL cuatro ;salir ;salir_dos

        uno:        CALL pares
                    JMP  regresa
        dos:        CALL gauss            
                    JMP  regresa
        tres:       CALL sumAleatorio
                    JMP  regresa
        cuatro:     CALL salir            

;------------------------------------ Subrutinas del programa -------------------------------;
        ;1 -> PARES
        pares PROC
                    CALL salta          ;Salto de linea
                    LEA   DX,MEN6       ;Ingresa cuantos numeros quieres comprobar
                    CALL  escribeCad    ;escribe en consola
                    CALL  empaqueta     ;convierte de ascci a binario y se guarda en AL
                    CALL  salta
                    SUB   CX,CX
                    MOV   CL,AL
                    MOV   BX,0000
                    LEA   SI,CONT
                    CALL salta
            NUM:    LEA   DX,MEN7 ;Escriba un numero
                    CALL  escribeCad
                    CALL  empaqueta
                    CALL  salta
                    MOV   BL,AL
                    MOV   DL,2
                    DIV   DL
                    CMP   AH,0
                    JE    PAR
            L1:     LOOP  NUM
                    JMP   FN
            PAR:    MOV   [SI],BL
                    INC   SI
                    INC   BH
                    JMP   L1
            FN:     MOV   CL,BH
                    LEA   DX,MEN8 ;Pares encontrados
                    CALL  salta
                    CALL  escribeCad
                    CALL  salta
                    CALL  salta
                    LEA   SI,CONT
            ESV:    MOV   DL,[SI]            
                    CALL  desempaqueta
                    CALL  salta
                    INC   SI
                    LOOP  ESV
                    CALL salta
                    LEA   DX,MEN9 ;Total de pares encontrados
                    CALL  escribeCad
                    MOV   DL,BH
                    CALL  desempaqueta
                    CALL  salta
                    RET
        pares ENDP

        ;2 -> GAUSS
        gauss PROC
                CALL salta
                LEA DX,MEN11
                CALL escribeCad
                MOV  CX,64H
                SUB  BX,BX
            L:  ADD  BX,CX
                LOOP L
                MOV  DL,BH
                CALL desempaqueta
                MOV  DL,BL
                CALL desempaqueta
                RET
        gauss ENDP        

        ;3 -> aLEATORIO
        sumAleatorio PROC
                CALL salta
                LEA  DX,MEN10
                CALL escribeCad
                CALL empaqueta
                CALL salta
                MOV  CX,0
                MOV  BX,0
                MOV  CL,AL
            NA: PUSH CX
                PUSH BX
                CALL numeroAleatorio
                POP  BX
                MOV  AH,0
                ADD  BX,AX
                CALL leeChar_conEco
                POP  CX
                LOOP NA
                LEA  DX,MEN12
                CALL escribeCad
                MOV  DL,BH
                CALL desempaqueta
                MOV  DL,BL
                CALL desempaqueta
                RET
        sumAleatorio ENDP

;------------------------------------ Subrutinas para generar numeros aleatorios ------------;

        numeroAleatorio PROC
            CALL semilla
            CALL aleatorio
            CALL escalando
        numeroAleatorio ENDP

        semilla PROC
            PUSH AX
            MOV  AH,2CH
            INT  21H
            POP  AX
            RET
        semilla ENDP

        aleatorio PROC
            MOV AX,DX
            MOV DX,0
            MOV BX,2053
            MUL BX
            MOV BX,13849
            CLC
            ADD AX,BX
            ADC DX,0
            MOV BX,0FFFFH
            DIV BX
            MOV AX,DX
            RET
        aleatorio ENDP

        ;Escalando el numero pseudoaleatorio obtenido
        escalando PROC
            MOV  DX,0
            MOV  BX,0FFH
            DIV  BX
            MOV  DL,AH
            CALL desempaqueta
            MOV  DL,AL
            CALL desempaqueta
            RET
        escalando ENDP
;------------------------------------ Subrutinas esenciales ---------------------------------;

        leeChar_conEco PROC
            MOV AH,01
            INT 21H
            RET
        leeChar_conEco ENDP

        escribeChar PROC ;
            PUSH AX
            MOV  AH,02
            INT  21H
            POP  AX
            RET
        escribeChar ENDP    
        
        escribeCad PROC
            PUSH AX
            MOV  AH,09
            INT  21H
            POP  AX
            RET
        escribeCad ENDP

        ;salto de linea y retorno de carrok
        salta PROC
            PUSH DX
            MOV  DL,0AH
            CALL escribeChar
            MOV  DL,0DH
            CALL escribeChar
            POP  DX
            RET
        salta ENDP

        ;Compromete DL y convierte de ascci a binario
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

        ;Convierte de ascci a binario
        ascii_Bin PROC
                    CMP AL,30H
                    JL  ERROR
                    CMP AL,39H
                    JG  LETRA
                    SUB AL,30H
                    JMP FIN
            LETRA:  CMP AL,41H
                    JL  ERROR
                    CMP AL,46H
                    JG  ERROR
                    SUB AL,37H
                    JMP FIN
            ERROR:  MOV AL,0
            FIN:    RET
        ascii_Bin ENDP 

        ;Salir DOS
        salir PROC
            MOV AH,4CH
            INT 21H
            RET
        salir ENDP

    MAIN ENDP
CODESG ENDS
END MAIN






