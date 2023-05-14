;Programa que debe imprimir un mensaje en el centro arriba y en el centro abajo presinonando las teclas repag y avpag
.MODEL small
.STACK 100

.DATA
    CADENA DB 40, ?, 40 DUP('$'),'$'
    MSG    DB 'Ingresa una cadena: $'
    RCAD   DB 40 DUP ('$'),'$'
    TECLA  DB ?

.CODE
    MAIN PROC FAR 
        ;Protocolo
        PUSH DS
        SUB  AX,AX
        PUSH AX
        MOV  AX,@DATA
        MOV  DS,AX

        ;Start
               CALL graph
               LEA  DX,MSG
               CALL escribeCad
               CALL leerCadena     ;Lee una cadena y la guarda en buffer

               MOV  CL, CADENA + 1  ;Longitud de la cadena
               SUB  CH,CH           ;Vaciamos CH
               LEA  SI, CADENA + 2  ;Apunta al inicio de la cadena que se leyó
               ADD  SI,CX           ;Apuntamos al final de la cadena
               LEA  DI, RCAD        ;Apunta al inicio de lo que sera el mensaje invertido
               DEC  SI              ;Como apunta a un '$' se lo quitamos
        
        CICLO: MOV  BL,[SI]
               MOV  [DI],BL
               INC  DI              ;Hace referencia al incio de la nueva cadena a imprimir 
               DEC  SI              ;hacer referencia al final de la cadena leida
               LOOP CICLO
               CALL limpiarPantalla
        ;RKEY:  CALL keyStroke             

               RET

    MAIN ENDP 

    ;------------------------------------------ Subrutinas ------------------------------------------------------------

    graph PROC
        SUB AX,AX
        MOV AL,12H    ;Modo gráfico 640 x 480 
        INT 10H
    
        RET
    graph ENDP

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

    limpiarPantalla PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        MOV  AX,0600h    ;El servicio
        MOV  BH,71h      ;Fondo blanco con primer plano azul
        MOV  CX,0000H    ;coordenada inicial
        MOV  DX,254FH    ;coordenada final |parte alta (Renglones)|parte baja (columnas)|
        INT  10h
        POP  DX
        POP  CX
        POP  BX
        POP  AX

        RET
    limpiarPantalla ENDP

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

    ;Posiciona el cursor para imprimir la cadena lo mas centrada posible
    centro PROC
        MOV AH,0
        MOV AL,CADENA + 1
        MOV BL,2
        DIV BL
        MOV DL,40   ;DL -> Columnas DH -> Filas
        SUB DL,AL

        RET
    centro ENDP

END MAIN    

