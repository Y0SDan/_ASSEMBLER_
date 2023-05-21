;Escrbe un caracater en pantalla (el caracter debe estar en DL)
escribeChar PROC
    PUSH AX
    MOV  AH,02 ; Caracter a desplegar almacenado en dl
    INT  21h
    POP  AX

    RET
escribeChar ENDP

;Termina la ejecución del programa
SALIR_DOS PROC
   MOV AH,4CH
   INT 21H

   RET
SALIR_DOS ENDP

;Escribe cadena en terminal, la cadena debe de estar en DX
escribeCad PROC
    PUSH AX
    MOV  AH,09H
    INT  21H
    POP  AX
    
    RET
escribeCad ENDP

;Lee una cadena de caracteres utilizando el buffer
;La cadena debe de estar en DX
leerCadena PROC
    PUSH DX
    PUSH AX
    LEA  DX,CADENA
    MOV  AH,0AH
    INT  21H
    POP  AX
    POP  DX
    
    RET
leerCadena ENDP

;Lee un caracter con eco (desde teclado)
leeChar_conEco PROC
    PUSH AX
    MOV  AH,01
    INT  21H
    POP  AX
            
    RET
leeChar_conEco ENDP

;Leer caracter sin eco (i guess)
LEER_CSE PROC
    MOV AH,08
    INT 21H

    RET
LEER_CSE ENDP

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

;Convierte de binario a ascci
binario_ascii PROC
         CMP DL,9h
         JG  SUMA37
         ADD DL,30h
         JMP FIN2
 SUMA37: ADD DL,37h
 
 FIN2: RET
binario_ascii ENDP

;lee caracteres (2 nibles) y lo convierte a binario (Compromete DL )
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

;Toma el bianrio y lo convierte a caracter
desempaqueta PROC
    PUSH DX
    PUSH CX
    MOV DH,DL
    MOV CL,4
    SHR DL,CL
    CALL binario_ascii
    CALL escribe_car
    MOV DL,DH
    AND DL,0Fh
    CALL binario_ascii
    CALL escribe_car
    POP CX
    POP DX

    RET
desempaqueta ENDP

;Posiciona el Cursor en donde queremos
POS_CUR PROC
    PUSH AX
    PUSH BX
    PUSH DX
    MOV AH,02
    MOV BH,0
    MOV DH,RENGLON ; RENGLON
    MOV DL,COLUMNA ; COLUMNA
    INT 10h
    POP DX
    POP BX
    POP AX

    RET
POS_CUR ENDP

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

;Imprime caracteres con colores
Despliega9 PROC
    PUSH BX
    PUSH CX
    MOV AH,09 ; RECORDAR QUE EL CARACTER ESTA ALMACENADO EN AL
    MOV BH,00
    MOV BL, ATRIBUTO
    MOV CX, NUMERO
    INT 10H
    POP CX
    POP BX

    RET
Despliega9 ENDP

;Planta una semilla para el numero pseudoaleatorio
SEMILLA PROC
    PUSH AX
    MOV AH,2CH
    INT 21H  ; RETORNA CH=HORAS, EN FORMATO 00-23, MEDIANOCHE=0
         ; CL MINUTOS 00-59
         ;DH SEGUNDOS 00-59
         ;DL CENTESIMAS DE SEGUNDO 00-99
    POP AX

    RET
SEMILLA ENDP

;Genera un numero pseudoaleatorio
ALEATORIO PROC
    ; XN+1=(2053*XN + 13849)MOD 2**16
    ; RETORNA EL NUMERO PSEUDOALEATORIO EN AX
    MOV AX,DX ;CARGANDO A AX EL NUMERO SEMILLA tomado de la int 21 serv             2CH
    MOV DX,0  ;CARGANDO CERO EN LA POSICION MAS SIGNIFICATIVA DEL               MULTIPLICANDO
    MOV BX,2053 ; MULTIPLICADOR
    MUL BX
    MOV BX,13849 ;CARGA EN BX LA CONSTANTE ADITIVA
    CLC
    ADD AX,BX ; SUMA PARTES MENOS SIGNIFICATIVAS DEL RESULTADO
    ADC DX,0 ; SUMA EL ACARREO SI ES NECESARIO
    MOV BX,0FFFFH ; CARGAR LA CONSTANTE 2**16-1
    DIV BX
    MOV AX,DX ; MUEVE EL RESIDUO  AX
    
    RET
ALEATORIO ENDP

;Establece el rango del numero pseudoaleatorio usando el modulo
ESCALANDO PROC
   ; ESCALANDO EL NUMERO PSEUDOALEATORIO OBTENIDO
   MOV DX,0
   MOV BX,00FFH ;NUMEROS ALEATORIOS ENTRE 0 Y 9
   DIV BX
   MOV AX,DX
   mov dl,ah
   call desempaqueta
   mov dl,al
   call desempaqueta
   ret
   
   RET
ESCALANDO ENDP

;Para pintar un pixel
PIXEL PROC
    ;Subrutina p?xel
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AH,0CH
    MOV AL,COLOR
    MOV BH,0
    MOV CX,COL
    MOV DX,REN
    INT 10H
    POP DX
    POP CX
    POP BX
    POP AX

    RET
PIXEL ENDP

;Para saber donde esta el curso actualmente
ACTUAL PROC
    MOV AH,0Fh
    INT 10H
    
    RET
ACTUAL ENDP

;Entrada sin eco
READKEY PROC
    MOV AH,07H
    INT 21H
    RET 
READKEY ENDP

;Cambia el modo en que se muestra la consola (Modo video)
graph PROC
    SUB AX,AX
    MOV AL,12H ;Modo gráfico 640 x 480
    INT 10H
    
    RET
graph ENDP

;Dibuja un pixel
PUNTO PROC
    MOV AH,0CH      ;el servicio
    MOV AL,COLOR    ;el color 
    MOV BH,0      
    MOV CX,Y        ;coordenadas
    MOV DX,X
    INT 10H
    
    RET
PUNTO ENDP

;Es para poder modo de texto 3 es el estandar el normal el comun y corriente
DOS PROC
    MOV AH,00H
    MOV AL,03H
    INT 10H
    
    RET
DOS ENDP

;Revisa que tecla especial es precionada (debe estar en AL)
keyStroke PROC NEAR    
        MOV AH,10h
        INT 16H
        CMP AL,00H  ;Compara que sea 0
        JE  YES
        CMP AL,0E0H ;Compara que sea 0E0H esto para saber si es una tecal valida
        JE  YES
        JMP BYE
 YES:   CMP AH,TECLA  ;Código de rastreao de la tecla 
        JNE BYE
        MOV AH,02
        MOV BH,00
 BYE:   RET
keyStroke ENDP      