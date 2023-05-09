.model small
.stack 100

.data 
    CADENA DB 40, ?, 40 DUP('$'),'$' 
    MENSAJE1 DB 'Ingresa una cadena: $'
    MENSAJE_INVERTIDO DB 40 DUP ('$'),'$'
.code
MAIN PROC FAR 
    PUSH DS
    SUB AX, AX
    PUSH AX
    MOV AX, @DATA
    MOV DS,AX
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
    CALL limpiar_pantalla
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
    CALL limpiar_pantalla
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
    CALL limpiar_pantalla
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

MAIN ENDP
    escribe_cadena PROC
    PUSH AX
    MOV AH,09 ; La direccion se almacena en el registro Dx
    INT 21h
    POP AX
    RET
    escribe_cadena ENDP
    
    escribe_car PROC
    PUSH AX
    MOV AH,02 ; Caracter a desplegar almacenado en dl
    INT 21h
    POP AX
    RET
    escribe_car ENDP
    
    alimentar_linea PROC
    PUSH DX
    MOV DL,0Ah ; salto de l?nea
    CALL escribe_car
    MOV DL,0Dh ; retorno de carro
    CALL escribe_car
    POP DX
    RET
    alimentar_linea ENDP
    limpiar_pantalla PROC
    PUSH AX;RESGUARDAMOS
    PUSH BX;RESGUARDAMOS
    PUSH DX;RESGUARDAMOS
    MOV AX, 0600H ;EL SERVICIO
    MOV BH,00H;  EL COLOR DE FONDO
    MOV CX, 0H;INICIO DEL BORRADO DE PANTALLA  
    MOV DX, 184FH ;EL FINAL EN AMBOS
    INT 10H
    POP DX
    POP BX
    POP AX
    RET
    limpiar_pantalla ENDP
    
    centro PROC
    MOV AH, 0
    MOV AL,CADENA+1
    MOV BL,2
    DIV BL
    MOV DL,40
    SUB DL,AL
    RET
    centro ENDP
    
    sal_dos PROC
    MOV AH,4CH
    INT 21H
    RET
    sal_dos ENDP
    
    
END MAIN
 
    
    
    
    
    
    
