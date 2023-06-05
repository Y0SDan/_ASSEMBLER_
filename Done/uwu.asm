;define segmento de pila
STACKSG SEGMENT PARA STACK 'STACK'
    DB 20 DUP(0)
STACKSG ENDS

DATASG SEGMENT PARA 'DATA'
    MEN1       DB '                         1 -> up&down$'
    MEN2       DB '                         2 -> Separa$'
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
    CADENA DB 40, ?, 40 DUP('$'),'$' 
    MENSAJE1 DB 'Ingresa una cadena: $'
    MENSAJE_INVERTIDO DB 40 DUP ('$'),'$'
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
                    CMP  AL,"4"
                    JE   cuatro
                    JG   regresa
        salida:     CALL cuatro ;salir ;salir_dos

        uno:        CALL up&down
                    JMP  regresa
        dos:        CALL up&down            
                    JMP  regresa
        cuatro:     CALL salir            

;------------------------------------ Subrutinas del programa -------------------------------;
     up&down PROC
        ;INICIA EL PROGRAMA QUE LEE UNA CADENA DESDE EL TECLADO
    ;start
    MOV AH, 00
    MOV AL, 12H
    INT 10H
    LEA DX,MENSAJE1
    MOV AH,09
    INT 21H
    ;end
    ;start
    LEA DX, CADENA
    MOV AH,0AH
    INT 21H
    ;end
    ;start
    MOV CL, CADENA+1 ;METEMOS LA LONGITUD DE LA CADENA
    MOV CH, 0 ;VACIAMOS CH
    LEA SI, CADENA+2 ;APUNTA AL INICIO DE LA CADENA QUE SE LEYO $
    ADD SI,CX ;APUNTAMOS AL FINAL DE LA CADENA
    LEA DI, MENSAJE_INVERTIDO ;APUNTA AL INICIO DEL MENSAJE INVERTIDO
    DEC SI; COMO A PUNTA A UN $ SE LO QUITAMOS
    CICLO:
    MOV BL,[SI]
    MOV [DI],BL 
    INC DI
    DEC SI
    LOOP CICLO
    ;LEA DX, MENSAJE_INVERTIDO
    ;CALL alimentar_linea
    ;CALL escribe_cadena
    CALL limpiarPantalla
    LECTECLADO:
    MOV AH,10H
    INT 16H
    CMP AL,00
    JE YES
    CMP AL, 0E0H
    JE YES
    CMP AH,01H
    JE FIN
    JMP LECTECLADO
YES:
    CMP AH,48H
    JE ARRIBA
    CMP AH,50H
    JE ABAJO
    JMP LECTECLADO
ARRIBA:
    CALL limpiarPantalla
    CALL centro
    MOV BH,0
    MOV AH,2
    MOV DH,0
    ;MOV DL, 30
    INT 10H
    LEA DX, CADENA+2
    MOV AH,09H
    INT 21H
    JMP LECTECLADO 
ABAJO:
    CALL limpiarPantalla
    CALL centro
    MOV BH,0
    MOV DH,24
    ;MOV DL,30
    MOV AH,2
    INT 10H
    LEA DX, MENSAJE_INVERTIDO
    MOV AH,09H
    INT 21H
    JMP LECTECLADO

FIN:
CALL sal_dos
RET
     up&down ENDP   

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

            sal_dos PROC
    MOV AH,4CH
    INT 21H
    RET
    sal_dos ENDP

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

            centro PROC
    MOV AH, 0
    MOV AL,CADENA+1
    MOV BL,2
    DIV BL
    MOV DL,40
    SUB DL,AL
    RET
    centro ENDP

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
                    JMP FIN1;hola EDy       como estas
            LETRA:  CMP AL,41H
                    JL  ERROR
                    CMP AL,46H
                    JG  ERROR
                    SUB AL,37H
                    JMP FIN
            ERROR:  MOV AL,0
            FIN1:    RET
        ascii_Bin ENDP 

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
    MOV  BH,71h      ;Fondo blanco con primer plano azul
    MOV  CX,0000H    ;coordenada inicial
    MOV  DX,184FH    ;coordenada final
    INT  10h
    POP  DX
    POP  CX
    POP  BX
    POP  AX

    RET
limpiarPantalla ENDP

    MAIN ENDP
CODESG ENDS
END MAIN






