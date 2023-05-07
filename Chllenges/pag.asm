;Programa que debe imprimir un mensaje 
;en el centro arriba y en el centro abajo
;presinonando las teclas repag y avpag

;Definicion de stack
.MODEL small
.STACK 100

;Definicion areas de trabajo
.DATA
    ;Variables
    CADENA DB 40,?,40 DUP('$'),'$'
    MSG    DB 'Ingrese su cadena: $'
    MSGR   DB 40 DUP('$'),'$' 

.CODE   
    MAIN PROC FAR
        ;Protocolo
        PUSH DS
        SUB AX,AX    
        PUSH AX
        MOV AX,@DATA
        MOV DS,AX

        ;INICIA PROGRAMA
        ;-----------------------------
        LEA DX,MSG
        CALL escribeCad
        ;-----------------------------
        LEA DX,CADENA
        MOV AH,0AH                    ;Leer con buffer (de teclado)
        INT 21H
        ;----------------------------------------------------
        
                                
        CICLO:
        MOV BL,[SI]
        MOV [DI],BL
        INC DI
        DEC SI
        LOOP CICLO
;------------------------------------------------------------
        CALL salta
        LEA DX, MSGR
        CALL escribeCad
        RET
;-------------------- Subrutinas ------------------------------;

        ;Imprime a reves
        alRev
        PUSH CX
        PUSH SI
        PUSH DI
        PUSH DX
        MOV CL,CADENA + 1
        MOV CH,0
        LEA SI,CADENA + 2
        ADD SI,CX
        LEA DI,MSGR
        DEC SI
        POP CX
        POP SI
        POP DI
        POP DX        
        ;Escribe Cadena (en consola)
        escribeCad PROC
            PUSH AX
            MOV AH,09                     
            INT 21H
            POP AX
            RET
        escribeCad ENDP    
            
        ;salto de linea y retorno de carro
        salta PROC
            PUSH DX
            MOV  DL,0AH
            CALL escribeChar
            MOV  DL,0DH
            CALL escribeChar
            POP  DX
            RET
        salta ENDP

        escribeChar PROC ;
            PUSH AX
            MOV  AH,02
            INT  21H
            POP  AX
            RET
        escribeChar ENDP  

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

    MAIN ENDP
    END MAIN 
        