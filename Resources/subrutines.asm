;Escribe un caracter en consola (El caracter debe estar en DL)
ESCRIBE PROC
   MOV AH,02
   INT 21H
    
   RET
ESCRIBE ENDP

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

;Imprime una cadena en consola (la cadena debe de estar en DX)
MENSAJE PROC
    PUSH AX
    MOV AH,09H
    INT 21H
    POP AX

    RET
MENSAJE ENDP

;igual a mensaje pero el servicio es 09 en vez de 09H ¿habra alguna diffeencia?
escribeCad PROC
    PUSH AX
    MOV  AH,09
    INT  21H
    POP  AX
    
    RET
escribeCad ENDP
;¿?
leercadena PROC
    PUSH DX
    PUSH AX
    LEA DX,CADENA
    MOV AH,0AH
    INT 21H
    POP AX
    POP DX
    
    RET
leercadena ENDP

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
limpiar_pantalla PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AX,0600h
    MOV BH,71h      ; FONDO BLANCO CON PRIMER PLANO AZUL
    MOV CX,0000H    ;coordenada inicial
    MOV DX,184FH    ;coordenada final
    INT 10h
    POP DX
    POP CX
    POP BX
    POP AX

    RET
limpiar_pantalla ENDP

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

;Para camiar el modo video
MODOVIDEO PROC
    ; modo de video 
    mov al, MODE 
    mov ah, 0 
    int 10h 

    RET
MODOVIDEO ENDP

;Entrada sin eco
READKEY PROC
    MOV AH,07H
    INT 21H
    RET 
READKEY ENDP

;¿?
GRAPH PROC
    MOV AH,00H
    MOV AL,12H
    INT 10H
    
    RET
GRAPH ENDP

;¿?
PUNTO PROC
    MOV AH,0CH
    MOV AL,COLOR
    MOV BH,0
    MOV CX,Y
    MOV DX,X
    INT 10H
    
    RET
PUNTO ENDP

;¿?
DOS PROC
    MOV AH,00H
    MOV AL,03H
    INT 10H
    
    RET
DOS ENDP

;Revisa que la tecla especial precionada 
PREINI PROC NEAR    
    MOV AH,10h
    INT 16H
    CMP AL,00H
    JE RASTREA
    CMP AL,0E0H
    JE RASTREA
    JMP SAL1
 RASTREA:
    CMP AH,53H  ;Código de rastreao de la tecla F12
    JNE SAL1
    MOV AH,02
    MOV BH,00
    MOV DX,0C27H
    INT 10H
    LEA DX,MEN
    MOV AH,09
    int 21h
 SAL1: RET
PREINI ENDP    