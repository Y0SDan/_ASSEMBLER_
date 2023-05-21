.MODEL small
.STACK 100

.DATA
    MSG1   DB 'Ingrese una cadena: $'
    LONACT DB ?                       ;Longitud actual
    CADENA DB 20,?, 20 DUP ("$"), "$"


.CODE
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB  AX,AX
        PUSH AX
        MOV  AX,@DATA
        MOV  DS,AX
        MOV  ES,AX     ;ES -> segmento de dato extra (¿para que? no se .-.)

        ;Start
        LEA  DX,MSG1
        CALL escribeCad

        RET

    MAIN ENDP
    ;sUBRUTINAS-------------------------------------------------------------

    ;Escribe cadena en terminal, la cadena debe de estar en DX
    escribeCad PROC
        PUSH AX
        MOV  AH,09H
        INT  21H
        POP  AX
    
        RET
    escribeCad ENDP

    ;Lee una cadena de caracteres utilizando el buffer, la cadena debe de estar declarada en el .DATA
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

    salta PROC
        PUSH DX
        MOV  DL, 0AH
        CALL escribeChar
        MOV  DL, 0DH
        CALL escribeChar
        POP  DX
    
        RET
    salta ENDP

    ;Escrbe un caracater en pantalla (el caracter debe estar en DL)
    escribeChar PROC
        PUSH AX
        MOV  AH,02 ; Caracter a desplegar almacenado en dl
        INT  21h
        POP  AX

        RET
    escribeChar ENDP

END MAIN
