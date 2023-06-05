; Ejercicio 1 de la tarea del parcial3
.model small
.stack

.data
    ENTRADA DB 'CADENA DE ENTRADA: $'
    CADENA DB 100, ?, 100 DUP('$'),'$'
    SALIDA DB 'CADENA DE SALIDA:$'
.code
MAIN PROC FAR 
    PUSH DS
    SUB AX, AX
    PUSH AX
    MOV AX, @DATA
    MOV DS,AX
    
    ;INICIA EL PROGRAMA QUE LEE UNA CADENA DESDE EL TECLADO
    LEA DX, ENTRADA
    CALL escribe_cadena
    
    LEA DX, CADENA
    CALL leercadena
    CALL alimentar_linea
    
    LEA DX, SALIDA
    CALL escribe_cadena
    CALL alimentar_linea
    
    LEA SI, CADENA+2
LEER:
    MOV DL, [SI]
    CMP DL, 36
    JE FIN2
    CMP DL, 32
    JE ESP          ; COMPARA SI ES ESPACIO
    CALL escribe_car
    INC SI
    JMP LEER
    
ESP:                ; SI LO ES, SALTA
    CALL alimentar_linea
    INC SI
    JMP LEER 
    
    
FIN2:

RET
MAIN ENDP

; SUBRUTINAS -------------------------------
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

    

    
    sal_dos PROC
    MOV AH,4CH
    INT 21H
    RET
    sal_dos ENDP
    
     leercadena PROC
    PUSH AX
    MOV AH,0AH
    INT 21H
    POP AX
    RET
    leercadena ENDP
END MAIN
 
    
    
    
    
    
    
