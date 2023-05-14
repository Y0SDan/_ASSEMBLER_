escribeChar PROC
    PUSH AX
    MOV  AH,02 
    INT  21h
    POP  AX

    RET
escribeChar ENDP

SALIR_DOS PROC
   MOV AH,4CH
   INT 21H

   RET
SALIR_DOS ENDP

escribeCad PROC
    PUSH AX
    MOV  AH,09H
    INT  21H
    POP  AX
    
    RET
escribeCad ENDP

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

leeChar_conEco PROC
    PUSH AX
    MOV  AH,01
    INT  21H
    POP  AX
            
    RET
leeChar_conEco ENDP

LEER_CSE PROC
    MOV AH,08
    INT 21H

    RET
LEER_CSE ENDP

salta PROC
    PUSH DX
    MOV  DL, 0AH
    CALL escribeChar
    MOV  DL, 0DH
    CALL escribeChar
    POP  DX
    
    RET
salta ENDP

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

binario_ascii PROC
         CMP DL,9h
         JG  SUMA37
         ADD DL,30h
         JMP FIN2
 SUMA37: ADD DL,37h
 
 FIN2: RET
binario_ascii ENDP

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

POS_CUR PROC
    PUSH AX
    PUSH BX
    PUSH DX
    MOV AH,02
    MOV BH,0
    MOV DH,RENGLON 
    MOV DL,COLUMNA 
    INT 10h
    POP DX
    POP BX
    POP AX

    RET
POS_CUR ENDP

limpiarPantalla PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV  AX,0600h  
    MOV  BH,71h    
    MOV  CX,0000H  
    MOV  DX,184FH  
    INT  10h
    POP  DX
    POP  CX
    POP  BX
    POP  AX

    RET
limpiarPantalla ENDP

Despliega9 PROC
    PUSH BX
    PUSH CX
    MOV AH,09 
    MOV BH,00
    MOV BL, ATRIBUTO
    MOV CX, NUMERO
    INT 10H
    POP CX
    POP BX

    RET
Despliega9 ENDP

SEMILLA PROC
    PUSH AX
    MOV AH,2CH
    INT 21H 
    POP AX

    RET
SEMILLA ENDP

ALEATORIO PROC


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
ALEATORIO ENDP


ESCALANDO PROC

   MOV DX,0
   MOV BX,00FFH 
   DIV BX
   MOV AX,DX
   mov dl,ah
   call desempaqueta
   mov dl,al
   call desempaqueta
   ret
   
   RET
ESCALANDO ENDP


PIXEL PROC

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

ACTUAL PROC
    MOV AH,0Fh
    INT 10H
    
    RET
ACTUAL ENDP

READKEY PROC
    MOV AH,07H
    INT 21H
    RET 
READKEY ENDP

graph PROC
    SUB AX,AX
    MOV AL,12H 
    INT 10H
    
    RET
graph ENDP

PUNTO PROC
    MOV AH,0CH      
    MOV AL,COLOR    
    MOV BH,0      
    MOV CX,Y        
    MOV DX,X
    INT 10H
    
    RET
PUNTO ENDP

DOS PROC
    MOV AH,00H
    MOV AL,03H
    INT 10H
    
    RET
DOS ENDP

keyStroke PROC NEAR    
        MOV AH,10h
        INT 16H
        CMP AL,00H
        JE  YES
        CMP AL,0E0H
        JE  YES
        JMP BYE
 YES:   CMP AH,TECLA 
        JNE BYE
        MOV AH,02
        MOV BH,00
 BYE:   RET
keyStroke ENDP      